import SwiftUI
import XAuthKit
import XAuthUIKit
import FactoryKit

struct RootView: View {
    @StateObject private var viewModel = RootVM()
    
    var body: some View {
        NavigationStack(path: $viewModel.router.path) {
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
                            
                            }
                            
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // CARD 2: Menu Aksi (KMP Use Case Playgrounds via Programmatic Router)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("KMP Use Case Playground")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        Group {
                            Button(action: { viewModel.navigate(to: .auth) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .launchApp) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .authAndSync) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .personalInfo) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .analytics) }) {
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
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                        Group {
                            Button(action: { viewModel.navigate(to: .articles) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .settings) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .subscription) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .supportApp) }) {
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
                            .buttonStyle(PlainButtonStyle())
                            
                            Button(action: { viewModel.navigate(to: .supportSystem) }) {
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
                            .buttonStyle(PlainButtonStyle())
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
            
            // Deklarasikan koordinasi tujuan rute di luar layout ScrollView utama
            .navigationDestination(for: AppRoute.self) { route in
                viewModel.router.view(for: route)
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
