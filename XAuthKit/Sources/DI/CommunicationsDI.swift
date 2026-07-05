import FactoryKit
import Foundation
@preconcurrency import KompasIdLibrary

extension Container {
    // Registrasikan ModelRepository ke Container secara publik
    // agar modul lain yang mengimpor Factory & XAuthKit bisa me-resolve.
    // Implementasinya (ModelRepositoryImpl) tetap tersembunyi sebagai internal modul.
    public var modelRepository: Factory<ModelRepository> {
        self { ModelRepositoryImpl() }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI.
    /// Menyediakan instance `AuthUseCase` secara transparan tanpa mengekspos detail pencarian Koin ke modul visual.
    public var authUseCase: Factory<IAuthUseCase> {
        self { KoinInjector().authUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk LaunchAppUseCase.
    public var launchAppUseCase: Factory<ILaunchAppUseCase> {
        self { KoinInjector().launchAppUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk AuthAndSyncUseCase.
    public var authAndSyncUseCase: Factory<IAuthAndSyncUseCase> {
        self { KoinInjector().authAndSyncUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk PersonalInfoUseCase.
    public var personalInfoUseCase: Factory<IPersonalInfoUseCase> {
        self { KoinInjector().personalInfoUseCase }
    }

    // MARK: - Infrastructure Services
    
    public var deviceInformationProvider: Factory<DeviceInformationProvider> {
        self { SystemDeviceInformationProvider() }
    }

    public var envConfigurationMapper: Factory<EnvConfigurationMapper> {
        self { DefaultEnvConfigurationMapper() }
    }

    public var tokenStorage: Factory<TokenStorage> {
        self { KeychainTokenStorage() }
    }

    // MARK: - Wrapper Services
    
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

    public var authService: Factory<AuthService> {
        self { AuthServiceImpl(authUseCase: self.authUseCase()) }
    }

    public var authAndSyncService: Factory<AuthAndSyncService> {
        self { AuthAndSyncServiceImpl(authAndSyncUseCase: self.authAndSyncUseCase()) }
    }

    public var personalInfoService: Factory<PersonalInfoService> {
        self { PersonalInfoServiceImpl(personalInfoUseCase: self.personalInfoUseCase()) }
    }
}
