import UIKit

/// Protocol abstraction for retrieving device information.
/// Conforms to Dependency Inversion and Interface Segregation principles.
public protocol DeviceInformationProvider: Sendable {
    @MainActor var systemName: String { get }
    @MainActor var deviceName: String { get }
    @MainActor var deviceModel: String { get }
    var deviceSeries: String { get }
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
}


