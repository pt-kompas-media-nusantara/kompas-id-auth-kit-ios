import Foundation

@MainActor
final class ISettingsUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""

    func execute() async {
        isExecuting = true
        statusText = "Memproses..."
        logOutput = "Menjalankan mock KMP ISettingsUseCase...\n"
        
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        logOutput += "Sukses memuat konfigurasi pengaturan aplikasi!\n"
        logOutput += "Hasil: Success(SettingsModel)\n"
        statusText = "Sukses"
        isExecuting = false
    }
}
