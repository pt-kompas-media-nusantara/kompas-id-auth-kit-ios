import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class ILaunchAppUseCaseVM: ObservableObject {
    @Injected(\.launchAppUseCase) private var launchAppUseCase
    
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func execute() async {
        isLoading = true
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
            
            let result = try await launchAppUseCase.execute(data: dummyData)
            resultText = "KMP LaunchAppUseCase sukses!\nHasil: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
