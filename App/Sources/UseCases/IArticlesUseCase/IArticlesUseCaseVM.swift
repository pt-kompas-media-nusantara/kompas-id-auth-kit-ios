import Foundation

@MainActor
final class IArticlesUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi pemuatan list artikel
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses mengambil list artikel premium dari KMP!\nHasil: Success(List<Article>)"
        isLoading = false
    }
}
