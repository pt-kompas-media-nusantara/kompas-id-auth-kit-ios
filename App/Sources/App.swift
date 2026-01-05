
import SwiftUI
@_exported import XAuthKit

@main
struct App: SwiftUI.App {
    
    init() {
        Task {
            await FirebaseConfigurationImpl.create().configure()
        }
    }
    
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear {
                    setupConfiguration()
                    SwiftLintTest().triggerWarnings()
                    SwiftLintTest().triggerError()
                }
        }
    }
    
    func setupConfiguration() {
        // CONTOH PENGGUNAAN:
        // Cukup panggil BuildConfiguration.currentFlavor
        // Tidak perlu callback/closure.
        
        switch BuildConfiguration.currentFlavor {
        case .development:
            print("👨‍💻 Setup untuk Developer (Log aktif, API Dev)")
            // Setup tools debug khusus dev...
            
        case .uat:
            print("🧪 Setup untuk QA (Log minimal, API Dev)")
            // Setup tools reporting crash...
            
        case .production:
            print("🚀 Setup untuk App Store (Log mati, API Prod)")
            // Nyalakan Analytics beneran...
            
        case .diagnostic:
            print("🚑 Setup Debug Production")
        }
    }
}

