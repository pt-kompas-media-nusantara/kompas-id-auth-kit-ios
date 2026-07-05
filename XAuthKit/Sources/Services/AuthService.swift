import Foundation
@preconcurrency import KompasIdLibrary

// MARK: - Conforming KMP NetworkError to Swift Error
extension NetworkError: @retroactive Error {}

/// Service protocol to handle user authentication workflows.
/// Conforms to SOLID Interface Segregation and Dependency Inversion.
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

/// Concrete implementation of AuthService.
/// Delegates calls to KMP IAuthUseCase and handles result type-checking/casting internally.
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
