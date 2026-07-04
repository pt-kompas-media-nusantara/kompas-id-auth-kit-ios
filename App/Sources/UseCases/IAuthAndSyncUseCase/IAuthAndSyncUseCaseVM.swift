import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IAuthAndSyncUseCaseVM: ObservableObject {
    @Injected(\.authAndSyncUseCase) private var authAndSyncUseCase
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Mengeksekusi sinkronisasi otentikasi menggunakan KMP AuthAndSyncUseCase
    func execute() async {
        isLoading = true
        do {
            let result = try await authAndSyncUseCase.loginByPurchaseToken()
            resultText = "KMP AuthAndSyncUseCase sukses!\nHasil: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
