import SwiftUI
import XAuthKit
import XAuthUIKit

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var appVersion: String = ""
    @Published private(set) var osVersion: String = ""
    @Published private(set) var flavorName: String = ""

    init() {
        // Panggil properti tersentralisasi yang murni dari BuildConfiguration (Domain Layer)
        self.appVersion = BuildConfiguration.appVersion
        self.osVersion = BuildConfiguration.osVersion
        self.flavorName = BuildConfiguration.flavorDisplayName
    }
    
}

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
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
                            
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // CARD 2: Menu Aksi (Push Navigation Links)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Menu Navigasi")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        NavigationLink(destination: DetailView(title: "Profil Pengguna")) {
                            HStack {
                                Image(systemName: "person.crop.circle")
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text("Profil Saya")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("Lihat detail profil dan pengaturan akun")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: DetailView(title: "Pengaturan Otentikasi")) {
                            HStack {
                                Image(systemName: "lock.shield")
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text("Keamanan & Sandi")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("Atur sandi, biometrik, dan sesi aktif")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(10)
                        }
                        
                        NavigationLink(destination: DetailView(title: "Riwayat Aktivitas")) {
                            HStack {
                                Image(systemName: "clock.arrow.2.circlepath")
                                    .font(.title2)
                                VStack(alignment: .leading) {
                                    Text("Log Aktivitas")
                                        .font(.body)
                                        .fontWeight(.semibold)
                                    Text("Periksa riwayat masuk dan aktivitas akun")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color(.tertiarySystemBackground))
                            .cornerRadius(10)
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
