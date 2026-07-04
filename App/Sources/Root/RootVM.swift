import Foundation
import Combine
import FactoryKit
import XAuthCommunicationsKit
import XAuthKit

@MainActor
final class RootVM: ObservableObject {
    @Published private(set) var appVersion: String = ""
    @Published private(set) var osVersion: String = ""
    @Published private(set) var flavorName: String = ""
    @Published private(set) var repositoryValue: String = "Loading..."
    
    // Injeksi dependensi
    @Injected(\.modelRepository) private var modelRepository
    @Injected(\.appRouter) var router: AppRouter
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Panggil properti tersentralisasi yang murni dari BuildConfiguration (Domain Layer)
        self.appVersion = BuildConfiguration.appVersion
        self.osVersion = BuildConfiguration.osVersion
        self.flavorName = BuildConfiguration.flavorDisplayName
        
        // Mengamati perubahan pada path router singleton dan meneruskannya ke RootVM
        // agar RootView dapat merespon navigasi dengan tepat tanpa perlu menginjeksi router sendiri.
        router.$path
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    func loadRepositoryData() {
        Task {
            do {
                let model = try await modelRepository.data()
                self.repositoryValue = "\(model.value)"
            } catch {
                self.repositoryValue = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    /// Memicu navigasi halaman dari ViewModel ke rute tertentu
    func navigate(to route: AppRoute) {
        router.navigate(to: route)
    }
}
