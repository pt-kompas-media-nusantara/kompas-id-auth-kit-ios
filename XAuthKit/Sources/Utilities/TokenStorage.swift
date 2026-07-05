import Foundation
import Security

public enum KeychainError: Error {
    case unknown(OSStatus)
}

/// Protocol abstraction for storing access and refresh tokens.
/// Conforms to SOLID Interface Segregation and Dependency Inversion.
public protocol TokenStorage: Sendable {
    func saveAccessToken(_ token: String) throws
    func getAccessToken() -> String?
    func deleteAccessToken() throws

    func saveRefreshToken(_ token: String) throws
    func getRefreshToken() -> String?
    func deleteRefreshToken() throws
}

/// Concrete implementation of TokenStorage using the secure iOS Keychain.
/// Conforms to Single Responsibility Principle.
public struct KeychainTokenStorage: TokenStorage {
    private let accessTokenKey = "com.kompas.auth.access_token"
    private let refreshTokenKey = "com.kompas.auth.refresh_token"

    public init() {}

    public func saveAccessToken(_ token: String) throws {
        try save(key: accessTokenKey, data: Data(token.utf8))
    }

    public func getAccessToken() -> String? {
        guard let data = read(key: accessTokenKey) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    public func deleteAccessToken() throws {
        try delete(key: accessTokenKey)
    }

    public func saveRefreshToken(_ token: String) throws {
        try save(key: refreshTokenKey, data: Data(token.utf8))
    }

    public func getRefreshToken() -> String? {
        guard let data = read(key: refreshTokenKey) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    public func deleteRefreshToken() throws {
        try delete(key: refreshTokenKey)
    }

    // MARK: - Private Keychain Helpers
    
    private func save(key: String, data: Data) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    private func read(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            return nil
        }

        return data
    }
    
    private func delete(key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unknown(status)
        }
    }
}
