import SwiftUI

@MainActor
final class RouteResolver {
    static let shared = RouteResolver()
    
    private init() {}
    
    /// Menyelesaikan rute (AppRoute) menjadi SwiftUI View secara lazy (saat navigasi terjadi)
    @ViewBuilder
    func resolve(_ route: AppRoute) -> some View {
        switch route {
        case .auth:
            IAuthUseCaseView()
        case .launchApp:
            ILaunchAppUseCaseView()
        case .authAndSync:
            IAuthAndSyncUseCaseView()
        case .personalInfo:
            IPersonalInfoUseCaseView()
        case .analytics:
            IAnalyticsUseCaseView()
        case .articles:
            IArticlesUseCaseView()
        case .settings:
            ISettingsUseCaseView()
        case .subscription:
            ISubscriptionUseCaseView()
        case .supportApp:
            ISupportAppUseCaseView()
        case .supportSystem:
            ISupportSystemUseCaseView()
        }
    }
}
