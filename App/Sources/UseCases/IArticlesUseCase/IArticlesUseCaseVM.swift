import Foundation

import FactoryKit

@MainActor
final class IArticlesUseCaseVM: ObservableObject {
    @Injected(\.appRouter) private var router: AppRouter
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Simulasi pemuatan list artikel
    func execute() async {
        isLoading = true
        try? await Task.sleep(nanoseconds: 300_000_000)
        resultText = "Sukses mengambil list artikel premium dari KMP!\nHasil: Success(List<Article>)"
        
        // Demo navigasi dari VM ke Auth & Sync setelah data termuat
        router.navigate(to: .authAndSync)
        
        isLoading = false
    }
}
