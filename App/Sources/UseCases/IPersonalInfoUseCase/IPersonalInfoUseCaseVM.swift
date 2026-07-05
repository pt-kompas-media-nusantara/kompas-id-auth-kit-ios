import Foundation
import FactoryKit
import XAuthKit

@MainActor
final class IPersonalInfoUseCaseVM: ObservableObject {
    @Injected(\.personalInfoService) private var personalInfoService
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Mengambil data informasi pribadi menggunakan KMP PersonalInfoUseCase
    func execute() async {
        isLoading = true
        do {
            let result = try await personalInfoService.fetchUserDataParallely()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
