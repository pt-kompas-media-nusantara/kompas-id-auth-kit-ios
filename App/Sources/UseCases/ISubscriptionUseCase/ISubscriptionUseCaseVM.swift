import Foundation

@MainActor
final class ISubscriptionUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi verifikasi langganan
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses memverifikasi langganan aktif Kompas ID!\nHasil: Success(SubscriptionStatus(isActive=true))"
        isLoading = false
    }
}
