import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class IPersonalInfoUseCaseVM: ObservableObject {
    @Injected(\.personalInfoUseCase) private var personalInfoUseCase
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Mengambil data informasi pribadi menggunakan KMP PersonalInfoUseCase
    func execute() async {
        isLoading = true
        do {
            let result = try await personalInfoUseCase.fetchUserDataParallely()
            resultText = "KMP PersonalInfoUseCase sukses!\nHasil: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
