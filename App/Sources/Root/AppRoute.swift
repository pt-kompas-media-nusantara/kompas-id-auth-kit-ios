import Foundation

/// Rute halaman type-safe untuk navigasi aplikasi
enum AppRoute: Hashable {
    case auth
    case launchApp
    case authAndSync
    case personalInfo
    case analytics
    case articles
    case settings
    case subscription
    case supportApp
    case supportSystem
}
