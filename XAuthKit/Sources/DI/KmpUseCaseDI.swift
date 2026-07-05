import FactoryKit
import Foundation
@preconcurrency import KompasIdLibrary

extension Container {
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk AuthUseCase.
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
}
