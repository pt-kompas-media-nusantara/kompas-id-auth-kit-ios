// swift-tools-version:5.9
import PackageDescription

// Ini adalah "KTP" untuk library Anda saat dilihat dari luar
let package = Package(
    name: "KompasIdAuthKit", // Nama koleksi library Anda
    platforms: [
        .iOS(.v16) // Ambil dari settings: IPHONES_DEPLOYMENT_TARGET: 16.0 [project.yml]
    ],
    
    // Ini adalah produk (library) yang bisa diimpor proyek lain
    products: [
        .library(
            name: "UICore",
            targets: ["UICore"]),
        .library(
            name: "CommunicationsCore",
            targets: ["CommunicationsCore"])
    ],
    
    // Masukkan SEMUA dependency SPM Anda di sini
    // (Firebase, dll. dari 'packages.yml')
    dependencies: [
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.6.0")
        // ... tambahkan yang lain jika ada
    ],
    
    // Ini adalah definisi "target" library Anda
    targets: [
        .target(
            name: "UICore",
            dependencies: [], // Jika UICore butuh Firebase, tambahkan di sini
            path: "UICore/Sources"
            // Kita tidak perlu .process("Resources")
            // jika 'Resources' ada di dalam 'Sources'
        ),
        
        .target(
            name: "CommunicationsCore",
            dependencies: [
                // Contoh jika CommCore butuh Firebase & UICore
                // .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk"),
                // .target(name: "UICore")
            ],
            path: "CommunicationsCore/Sources"
        )
        
        // Kita TIDAK memasukkan 'App' di sini,
        // karena 'App' BUKAN library.
    ]
)