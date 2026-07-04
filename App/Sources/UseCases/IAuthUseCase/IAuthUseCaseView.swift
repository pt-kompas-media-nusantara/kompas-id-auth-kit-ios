import SwiftUI

struct IAuthUseCaseView: View {
    @StateObject private var viewModel = IAuthUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Deskripsi
                VStack(alignment: .leading, spacing: 8) {
                    Text("IAuthUseCase Test")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini bertanggung jawab untuk memeriksa status otentikasi akun pengguna menggunakan token pembelian di sisi iOS.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Card: Logs & Output
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
                    .frame(height: 200)
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
                        await viewModel.executeCheckUser()
                    }
                }) {
                    Text(viewModel.isExecuting ? "Menjalankan..." : "Periksa User Status")
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
        .navigationTitle("Auth Use Case")
        .navigationBarTitleDisplayMode(.inline)
    }
}
