import Foundation
import FactoryKit
import XAuthKit
@preconcurrency import KompasIdLibrary

@MainActor
final class ILaunchAppUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    private let launchAppUseCase: LaunchAppUseCase
    private let deviceProvider: DeviceInformationProvider
    private let configMapper: EnvConfigurationMapper

    init(
        launchAppUseCase: LaunchAppUseCase = Container.shared.launchAppUseCase(),
        deviceProvider: DeviceInformationProvider = Container.shared.deviceInformationProvider(),
        configMapper: EnvConfigurationMapper = Container.shared.envConfigurationMapper()
    ) {
        self.launchAppUseCase = launchAppUseCase
        self.deviceProvider = deviceProvider
        self.configMapper = configMapper
    }

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func execute() async {
        isLoading = true
        
        let mappedConfig = configMapper.map(BuildConfiguration.currentFlavor)
        
        let dummyData = LaunchAppModel(
            tokenAuthenticationModel: TokenAuthenticationModel(
                accessToken: "",
                refreshToken: ""
            ),
            deviceInfoModel: DeviceInfoModel(
                platform: .ios,
                uiDeviceSystemName: deviceProvider.systemName,
                uiDeviceName: deviceProvider.deviceName,
                uiDeviceModel: deviceProvider.deviceModel,
                uiDeviceSeries: deviceProvider.deviceSeries,
                deviceTypeModel: .smartphone,
                osVersion: BuildConfiguration.osVersion
            ),
            envConfigurationModel: EnvConfigurationModel(
                flavors: mappedConfig.flavorType.toKmpFlavor,
                isLogActived: mappedConfig.isLogActive,
                currentAppVersionKompasId: BuildConfiguration.appVersion
            ),
            tokenSubscriptionModel: TokenSubscriptionModel(
                iosPurchaseToken: nil,
                aosPurchaseToken: nil
            )
        )

        do {
            let result = try await launchAppUseCase.execute(data: dummyData)
            resultText = "KMP LaunchAppUseCase sukses!\nHasil: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }
}

private extension AppFlavorType {
    var toKmpFlavor: FlavorsTypeModel {
        switch self {
        case .allCloud: return .allCloud
        case .cloudApiary: return .cloudApiary
        case .allProd: return .allProd
        case .prodApiary: return .prodApiary
        }
    }
}
