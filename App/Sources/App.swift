
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
        }
    }
}
