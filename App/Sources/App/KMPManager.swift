@preconcurrency import KompasIdLibrary
import SwiftUI
import FactoryKit
import XAuthKit

@MainActor
final class KMPManager {
    
    private init() {}

    /// Instance tunggal (singleton) untuk mengakses KMPManager.
    static let shared = KMPManager()

    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.authUseCase) private var authUseCase

    /// Melakukan inisialisasi modul atau use case KMP setelah aplikasi selesai dimuat.
    func didFinishLaunchingWithOptions() {
        print("KMP AuthUseCase berhasil diinisialisasi via Factory: \(authUseCase)")
    }
}
