
import SwiftUI
@_exported import AuthKitCore

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
        }
    }
}
