// swift-tools-version:5.9
// ===================================================================
// 📦 Swift Package Manager (SPM) Manifest - XAuthKitCore
// ===================================================================
// Berkas ini berfungsi sebagai "KTP/Manifest" resmi agar library SDK ini
// bisa di-import oleh aplikasi iOS lain menggunakan Swift Package Manager.
//
// CATATAN DEVELOPER:
//   - Berkas ini HANYA dibaca oleh aplikasi integrator luar saat mengunduh SDK.
//   - Pembangunan lokal & aplikasi demo dikelola menggunakan XcodeGen (project.yml).
// ===================================================================

import PackageDescription

let package = Package(
    // 1. Nama dari paket library koleksi Anda secara keseluruhan
    name: "XAuthKitCore",
    
    // 2. Batasan platform iOS minimum yang didukung agar bisa menggunakan SDK ini
    platforms: [
        .iOS(.v16) // Diselaraskan dengan deployment target iOS 16.0
    ],
    
    // 3. Produk (Library) yang diekspos keluar agar bisa di-import oleh aplikasi lain.
    //    Developer luar dapat mengimpor salah satu atau seluruh produk di bawah ini.
    products: [
        .library(
            name: "XAuthUIKit",
            targets: ["XAuthUIKit"]),
        .library(
            name: "XAuthCommunicationsKit",
            targets: ["XAuthCommunicationsKit"]),
        .library(
            name: "XAuthKit",
            targets: ["XAuthKit"])
    ],
    
    // 4. Dependensi Paket Eksternal (SPM packages dari pihak ketiga)
    //    Seluruh library luar (seperti Firebase) yang diunduh langsung dari repositori Git.
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.6.0"),
        .package(url: "https://github.com/SimplyDanny/SwiftLintPlugins", exact: "0.62.2")
    ],
    
    // 5. Target Modul Internal Proyek
    //    Mendefinisikan setiap folder modul, dependensi internal/eksternalnya, serta plugin.
    targets: [
        // A. Target UI (XAuthUIKit) - Khusus untuk visual komponen & tema
        .target(
            name: "XAuthUIKit",
            dependencies: [], // Bersih dari dependensi luar untuk efisiensi
            path: "XAuthUIKit/Sources",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),        
        // B. Target Komunikasi Data (XAuthCommunicationsKit) - Khusus untuk API request
        .target(
            name: "XAuthCommunicationsKit",
            dependencies: [], // Bersih dari dependensi visual/UI
            path: "XAuthCommunicationsKit/Sources",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        ),        
        // C. Target Orkestrator/Core (XAuthKit) - Logika bisnis & penggabung modul UI/Comm
        .target(
            name: "XAuthKit",
            dependencies: [
                "XAuthUIKit",             // Membutuhkan target UI
                "XAuthCommunicationsKit"  // Membutuhkan target API
            ],
            path: "XAuthKit/Sources",
            plugins: [
                .plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLintPlugins")
            ]
        )
        
        // CATATAN: Target aplikasi utama 'App' tidak dimasukkan di sini,
        // karena berkas ini hanya untuk mendistribusikan library (SDK).
    ]
)
