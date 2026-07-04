import SwiftUI
import FactoryKit
@preconcurrency import KompasIdLibrary
import XAuthKit

@MainActor
final class LaunchAppVM: ObservableObject {
    @Published private(set) var statusText: String = "Menginisialisasi aplikasi..."
    @Published private(set) var hasError: Bool = false
    @Published private(set) var errorMessage: String = ""
    
    // Suntikkan UseCase menggunakan Factory DI Container
    @Injected(\.launchAppUseCase) private var launchAppUseCase

    /// Mengeksekusi use case peluncuran aplikasi (LaunchAppUseCase) dari KMP
    func executeLaunchApp() async -> Bool {
        hasError = false
        statusText = "Memeriksa konfigurasi sistem..."
        
        do {
            let dummyData = LaunchAppModel(
                tokenAuthenticationModel: TokenAuthenticationModel(
                    accessToken: "",
                    refreshToken: ""
                ),
                deviceInfoModel: DeviceInfoModel(
                    platform: .ios,
                    uiDeviceSystemName: "iOS",
                    uiDeviceName: "iPhone Simulator",
                    uiDeviceModel: "iPhone",
                    uiDeviceSeries: "iPhone 15 Pro",
                    deviceTypeModel: .smartphone,
                    osVersion: BuildConfiguration.osVersion
                ),
                envConfigurationModel: EnvConfigurationModel(
                    flavors: .allProd,
                    isLogActived: true,
                    currentAppVersionKompasId: BuildConfiguration.appVersion
                ),
                tokenSubscriptionModel: TokenSubscriptionModel(
                    iosPurchaseToken: IosPurchaseToken(transactionIDs: [], subscriptionHistory: ""),
                    aosPurchaseToken: nil
                )
            )
            
            statusText = "Sinkronisasi data dengan server Kompas ID..."
            // execute() adalah suspend function dari KMP yang dipetakan sebagai async/throws di Swift
            let result = try await launchAppUseCase.execute(data: dummyData)
            print("KMP LaunchAppUseCase sukses dijalankan: \(result)")
            
            statusText = "Selesai!"
            return true
        } catch {
            print("Gagal mengeksekusi KMP LaunchAppUseCase: \(error)")
            hasError = true
            errorMessage = error.localizedDescription
            statusText = "Gagal memulai aplikasi."
            return false
        }
    }
}

struct LaunchAppView: View {
    @StateObject private var viewModel = LaunchAppVM()
    @State private var isLaunched = false
    
    @State private var scale: CGFloat = 0.8
    @State private var opacity: Double = 0.5
    
    var body: some View {
        Group {
            if isLaunched {
                DashboardView()
            } else {
                ZStack {
                    // Background dengan gradasi premium dark-mode
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 10/255, green: 15/255, blue: 30/255), .black]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                    
                    VStack(spacing: 30) {
                        Spacer()
                        
                        // Logo/Simbol Utama dengan efek denyut (pulse animation)
                        ZStack {
                            Circle()
                                .fill(Color.blue.opacity(0.15))
                                .frame(width: 140, height: 140)
                                .scaleEffect(scale)
                            
                            Circle()
                                .fill(Color.blue.opacity(0.1))
                                .frame(width: 180, height: 180)
                                .scaleEffect(scale - 0.1)
                            
                            Image(systemName: "lock.shield.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70, height: 70)
                                .foregroundColor(.blue)
                                .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 5)
                        }
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                scale = 1.1
                            }
                        }
                        
                        VStack(spacing: 8) {
                            Text("KOMPAS ID")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .tracking(4)
                            
                            Text("Auth SDK Portal")
                                .font(.footnote)
                                .foregroundColor(.blue.opacity(0.8))
                                .tracking(2)
                        }
                        
                        Spacer()
                        
                        // Indikator Loading & Status teks
                        VStack(spacing: 15) {
                            if viewModel.hasError {
                                VStack(spacing: 12) {
                                    Image(systemName: "exclamationmark.triangle.fill")
                                        .foregroundColor(.red)
                                        .font(.title)
                                    
                                    Text(viewModel.errorMessage)
                                        .font(.caption)
                                        .foregroundColor(.red.opacity(0.8))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 40)
                                    
                                    Button(action: {
                                        triggerLaunchFlow()
                                    }) {
                                        Text("Coba Lagi")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 24)
                                            .padding(.vertical, 10)
                                            .background(Color.blue)
                                            .cornerRadius(20)
                                    }
                                }
                            } else {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                                    .scaleEffect(1.2)
                                
                                Text(viewModel.statusText)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .opacity(opacity)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                                            opacity = 1.0
                                        }
                                    }
                            }
                        }
                        .frame(height: 120)
                        
                        // Versi Build di bagian bawah
                        Text("v\(BuildConfiguration.appVersion) (\(BuildConfiguration.flavorDisplayName))")
                            .font(.caption2)
                            .foregroundColor(.gray.opacity(0.5))
                            .padding(.bottom, 20)
                    }
                }
                .task {
                    triggerLaunchFlow()
                }
            }
        }
    }
    
    private func triggerLaunchFlow() {
        Task {
            let success = await viewModel.executeLaunchApp()
            if success {
                // Berikan jeda transisi agar terlihat smooth
                try? await Task.sleep(nanoseconds: 800_000_000)
                withAnimation(.easeInOut(duration: 0.5)) {
                    isLaunched = true
                }
            }
        }
    }
}
