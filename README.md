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

---

## 🚀 Instalasi & Penggunaan

### Kloning Repository

Gunakan perintah berikut untuk mengkloning proyek ini:

```bash
git clone [https://github.com/pt-kompas-media-nusantara/kompas-id-auth-kit-ios.git](https://github.com/pt-kompas-media-nusantara/kompas-id-auth-kit-ios.git)
