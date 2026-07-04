import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IAuthUseCaseVM: ObservableObject {
    @Injected(\.authUseCase) private var authUseCase
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Memeriksa status pengguna melalui purchase token menggunakan KMP AuthUseCase
    func execute() async {
        isLoading = true
        do {
            let result = try await authUseCase.checkUserByPurchaseToken()
            resultText = "KMP AuthUseCase sukses!\nHasil: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
