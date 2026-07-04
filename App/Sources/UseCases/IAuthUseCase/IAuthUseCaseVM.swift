import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IAuthUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""
    
    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.authUseCase) private var authUseCase

    /// Memeriksa status pengguna melalui purchase token menggunakan KMP AuthUseCase
    func executeCheckUser() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Memanggil authUseCase.checkUserByPurchaseToken()...\n"
        
        do {
            // execute() adalah suspend function dari KMP yang dipetakan sebagai async/throws di Swift
            let result = try await authUseCase.checkUserByPurchaseToken()
            
            logOutput += "KMP AuthUseCase sukses!\n"
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
