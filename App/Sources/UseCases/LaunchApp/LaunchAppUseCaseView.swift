import SwiftUI

struct LaunchAppUseCaseView: View {
    @StateObject private var viewModel = LaunchAppUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Deskripsi
                VStack(alignment: .leading, spacing: 8) {
                    Text("Launch App Use Case")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini bertanggung jawab atas sinkronisasi awal aplikasi, status force update, rekomendasi OS, dan status token pembelian App Store.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Card 1: Input Parameters (Dummy Data)
                VStack(alignment: .leading, spacing: 12) {
                    Text("Parameter Dummy")
                        .font(.headline)
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Platform:")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("iOS")
                                .fontWeight(.medium)
                        }
                        HStack {
                            Text("Device Name:")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("iPhone Simulator")
                                .fontWeight(.medium)
                        }
                        HStack {
                            Text("Env Configuration:")
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("ALL_PROD")
                                .fontWeight(.medium)
                        }
                    }
                    .font(.footnote)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Card 2: Logs & Output
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Log Eksekusi")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.statusText)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.statusText == "Sukses" ? .green : (viewModel.statusText == "Gagal" ? .red : .blue))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(8)
                    }
                    Divider()
                    
                    if viewModel.isExecuting {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Sedang memproses...")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                    
                    ScrollView {
                        Text(viewModel.logOutput.isEmpty ? "Belum ada eksekusi." : viewModel.logOutput)
                            .font(.system(.caption, design: .monospaced))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(8)
                    }
                    .frame(height: 150)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(8)
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Tombol Aksi
                Button(action: {
                    Task {
                        await viewModel.execute()
                    }
                }) {
                    Text(viewModel.isExecuting ? "Menjalankan..." : "Jalankan Use Case")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isExecuting ? Color.gray : Color.blue)
                        .cornerRadius(12)
                }
                .disabled(viewModel.isExecuting)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Launch App Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}
