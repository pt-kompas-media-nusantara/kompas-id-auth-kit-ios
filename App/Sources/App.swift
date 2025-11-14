
import SwiftUI
@_exported import UICore

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
