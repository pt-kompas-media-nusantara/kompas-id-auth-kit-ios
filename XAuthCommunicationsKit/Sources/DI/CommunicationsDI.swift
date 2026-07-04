import FactoryKit
import Foundation
@preconcurrency import KompasIdLibrary

extension Container {
    // Registrasikan ModelRepository ke Container secara publik
    // agar modul lain yang mengimpor Factory & XAuthCommunicationsKit bisa me-resolve.
    // Implementasinya (ModelRepositoryImpl) tetap tersembunyi sebagai internal modul.
    public var modelRepository: Factory<ModelRepository> {
        self { ModelRepositoryImpl() }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI.
    /// Menyediakan instance `AuthUseCase` secara transparan tanpa mengekspos detail pencarian Koin ke modul visual.
    public var authUseCase: Factory<AuthUseCase> {
        self { KoinInjector().authUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk LaunchAppUseCase.
    public var launchAppUseCase: Factory<LaunchAppUseCase> {
        self { KoinInjector().launchAppUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk AuthAndSyncUseCase.
    public var authAndSyncUseCase: Factory<AuthAndSyncUseCase> {
        self { KoinInjector().authAndSyncUseCase }
    }
    
    /// Menjembatani KMP Koin DI dengan iOS Factory DI untuk PersonalInfoUseCase.
    public var personalInfoUseCase: Factory<PersonalInfoUseCase> {
        self { KoinInjector().personalInfoUseCase }
    }
}
