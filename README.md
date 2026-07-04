# 🆔 kompas-id-auth-kit-ios

**Kompas ID Auth Kit untuk iOS** adalah *framework* atau *library* yang didesain untuk memfasilitasi integrasi otentikasi (login/register) Kompas ID di aplikasi iOS. Proyek ini dikelola menggunakan **XcodeGen** untuk otomatisasi dan standardisasi proyek Xcode.

## 🛠️ Persyaratan Proyek

Proyek ini menggunakan **XcodeGen** untuk manajemen dan pembuatan file `.xcodeproj`. Pastikan lu sudah menginstal XcodeGen sebelum memulai.

| Tools / Dependency | Versi Rekomendasi | Keterangan |
| :--- | :--- | :--- |
| **XcodeGen** | Terbaru | Alat untuk meng-*generate* proyek Xcode dari file `project.yml`. |
| **Minimum Deployment Target** | iOS 16.0+ | (Asumsi) |

---

## ⚙️ Konfigurasi Proyek (XcodeGen)

Konfigurasi proyek dikelola melalui file **`project.yml`**.

### Bundle Identifier

*Bundle Identifier* utama untuk aplikasi yang menggunakan *kit* ini adalah:

Pengaturan ini didefinisikan secara eksplisit di dalam `project.yml` pada bagian *target* yang relevan, menggunakan variabel **`PRODUCT_BUNDLE_IDENTIFIER`**.

### Sumber Referensi

Untuk panduan lebih lanjut mengenai struktur dan konfigurasi XcodeGen, lu bisa merujuk ke dokumentasi dan artikel berikut:

* **Dokumentasi Resmi XcodeGen:**
    * [https://github.com/yonaskolb/XcodeGen](https://github.com/yonaskolb/XcodeGen)
* **Panduan Mendalam XcodeGen:**
    * [XcodeGen: First Steps](https://medium.com/@daviddvd19/xcodegen-first-steps-%EF%B8%8F-a2d4655ced86)
    * [XcodeGen: Getting Deeper](https://medium.com/@daviddvd19/xcodegen-getting-deeper-2932474a5b59)
    * [XcodeGen & SwiftGen: Optimized](https://medium.com/@pj.gilangsinawang/optimizing-your-ios-project-setup-with-xcodegen-and-swiftgen-b3fcb97e1773)
    * [Fastlane x Github Action CICD 1](https://litoarias.medium.com/continuous-delivery-for-ios-using-fastlane-and-github-actions-edf62ee68ecc)
    * [Fastlane x Github Action CICD 2](https://www.runway.team/blog/how-to-set-up-a-ci-cd-pipeline-for-your-ios-app-fastlane-github-actions)

---

## 🚀 Instalasi & Penggunaan

### Kloning Repository

git clone [https://github.com/pt-kompas-media-nusantara/kompas-id-auth-kit-ios.git](https://github.com/pt-kompas-media-nusantara/kompas-id-auth-kit-ios.git)

---

## 📖 Cara Membaca Dokumentasi (Live Preview)

Proyek ini dilengkapi dengan panduan arsitektur dan sistem modular lengkap di folder `Documentation/` dalam format Markdown (`.md`). Agar lebih mudah dibaca lengkap dengan grafik dan tabel, Anda dapat membuka **Live Preview** bawaan IDE secara lokal:

### 1. Di VS Code (Antigravity IDE)
Buka berkas dokumentasi, lalu gunakan opsi berikut:
* **Shortcut Preview Tab:** Tekan **`Cmd + Shift + V`** (macOS).
* **Shortcut Side-by-Side (Berdampingan):** Tekan **`Cmd + K`**, lalu lepas dan tekan **`V`**.
* **Menggunakan Tombol UI:** Klik tombol **"Open Preview to the Side"** di pojok kanan atas editor tab (ikon kertas terbagi dengan kaca pembesar).

### 2. Di Xcode (Xcode 15+)
Buka berkas `.md` di Xcode, lalu aktifkan render markup otomatis:
* **Lewat Menu Bar:** Pilih menu **`Editor`** -> **`Show Rendered Markup`**.
* **Lewat File Navigator:** Klik kanan berkas `.md` di sidebar Xcode, pilih **`Open As`** -> **`Rendered Documentation`**.

---

## 📂 Berkas Dokumentasi Utama
* 📐 **[Panduan Arsitektur & Diagram Alur](Documentation/ARCHITECTURE_GUIDE.md)**
* 💉 **[Panduan & Keputusan Dependency Injection](Documentation/DEPENDENCY_INJECTION.md)**

