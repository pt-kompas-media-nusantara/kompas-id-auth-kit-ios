import Foundation

@MainActor
final class ISettingsUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi pemuatan pengaturan
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses memuat konfigurasi pengaturan aplikasi!\nHasil: Success(SettingsModel)"
        isLoading = false
    }
}
