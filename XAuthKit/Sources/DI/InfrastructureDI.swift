import FactoryKit
import Foundation

extension Container {
    /// Registrasi DeviceInformationProvider untuk mendeteksi informasi perangkat
    public var deviceInformationProvider: Factory<DeviceInformationProvider> {
        self { SystemDeviceInformationProvider() }
    }

    /// Registrasi EnvConfigurationMapper untuk memetakan environment
    public var envConfigurationMapper: Factory<EnvConfigurationMapper> {
        self { DefaultEnvConfigurationMapper() }
    }

    /// Registrasi TokenStorage untuk menyimpan token keamanan di Keychain
    public var tokenStorage: Factory<TokenStorage> {
        self { KeychainTokenStorage() }
    }
}
