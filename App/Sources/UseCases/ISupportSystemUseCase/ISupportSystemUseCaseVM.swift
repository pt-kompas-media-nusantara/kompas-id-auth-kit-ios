import Foundation

@MainActor
final class ISupportSystemUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP ISupportSystemUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Sukses memeriksa rekomendasi kompatibilitas versi iOS perangkat!\n"
        logOutput += "Hasil: Success(OSStatus(isCompatible=true))\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
