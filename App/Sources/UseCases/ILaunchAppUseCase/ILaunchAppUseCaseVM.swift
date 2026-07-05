import FactoryKit
import Foundation
import XAuthKit

@MainActor
final class ILaunchAppUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    private let launchAppService: any LaunchAppService

    init(
        launchAppService: any LaunchAppService = Container.shared.launchAppService()
    ) {
        self.launchAppService = launchAppService
    }

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func execute() async {
        isLoading = true
        do {
            let result = try await launchAppService.execute()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
