import SwiftUI
import XAuthKit
import XAuthUIKit
import FactoryKit
import XAuthCommunicationsKit

@MainActor
final class DashboardViewModel: ObservableObject {
    @Published private(set) var appVersion: String = ""
    @Published private(set) var osVersion: String = ""
    @Published private(set) var flavorName: String = ""
    @Published private(set) var repositoryValue: String = "Loading..."
    
    // Suntikkan dependensi menggunakan Property Wrapper Factory
    @Injected(\.modelRepository) private var modelRepository

    init() {
        // Panggil properti tersentralisasi yang murni dari BuildConfiguration (Domain Layer)
        self.appVersion = BuildConfiguration.appVersion
        self.osVersion = BuildConfiguration.osVersion
        self.flavorName = BuildConfiguration.flavorDisplayName
    }
    
    func loadRepositoryData() {
        Task {
            do {
                let model = try await modelRepository.data()
                self.repositoryValue = "\(model.value)"
            } catch {
                self.repositoryValue = "Error: \(error.localizedDescription)"
            }
        }
    }
}

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // CARD 1: Informasi Sistem & Build (Terpusat)
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title3)
                            Text("Informasi Aplikasi")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                        .padding(.bottom, 4)
                        
                        Divider()
                        
                        Group {
                            HStack {
                                Text("Versi OS:")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("iOS \(viewModel.osVersion)")
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("Versi Aplikasi:")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(viewModel.appVersion)
                                    .fontWeight(.medium)
                            }
                            
                            HStack {
                                Text("Flavor / Skema:")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(viewModel.flavorName)
                                    .fontWeight(.bold)
                                    .foregroundColor(.green)
                            }
                            
                            HStack {
                                Text("Repository Value (Factory):")
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text(viewModel.repositoryValue)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // CARD 2: Menu Aksi (KMP Use Case Playgrounds)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("KMP Use Case Playground")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Group {
                            NavigationLink(destination: IAuthUseCaseView()) {
                                HStack {
                                    Image(systemName: "person.badge.shield.checkmark")
                                        .font(.title3)
                                    Text("IAuthUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: ILaunchAppUseCaseView()) {
                                HStack {
                                    Image(systemName: "arrow.triangle.2.circlepath.circle")
                                        .font(.title3)
                                    Text("ILaunchAppUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: IAuthAndSyncUseCaseView()) {
                                HStack {
                                    Image(systemName: "arrow.clockwise.icloud")
                                        .font(.title3)
                                    Text("IAuthAndSyncUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: IPersonalInfoUseCaseView()) {
                                HStack {
                                    Image(systemName: "person.text.rectangle")
                                        .font(.title3)
                                    Text("IPersonalInfoUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: IAnalyticsUseCaseView()) {
                                HStack {
                                    Image(systemName: "chart.bar")
                                        .font(.title3)
                                    Text("IAnalyticsUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                        }
                        
                        Group {
                            NavigationLink(destination: IArticlesUseCaseView()) {
                                HStack {
                                    Image(systemName: "doc.text")
                                        .font(.title3)
                                    Text("IArticlesUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: ISettingsUseCaseView()) {
                                HStack {
                                    Image(systemName: "gearshape")
                                        .font(.title3)
                                    Text("ISettingsUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: ISubscriptionUseCaseView()) {
                                HStack {
                                    Image(systemName: "creditcard")
                                        .font(.title3)
                                    Text("ISubscriptionUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: ISupportAppUseCaseView()) {
                                HStack {
                                    Image(systemName: "exclamationmark.shield")
                                        .font(.title3)
                                    Text("ISupportAppUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                            
                            NavigationLink(destination: ISupportSystemUseCaseView()) {
                                HStack {
                                    Image(systemName: "cpu")
                                        .font(.title3)
                                    Text("ISupportSystemUseCase Test")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.tertiarySystemBackground))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    // CARD 3: Komponen Custom Framework dari UI Kit
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Komponen Framework (XAuthUIKit)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top, 10)
                        
                        VStack(spacing: 12) {
                            ButtonAuthKit()
                            ComponentView()
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("XAuth Dashboard")
            .task {
                viewModel.loadRepositoryData()
            }
        }
    }
}

// Halaman Detail Penerima Push Navigation
struct DetailView: View {
    let title: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Ini adalah halaman detail untuk:")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top, 55)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
