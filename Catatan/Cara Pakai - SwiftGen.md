**SwiftGen** itu adalah tool penyelamat hidup developer iOS supaya **stop pakai "String Hardcode"** waktu akses resource (Gambar, Warna, Font, Localization).

Singkatnya: **SwiftGen mengubah Resource file kamu menjadi Kode Swift (Enum/Struct).**

Ini bedanya "Hidup Tanpa SwiftGen" vs "Hidup Pakai SwiftGen":

### 1. Contoh Kasus: Ambil Gambar (Assets.xcassets)

**❌ Tanpa SwiftGen (Cara Lama):**
Rawan typo dan crash. Kalau nama file diganti designer, aplikasi bisa crash/kosong.

```swift
// Kalau typo "IcHome" jadi "IconHome", aplikasi gak error tapi gambar hilang!
let image = UIImage(named: "IcHome") 

```

**✅ Pakai SwiftGen:**
Aman, ada Autocomplete, dan kalau file dihapus/rename, kodingan **Error (Merah)** jadi lu tau harus dibenerin.

```swift
// Lu tinggal ketik Asset... langsung muncul pilihannya
let image = Asset.Icons.icHome.image

```

---

### 2. Contoh Kasus: Warna (Colors.xcassets)

**❌ Tanpa SwiftGen:**

```swift
view.backgroundColor = UIColor(named: "BrandPrimary") // String lagi...

```

**✅ Pakai SwiftGen:**

```swift
view.backgroundColor = Asset.Colors.brandPrimary.color

```

---

### 3. Contoh Kasus: Bahasa/Localization (Localizable.strings)

Ini yang paling kerasa manfaatnya.

**❌ Tanpa SwiftGen:**

```swift
titleLabel.text = NSLocalizedString("login_screen_title", comment: "")

```

**✅ Pakai SwiftGen:**

```swift
// Langsung jadi function/property
titleLabel.text = L10n.loginScreenTitle

```

---

### Kenapa Lu Butuh Ini (Apalagi pake Modularization)?

Karena lu pake struktur modular (`XAuthKit`, `XAuthUIKit`), akses resource itu ribet kalau manual.

Tanpa SwiftGen, lu harus kasih tau bundlenya secara eksplisit:

```swift
// Ribet, harus tau bundle-nya dimana
UIImage(named: "Logo", in: Bundle(for: XAuthUIKit.self), compatibleWith: nil)

```

Dengan SwiftGen, dia otomatis generate kode yang **pinter** deteksi Bundle module-nya sendiri. Jadi di dalam `XAuthUIKit`, lu tinggal panggil:

```swift
Asset.Logo.image // SwiftGen udah urus logic bundle di belakang layar

```

### Apa yang Bisa Di-generate?

1. **Images** (`Assets.xcassets`)
2. **Colors**
3. **Strings** (Localization)
4. **Fonts**
5. **CoreData Models**
6. **JSON/YAML** files

### Kesimpulan

Kalau **SwiftLint** itu polisi buat **kerapian kode**,
**SwiftGen** itu robot buat **menghilangkan typo string** di resource.
