# 💉 Panduan & Keputusan Dependency Injection (DI) - XAuth SDK

Dokumen ini menjelaskan arsitektur **Dependency Injection (DI)** yang digunakan di dalam proyek **XAuth iOS SDK**, alasan teknis pemilihan library **Factory**, serta cara pemeliharaan dan pengujian kode bagi developer.

---

## 🧐 1. Mengapa Kita Menggunakan Dependency Injection (DI)?

Di dalam arsitektur modular **XAuth**, kita memisahkan UI (`XAuthUIKit`), Logika Bisnis (`XAuthKit`), dan Jaringan (`XAuthCommunicationsKit`). 

Tanpa DI, modul bisnis harus membuat instance kelas jaringan secara langsung:
```swift
// ❌ BURUK: Tight Coupling (Ketergantungan Erat)
let repository = ModelRepositoryImpl()
```
Hal ini membuat:
1. Modul saling terkunci rapat.
2. Unit Testing mustahil dilakukan tanpa memicu API asli (karena kita tidak bisa menukar `ModelRepositoryImpl` dengan `MockModelRepository`).

Dengan DI, kita mendefinisikan Protokol (Domain) dan menyuntikkan (*inject*) implementasinya secara dinamis:
```swift
// ✅ BAGUS: Loose Coupling (Ketergantungan Longgar)
@Injected(\.modelRepository) var repository: ModelRepository
```

---

## ⚖️ 2. Keputusan Arsitektur: Mengapa Memilih Library Factory v3?

Ketika merancang DI untuk SDK, kami mengevaluasi tiga opsi utama:

### Opsi A: Manual DI (Constructor Injection Murni)
* **Kelebihan:** Tanpa library pihak ketiga, 100% aman.
* **Kekurangan:** Jika proyek sangat besar, akan terjadi *“Initialization Hell”* di mana inisialisator kelas menjadi berantai sangat panjang dan sulit dirawat (`init(a: init(b: init(c: ...)))`).

### Opsi B: Swinject (Service Locator Tradisional)
* **Kelebihan:** Sangat populer di proyek iOS lama.
* **Kekurangan:** Resolusi dependensi terjadi saat *runtime*. Jika developer lupa mendaftarkan suatu kelas, aplikasi akan langsung **crash di tangan pengguna** saat membuka halaman tersebut. Selain itu, kurang ramah terhadap Swift 6 strict concurrency.

### Opsi C: Factory v3 (Opsi Terpilih)
Kita memilih **Factory (versi 3.2.1)** karena alasan teknis berikut:
1. **Compile-Time Safe:** Eror registrasi diverifikasi langsung saat kompilasi. Jika KeyPath salah atau tipe data tidak cocok, proyek gagal di-build.
2. **Swift 6 & Concurrency Ready:** Dibangun menggunakan fitur modern Swift (Macros & property wrappers), aman dari *data race*, dan mendukung isolasi `@MainActor` secara bawaan.
3. **Pemisahan Modul Sempurna (Encapsulation):** Kita dapat menyembunyikan kelas implementasi konkret sebagai `internal` di modul asalnya (misal: `ModelRepositoryImpl` di `XAuthCommunicationsKit`), namun modul luar tetap bisa me-resolve-nya sebagai tipe protokol `ModelRepository` secara publik.

### ⚡ 2.4 Perbandingan Sisi Performa (Performance Analysis)

Performa adalah parameter kritis untuk sebuah SDK guna meminimalkan jejak memori (*memory footprint*) dan waktu startup aplikasi (*app startup time*).

| Parameter Performa | Opsi A: Manual DI | Opsi B: Swinject | Opsi C: Factory v3 |
| :--- | :--- | :--- | :--- |
| **Startup Overhead (App Launch)** | **Nol (0 ms)** | **Tinggi:** Harus melakukan registrasi dictionary dinamis dan alokasi heap saat start. | **Sangat Rendah:** Menggunakan registrasi statis *lazy evaluation* (hanya dialokasikan saat pertama kali diakses). |
| **Resolution Speed** | **Seketika (O(1))** | **Lambat:** Melakukan *reflection*, pencarian string hashing di dictionary, dan penguncian thread (*thread lock*). | **Cepat (Hampir Setara Manual):** Menggunakan Swift `KeyPath` yang dioptimalkan oleh LLVM compiler secara statis tanpa dictionary lookup. |
| **Memory Footprint** | **Nol (0 KB)** | **Tinggi:** Menyimpan struktur kontainer dinamis, metadata tipe data, dan objek lock di memori. | **Sangat Rendah:** Hanya menyimpan objek Factory kecil, pemakaian memori sebanding dengan Manual DI. |

Dengan demikian, Factory v3 memberikan performa yang hampir menyamai kecepatan **Manual DI (murni Swift compiler)** dengan efisiensi jauh di atas Swinject.

---

## 🛠️ 3. Cara Menggunakan DI di Proyek Ini

### Langkah 1: Registrasikan Dependensi
Di modul asal tempat kelas itu berada (misal di `XAuthCommunicationsKit`), daftarkan dependensinya ke dalam extension `Container` Factory:
```swift
// Di dalam XAuthCommunicationsKit/Sources/DI/CommunicationsDI.swift
import FactoryKit

extension Container {
    // Mengekspos secara publik tipe protokolnya, namun menginstansiasi kelas internalnya
    public var modelRepository: Factory<ModelRepository> {
        self { ModelRepositoryImpl() }
    }
}
```

### Langkah 2: Suntikkan Dependensi (Inject)
Di modul konsumen (misal di ViewModel aplikasi utama `App`), suntikkan menggunakan property wrapper `@Injected`:
```swift
// Di dalam App/Sources/Home/DashboardView.swift
import FactoryKit
import XAuthCommunicationsKit

class DashboardViewModel: ObservableObject {
    // Otomatis ter-resolve ke ModelRepositoryImpl
    @Injected(\.modelRepository) private var modelRepository
}
```

---

## 🧪 4. Cara Menulis Unit Test dengan DI (Mocking)

Salah satu keunggulan terbesar Factory adalah kemudahan menukar objek asli dengan objek palsu (*Mock*) saat pengujian unit test berlangsung:

```swift
import XCTest
import FactoryKit
@testable import XAuthCommunicationsKit

final class AuthViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // 1. Daftarkan implementasi Mock sebelum test berjalan
        Container.shared.modelRepository.register {
            MockModelRepository(mockValue: 99)
        }
    }
    
    override func tearDown() {
        // 2. Kembalikan registrasi container ke semula setelah test selesai
        Container.shared.modelRepository.reset()
        super.tearDown()
    }
    
    func testLoadData() async throws {
        // ViewModel otomatis akan menggunakan MockModelRepository
        let viewModel = DashboardViewModel()
        viewModel.loadRepositoryData()
        
        // Verifikasi hasil mock...
    }
}
```
