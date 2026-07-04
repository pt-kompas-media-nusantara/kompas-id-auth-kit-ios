import FactoryKit

extension Container {
    /// Registrasi AppRouter sebagai Singleton untuk digunakan di seluruh aplikasi (UI & VM)
    @MainActor
    var appRouter: Factory<AppRouter> {
        self { AppRouter() }.singleton
    }

    /// Registrasi DeviceInformationProvider
    public var deviceInformationProvider: Factory<DeviceInformationProvider> {
        self { SystemDeviceInformationProvider() }
    }

    /// Registrasi EnvConfigurationMapper
    public var envConfigurationMapper: Factory<EnvConfigurationMapper> {
        self { DefaultEnvConfigurationMapper() }
    }
}
