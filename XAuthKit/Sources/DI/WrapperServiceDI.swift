import FactoryKit
import Foundation

extension Container {
    /// Registrasi LaunchAppService wrapper
    public var launchAppService: Factory<LaunchAppService> {
        self {
            LaunchAppServiceImpl(
                launchAppUseCase: self.launchAppUseCase(),
                deviceProvider: self.deviceInformationProvider(),
                configMapper: self.envConfigurationMapper(),
                tokenStorage: self.tokenStorage()
            )
        }
    }

    /// Registrasi AuthService wrapper
    public var authService: Factory<AuthService> {
        self { AuthServiceImpl(authUseCase: self.authUseCase()) }
    }

    /// Registrasi AuthAndSyncService wrapper
    public var authAndSyncService: Factory<AuthAndSyncService> {
        self { AuthAndSyncServiceImpl(authAndSyncUseCase: self.authAndSyncUseCase()) }
    }

    /// Registrasi PersonalInfoService wrapper
    public var personalInfoService: Factory<PersonalInfoService> {
        self { PersonalInfoServiceImpl(personalInfoUseCase: self.personalInfoUseCase()) }
    }
}
