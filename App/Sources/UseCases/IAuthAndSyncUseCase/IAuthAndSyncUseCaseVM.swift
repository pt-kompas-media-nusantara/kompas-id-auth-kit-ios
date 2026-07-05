import Foundation
import FactoryKit
import XAuthKit

@MainActor
final class IAuthAndSyncUseCaseVM: ObservableObject {
    @Injected(\.authAndSyncService) private var authAndSyncService
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Mengeksekusi sinkronisasi otentikasi menggunakan KMP AuthAndSyncUseCase
    func execute() async {
        isLoading = true
        do {
            let result = try await authAndSyncService.loginByPurchaseToken()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
