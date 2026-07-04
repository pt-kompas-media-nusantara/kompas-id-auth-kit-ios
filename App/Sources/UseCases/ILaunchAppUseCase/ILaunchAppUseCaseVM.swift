import FactoryKit
import Foundation
@preconcurrency import KompasIdLibrary
import XAuthKit

@MainActor
final class ILaunchAppUseCaseVM: ObservableObject {
    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    private let launchAppUseCase: any ILaunchAppUseCase
    private let deviceProvider: DeviceInformationProvider
    private let configMapper: EnvConfigurationMapper
    private let tokenStorage: TokenStorage

    init(
        launchAppUseCase: any ILaunchAppUseCase = Container.shared.launchAppUseCase(),
        deviceProvider: DeviceInformationProvider = Container.shared.deviceInformationProvider(),
        configMapper: EnvConfigurationMapper = Container.shared.envConfigurationMapper(),
        tokenStorage: TokenStorage = Container.shared.tokenStorage()
    ) {
        self.launchAppUseCase = launchAppUseCase
        self.deviceProvider = deviceProvider
        self.configMapper = configMapper
        self.tokenStorage = tokenStorage
    }

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func execute() async {
        isLoading = true

        let mappedConfig = configMapper.map(BuildConfiguration.currentFlavor)

        let accessToken = tokenStorage.getAccessToken() ?? ""
        let refreshToken = tokenStorage.getRefreshToken() ?? ""

        let dummyData = LaunchAppModel(
            tokenAuthenticationModel: TokenAuthenticationModel(
                accessToken: accessToken,
                refreshToken: refreshToken
            ),
            deviceInfoModel: DeviceInfoModel(
                platform: .ios,
                uiDeviceSystemName: deviceProvider.systemName,
                uiDeviceName: deviceProvider.deviceName,
                uiDeviceModel: deviceProvider.deviceModel,
                uiDeviceSeries: deviceProvider.deviceSeries,
                deviceTypeModel: deviceProvider.deviceType.toKmpDeviceType,
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

extension AppFlavorType {
    fileprivate var toKmpFlavor: FlavorsTypeModel {
        switch self {
        case .allCloud: return .allCloud
        case .cloudApiary: return .cloudApiary
        case .allProd: return .allProd
        case .prodApiary: return .prodApiary
        }
    }
}

extension AppDeviceType {
    fileprivate var toKmpDeviceType: DeviceTypeModel {
        switch self {
        case .smartphone: return .smartphone
        case .tablet: return .tablet
        case .phablet: return .phablet
        case .desktop: return .desktop
        }
    }
}

