import Foundation

@MainActor
final class IAnalyticsUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP IAnalyticsUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Simulasi pengiriman event analitik berhasil!\n"
        logOutput += "Hasil: Success(Unit)\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
