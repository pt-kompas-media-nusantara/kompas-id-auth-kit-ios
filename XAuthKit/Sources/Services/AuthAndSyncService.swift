import Foundation
@preconcurrency import KompasIdLibrary

/// Service protocol to handle authentication and data synchronization.
/// Conforms to SOLID Interface Segregation and Dependency Inversion.
public protocol AuthAndSyncService: Sendable {
    func loginByPurchaseToken() async throws -> String
}

/// Concrete implementation of AuthAndSyncService.
/// Delegates calls to KMP IAuthAndSyncUseCase.
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
