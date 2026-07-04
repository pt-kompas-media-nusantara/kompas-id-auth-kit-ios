import Foundation

public enum AppFlavor {
    case development    // Staging + Debug (Sehari-hari developer)
    case uat            // Staging + Release (QA Testing performa asli)
    case production     // Production + Release (App Store / User Asli)
    case diagnostic     // Production + Debug (Jarang, tapi berguna buat debug data production)
}

// Enum biar type-safe dan gak typo String manual
public enum AppEnvironment: String {
    case staging = "STAGING"
    case production = "PRODUCTION"
    case unknown = "UNKNOWN"
}

public enum AppBuildMode: String {
    case debug = "DEBUG"
    case release = "RELEASE"
}

public struct BuildConfiguration {
    
    // 1. Cek Environment (Staging vs Production)
    public static var environment: AppEnvironment {
        #if STAGING
        return .staging
        #elseif PRODUCTION
        return .production
        #else
        return .unknown
        #endif
    }
    
    // 2. Cek Mode (Debug vs Release)
    // Tips: Biasanya Xcode tidak mendefinisikan flag 'RELEASE',
    // jadi logic terbaik adalah: Jika bukan DEBUG, maka itu RELEASE.
    public static var mode: AppBuildMode {
        #if DEBUG
        return .debug
        #else
        return .release
        #endif
    }
    
    // 3. Helper Variable (Opsional, biar coding lebih enak)
    public static var isDebug: Bool { mode == .debug }
    public static var isProduction: Bool { environment == .production }
    
    // 4. Formatted Description (Untuk keperluan Log seperti request kamu)
    public static var fullDescription: String {
        return "\(environment.rawValue) - \(mode.rawValue)"
    }
    
    // 5. Handling case kombinasi khusus (pengganti logic PRODUCTION_DEBUG dll)
    public static func logCurrentConfig() {
        let tag = "[BuildConfig]"
        
        // Logika gabungan yang lebih bersih daripada nested #if
        switch (environment, mode) {
        case (.production, .debug):
            print("\(tag) App PRODUCTION_DEBUG")
        case (.production, .release):
            print("\(tag) App PRODUCTION_RELEASE")
        case (.staging, .debug):
            print("\(tag) App STAGING_DEBUG")
        case (.staging, .release):
            print("\(tag) App STAGING_RELEASE")
        default:
            print("\(tag) App UNKNOWN Configuration")
        }
    }

    public static var currentFlavor: AppFlavor {
        switch (environment, mode) {
        case (.staging, .debug):
            return .development
            
        case (.staging, .release):
            return .uat
            
        case (.production, .release):
            return .production
            
        case (.production, .debug):
            return .diagnostic
            
        default:
            return .production // Fallback paling aman
        }
    }
    
    // 6. Dapatkan versi OS menggunakan Foundation ProcessInfo (Bebas UIKit)
    public static var osVersion: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "\(version.majorVersion).\(version.minorVersion).\(version.patchVersion)"
    }
    
    // 7. Dapatkan versi aplikasi (Short Version + Build Number) dari Bundle Info
    public static var appVersion: String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "1"
        return "\(version) (\(build))"
    }
    
    // 8. Dapatkan nama flavor deskriptif
    public static var flavorDisplayName: String {
        switch currentFlavor {
        case .development:
            return "Development (Staging Debug)"
        case .uat:
            return "UAT (Staging Release)"
        case .production:
            return "Production (Production Release)"
        case .diagnostic:
            return "Diagnostic (Production Debug)"
        }
    }
}