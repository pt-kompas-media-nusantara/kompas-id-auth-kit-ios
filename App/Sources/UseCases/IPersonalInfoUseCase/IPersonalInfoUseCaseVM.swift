import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IPersonalInfoUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""
    
    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.personalInfoUseCase) private var personalInfoUseCase

    /// Mengambil data informasi pribadi menggunakan KMP PersonalInfoUseCase
    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Memanggil personalInfoUseCase.fetchUserDataParallely()...\n"
        
        do {
            let result = try await personalInfoUseCase.fetchUserDataParallely()
            
            logOutput += "KMP PersonalInfoUseCase fetchUserDataParallely sukses!\n"
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
