import Foundation
@preconcurrency import KompasIdLibrary

/// Service protocol to retrieve personal user information.
/// Conforms to SOLID Interface Segregation and Dependency Inversion.
public protocol PersonalInfoService: Sendable {
    func fetchUserDataParallely() async throws -> String
}

/// Concrete implementation of PersonalInfoService.
/// Delegates calls to KMP IPersonalInfoUseCase.
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
