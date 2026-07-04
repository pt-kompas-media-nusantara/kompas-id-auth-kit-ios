import SwiftUI

@MainActor
final class AppRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    /// Navigasi ke halaman baru
    func navigate(to route: AppRoute) {
        path.append(route)
    }
    
    /// Kembali ke halaman sebelumnya (pop)
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    /// Kembali ke halaman paling awal (root)
    func popToRoot() {
        path = NavigationPath()
    }
    
    /// Menyelesaikan View untuk rute tertentu menggunakan RouteResolver
    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        RouteResolver.shared.resolve(route)
    }
}
