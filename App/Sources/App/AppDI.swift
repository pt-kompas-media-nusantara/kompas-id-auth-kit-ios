import FactoryKit

extension Container {
    /// Registrasi AppRouter sebagai Singleton untuk digunakan di seluruh aplikasi (UI & VM)
    @MainActor
    var appRouter: Factory<AppRouter> {
        self { AppRouter() }.singleton
    }
}
