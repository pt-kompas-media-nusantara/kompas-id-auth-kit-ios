import Foundation
import FactoryKit
import XAuthCommunicationsKit
import XAuthKit

@MainActor
final class RootVM: ObservableObject {
    @Published private(set) var appVersion: String = ""
    @Published private(set) var osVersion: String = ""
    @Published private(set) var flavorName: String = ""
    @Published private(set) var repositoryValue: String = "Loading..."
    
    // Suntikkan dependensi menggunakan Property Wrapper Factory
    @Injected(\.modelRepository) private var modelRepository

    init() {
        // Panggil properti tersentralisasi yang murni dari BuildConfiguration (Domain Layer)
        self.appVersion = BuildConfiguration.appVersion
        self.osVersion = BuildConfiguration.osVersion
        self.flavorName = BuildConfiguration.flavorDisplayName
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
}
