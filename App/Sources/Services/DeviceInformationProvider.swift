import UIKit

/// Library-agnostic representation of device interface idioms.
public enum AppDeviceType: Sendable {
    case smartphone
    case tablet
    case phablet
    case desktop
}

/// Protocol abstraction for retrieving device information.
/// Conforms to Dependency Inversion and Interface Segregation principles.
public protocol DeviceInformationProvider: Sendable {
    @MainActor var systemName: String { get }
    @MainActor var deviceName: String { get }
    @MainActor var deviceModel: String { get }
    var deviceSeries: String { get }
    @MainActor var deviceType: AppDeviceType { get }
}

/// Concrete implementation of DeviceInformationProvider using UIKit.UIDevice and utsname.
/// Conforms to Single Responsibility Principle.
public struct SystemDeviceInformationProvider: DeviceInformationProvider {
    public init() {}

    @MainActor
    public var systemName: String {
        UIDevice.current.systemName
    }

    @MainActor
    public var deviceName: String {
        UIDevice.current.name
    }

    @MainActor
    public var deviceModel: String {
        UIDevice.current.model
    }

    public var deviceSeries: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }

    @MainActor
    public var deviceType: AppDeviceType {
        let idiom = UIDevice.current.userInterfaceIdiom
        switch idiom {
        case .phone:
            return .smartphone
        case .pad:
            return .tablet
        case .carPlay:
            return .phablet
        case .tv:
            return .desktop
        case .mac:
            return .desktop
        case .vision:
            return .desktop
        case .unspecified:
            return .phablet
        @unknown default:
            return .phablet
        }

    }
}
