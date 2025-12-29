// swift-tools-version:5.9
import PackageDescription

// Ini adalah "KTP" untuk library Anda saat dilihat dari luar
let package = Package(
    name: "XAuthKitCore", // Nama koleksi library Anda
    platforms: [
        .iOS(.v16) // Ambil dari settings: IPHONES_DEPLOYMENT_TARGET: 16.0 [project.yml]
    ],
    
    // Ini adalah produk (library) yang bisa diimpor proyek lain
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
    
    // Masukkan SEMUA dependency SPM Anda di sini
    // (Firebase, dll. dari 'packages.yml')
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.6.0"),
        .package(url: "https://github.com/realm/SwiftLint", exact: "0.62.2")
        // ... tambahkan yang lain jika ada
    ],
    
    // Ini adalah definisi "target" library Anda
    targets: [
        .target(
            name: "XAuthUIKit",
            dependencies: [], // Jika XAuthUIKit butuh Firebase, tambahkan di sini
            path: "XAuthUIKit/Sources",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
            // Kita tidak perlu .process("Resources")
            // jika 'Resources' ada di dalam 'Sources'
        ),        
        .target(
            name: "XAuthCommunicationsKit",
            dependencies: [
                // Contoh jika CommCore butuh Firebase & XAuthUIKit
                // .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                // .target(name: "XAuthUIKit")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
            path: "XAuthCommunicationsKit/Sources"
        ),        
        .target(
            name: "XAuthKit",
            dependencies: [
                // Contoh jika CommCore butuh Firebase & XAuthKit
                // .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                // .target(name: "XAuthKit")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
            path: "XAuthKit/Sources"
        )
        
        // Kita TIDAK memasukkan 'App' di sini,
        // karena 'App' BUKAN library.
    ]
)