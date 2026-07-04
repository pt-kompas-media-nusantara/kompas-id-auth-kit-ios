import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IAuthAndSyncUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""
    
    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.authAndSyncUseCase) private var authAndSyncUseCase

    /// Mengeksekusi sinkronisasi otentikasi menggunakan KMP AuthAndSyncUseCase
    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Memanggil authAndSyncUseCase.loginByPurchaseToken()...\n"
        
        do {
            let result = try await authAndSyncUseCase.loginByPurchaseToken()
            
            logOutput += "KMP AuthAndSyncUseCase loginByPurchaseToken sukses!\n"
            logOutput += "Hasil: \(result)\n"
            statusText = "Sukses"
        } catch {
            logOutput += "Eror terjadi saat eksekusi:\n"
            logOutput += "\(error.localizedDescription)\n"
            statusText = "Gagal"
        }
        
        isExecuting = false
    }
}
