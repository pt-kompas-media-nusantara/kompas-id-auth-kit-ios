import Foundation

@MainActor
final class ISupportAppUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi pemeriksaan update aplikasi
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses memeriksa status force-update aplikasi!\nHasil: Success(ForceUpdateStatus(needUpdate=false))"
        isLoading = false
    }
}
