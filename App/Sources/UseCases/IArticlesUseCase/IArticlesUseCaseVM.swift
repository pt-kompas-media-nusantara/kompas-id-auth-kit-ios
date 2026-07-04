import Foundation

@MainActor
final class IArticlesUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP IArticlesUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Sukses mengambil list artikel premium dari KMP!\n"
        logOutput += "Hasil: Success(List<Article>)\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
