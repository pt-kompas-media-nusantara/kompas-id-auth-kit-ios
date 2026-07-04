import Foundation

@MainActor
final class ISupportSystemUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi verifikasi sistem OS
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses memeriksa rekomendasi kompatibilitas versi iOS perangkat!\nHasil: Success(OSStatus(isCompatible=true))"
        isLoading = false
    }
}
