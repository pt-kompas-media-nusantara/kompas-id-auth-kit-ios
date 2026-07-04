import Foundation

@MainActor
final class IAnalyticsUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi pengiriman analitik event
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Simulasi pengiriman event analitik sukses!\nHasil: Success(Unit)"
        isLoading = false
    }
}
