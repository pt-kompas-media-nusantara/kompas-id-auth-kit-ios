import Foundation

@MainActor
final class ISubscriptionUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP ISubscriptionUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Sukses memverifikasi langganan aktif Kompas ID!\n"
        logOutput += "Hasil: Success(SubscriptionStatus(isActive=true))\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
