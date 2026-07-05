import Foundation
import FactoryKit
@preconcurrency import KompasIdLibrary

// MARK: - Conforming KMP NetworkError to Swift Error
extension NetworkError: @retroactive Error {}

// MARK: - AppFlavor & AppDevice extensions for mapping
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

// MARK: - LaunchAppService
public protocol LaunchAppService: Sendable {
    func execute() async throws -> String
}

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

// MARK: - AuthService
public protocol AuthService: Sendable {
    func checkRegisteredUser(type: String, value: String) async throws -> String
    func checkUserByPurchaseToken() async throws -> String
    func loginByApple(appleToken: String) async throws -> String
    func loginByEmail(email: String, password: String) async throws -> String
    func loginByGoogle(googleToken: String, state: String) async throws -> String
    func loginByPurchaseToken() async throws -> String
    func postLogout() async throws -> String
    func postRefreshToken() async throws -> String
    func registerForm(email: String, firstName: String, lastName: String, password: String) async throws -> String
    func sendOTP(flag: Int, phoneNumber: String, countryCode: String) async throws -> String
    func verifyOTP(countryCode: String, otp: String, phoneNumber: String) async throws -> String
}

public final class AuthServiceImpl: AuthService {
    private let authUseCase: any IAuthUseCase

    public init(authUseCase: any IAuthUseCase) {
        self.authUseCase = authUseCase
    }

    public func checkRegisteredUser(type: String, value: String) async throws -> String {
        let result = try await authUseCase.checkRegisteredUser(type: type, value: value)
        if let success = result as? ResultsSuccess<CheckRegisteredUserModel> {
            return "Sukses: \(success)"
        } else if let failure = result as? ResultsError<NetworkError> {
            let networkError = failure.error
            throw networkError
        }
        return "Sukses: \(result)"
    }

    public func checkUserByPurchaseToken() async throws -> String {
        let result = try await authUseCase.checkUserByPurchaseToken()
        return "Sukses: \(result)"
    }

    public func loginByApple(appleToken: String) async throws -> String {
        let result = try await authUseCase.loginByApple(accessTokenByApple: appleToken)
        return "Sukses: \(result)"
    }

    public func loginByEmail(email: String, password: String) async throws -> String {
        let result = try await authUseCase.loginByEmail(email: email, password: password)
        return "Sukses: \(result)"
    }

    public func loginByGoogle(googleToken: String, state: String) async throws -> String {
        let result = try await authUseCase.loginByGoogle(accessTokenByGoogle: googleToken, state: state)
        return "Sukses: \(result)"
    }

    public func loginByPurchaseToken() async throws -> String {
        let result = try await authUseCase.loginByPurchaseToken()
        return "Sukses: \(result)"
    }

    public func postLogout() async throws -> String {
        let result = try await authUseCase.postLogout()
        return "Sukses: \(result)"
    }

    public func postRefreshToken() async throws -> String {
        let result = try await authUseCase.postRefreshToken()
        return "Sukses: \(result)"
    }

    public func registerForm(email: String, firstName: String, lastName: String, password: String) async throws -> String {
        let result = try await authUseCase.registerForm(email: email, firstName: firstName, lastName: lastName, password: password)
        return "Sukses: \(result)"
    }

    public func sendOTP(flag: Int, phoneNumber: String, countryCode: String) async throws -> String {
        let result = try await authUseCase.sendOTP(flag: Int32(flag), phoneNumber: phoneNumber, countryCode: countryCode)
        return "Sukses: \(result)"
    }

    public func verifyOTP(countryCode: String, otp: String, phoneNumber: String) async throws -> String {
        let result = try await authUseCase.verifyOTP(countryCode: countryCode, otp: otp, phoneNumber: phoneNumber)
        return "Sukses: \(result)"
    }
}

// MARK: - AuthAndSyncService
public protocol AuthAndSyncService: Sendable {
    func loginByPurchaseToken() async throws -> String
}

public final class AuthAndSyncServiceImpl: AuthAndSyncService {
    private let authAndSyncUseCase: any IAuthAndSyncUseCase

    public init(authAndSyncUseCase: any IAuthAndSyncUseCase) {
        self.authAndSyncUseCase = authAndSyncUseCase
    }

    public func loginByPurchaseToken() async throws -> String {
        let result = try await authAndSyncUseCase.loginByPurchaseToken()
        return "KMP AuthAndSyncUseCase sukses!\nHasil: \(result)"
    }
}

// MARK: - PersonalInfoService
public protocol PersonalInfoService: Sendable {
    func fetchUserDataParallely() async throws -> String
}

public final class PersonalInfoServiceImpl: PersonalInfoService {
    private let personalInfoUseCase: any IPersonalInfoUseCase

    public init(personalInfoUseCase: any IPersonalInfoUseCase) {
        self.personalInfoUseCase = personalInfoUseCase
    }

    public func fetchUserDataParallely() async throws -> String {
        let result = try await personalInfoUseCase.fetchUserDataParallely()
        return "KMP PersonalInfoUseCase sukses!\nHasil: \(result)"
    }
}
