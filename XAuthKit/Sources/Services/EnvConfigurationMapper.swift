import Foundation

/// Intermediate enum representing KMP Flavors without importing the KMP library.
public enum AppFlavorType: Sendable {
    case allCloud
    case cloudApiary
    case allProd
    case prodApiary
}

/// Interface to map AppFlavor to a library-agnostic configuration representation.
/// Conforms to Open-Closed Principle and Dependency Inversion.
public protocol EnvConfigurationMapper: Sendable {
    func map(_ flavor: AppFlavor) -> (flavorType: AppFlavorType, isLogActive: Bool)
}

/// Concrete mapper implementation.
/// Conforms to Single Responsibility Principle.
public struct DefaultEnvConfigurationMapper: EnvConfigurationMapper {
    public init() {}

    public func map(_ flavor: AppFlavor) -> (flavorType: AppFlavorType, isLogActive: Bool) {
        switch flavor {
        case .development:
            return (.allCloud, true)
        case .uat:
            return (.cloudApiary, true)
        case .production:
            return (.allProd, false)
        case .diagnostic:
            return (.prodApiary, true)
        }
    }
}
