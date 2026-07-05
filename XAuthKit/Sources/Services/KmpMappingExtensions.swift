import Foundation
@preconcurrency import KompasIdLibrary

// MARK: - AppFlavorType & AppDeviceType KMP mapping extensions
extension AppFlavorType {
    var toKmpFlavor: FlavorsTypeModel {
        switch self {
        case .allCloud: return .allCloud
        case .cloudApiary: return .cloudApiary
        case .allProd: return .allProd
        case .prodApiary: return .prodApiary
        }
    }
}

extension AppDeviceType {
    var toKmpDeviceType: DeviceTypeModel {
        switch self {
        case .smartphone: return .smartphone
        case .tablet: return .tablet
        case .phablet: return .phablet
        case .desktop: return .desktop
        }
    }
}
