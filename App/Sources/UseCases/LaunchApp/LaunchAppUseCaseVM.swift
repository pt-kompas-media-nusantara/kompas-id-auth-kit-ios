import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class LaunchAppUseCaseVM: ObservableObject {
    @Published private(set) var statusText: String = "Menunggu Aksi..."
    @Published private(set) var isExecuting: Bool = false
    @Published private(set) var logOutput: String = ""
    
    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.launchAppUseCase) private var launchAppUseCase

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func execute() async {
        isExecuting = true
        statusText = "Memulai eksekusi..."
        logOutput = "Parameter input disiapkan...\n"
        
        do {
            let dummyData = LaunchAppModel(
                tokenAuthenticationModel: TokenAuthenticationModel(
                    accessToken: "",
                    refreshToken: ""
                ),
                deviceInfoModel: DeviceInfoModel(
                    platform: .ios,
                    uiDeviceSystemName: "iOS",
                    uiDeviceName: "iPhone Simulator",
                    uiDeviceModel: "iPhone",
                    uiDeviceSeries: "iPhone 15 Pro",
                    deviceTypeModel: .smartphone,
                    osVersion: BuildConfiguration.osVersion
                ),
                envConfigurationModel: EnvConfigurationModel(
                    flavors: .allProd,
                    isLogActived: true,
                    currentAppVersionKompasId: BuildConfiguration.appVersion
                ),
                tokenSubscriptionModel: TokenSubscriptionModel(
                    iosPurchaseToken: IosPurchaseToken(transactionIDs: [], subscriptionHistory: ""),
                    aosPurchaseToken: nil
                )
            )
            
            logOutput += "Mengirim request ke KMP LaunchAppUseCase...\n"
            statusText = "Memproses data..."
            
            // execute() adalah suspend function dari KMP yang dipetakan sebagai async/throws di Swift
            let result = try await launchAppUseCase.execute(data: dummyData)
            
            logOutput += "KMP LaunchAppUseCase sukses!\n"
            logOutput += "Hasil: \(result)\n"
            statusText = "Sukses"
        } catch {
            logOutput += "Eror terjadi saat eksekusi:\n"
            logOutput += "\(error.localizedDescription)\n"
            statusText = "Gagal"
        }
        
        isExecuting = false
    }
}
