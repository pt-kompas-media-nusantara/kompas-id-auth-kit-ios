import Foundation

@MainActor
final class ISupportAppUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP ISupportAppUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Sukses memeriksa status force-update aplikasi!\n"
        logOutput += "Hasil: Success(ForceUpdateStatus(needUpdate=false))\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
