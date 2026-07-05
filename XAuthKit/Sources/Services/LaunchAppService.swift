import Foundation
@preconcurrency import KompasIdLibrary

/// Service protocol to handle application launching workflow.
/// Conforms to SOLID Interface Segregation and Dependency Inversion.
public protocol LaunchAppService: Sendable {
    func execute() async throws -> String
}

/// Concrete implementation of LaunchAppService.
/// Coordinates data from infrastructure providers and delegates the execute call to KMP.
public final class LaunchAppServiceImpl: LaunchAppService {
    private let launchAppUseCase: any ILaunchAppUseCase
    private let deviceProvider: any DeviceInformationProvider
    private let configMapper: any EnvConfigurationMapper
    private let tokenStorage: any TokenStorage

    public init(
        launchAppUseCase: any ILaunchAppUseCase,
        deviceProvider: any DeviceInformationProvider,
        configMapper: any EnvConfigurationMapper,
        tokenStorage: any TokenStorage
    ) {
        self.launchAppUseCase = launchAppUseCase
        self.deviceProvider = deviceProvider
        self.configMapper = configMapper
        self.tokenStorage = tokenStorage
    }

    public func execute() async throws -> String {
        let mappedConfig = configMapper.map(BuildConfiguration.currentFlavor)
        let accessToken = tokenStorage.getAccessToken() ?? ""
        let refreshToken = tokenStorage.getRefreshToken() ?? ""

        let systemName = await deviceProvider.systemName
        let deviceName = await deviceProvider.deviceName
        let deviceModel = await deviceProvider.deviceModel
        let deviceType = await deviceProvider.deviceType

        let data = LaunchAppModel(
            tokenAuthenticationModel: TokenAuthenticationModel(
                accessToken: accessToken,
                refreshToken: refreshToken
            ),
            deviceInfoModel: DeviceInfoModel(
                platform: .ios,
                uiDeviceSystemName: systemName,
                uiDeviceName: deviceName,
                uiDeviceModel: deviceModel,
                uiDeviceSeries: deviceProvider.deviceSeries,
                deviceTypeModel: deviceType.toKmpDeviceType,
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

        let result = try await launchAppUseCase.execute(data: data)
        return "KMP LaunchAppUseCase sukses!\nHasil: \(result)"
    }
}
