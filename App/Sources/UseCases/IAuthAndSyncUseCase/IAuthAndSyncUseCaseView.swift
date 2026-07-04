import SwiftUI

struct IAuthAndSyncUseCaseView: View {
    @StateObject private var viewModel = IAuthAndSyncUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("IAuthAndSyncUseCase Test")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini menyinkronkan status otentikasi lokal dengan server KMP secara langsung.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Hasil Eksekusi")
                        .font(.headline)
                    Divider()
                    
                    if viewModel.isLoading {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Sedang memproses...")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                    } else {
                        Text(viewModel.resultText)
                            .font(.system(.subheadline, design: .monospaced))
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Button(action: {
                    Task {
                        await viewModel.execute()
                    }
                }) {
                    Text(viewModel.isLoading ? "Menjalankan..." : "Sinkronisasikan Sesi")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.isLoading ? Color.gray : Color.blue)
                        .cornerRadius(12)
                }
                .disabled(viewModel.isLoading)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle("Auth & Sync Use Case")
        .navigationBarTitleDisplayMode(.inline)
    }
}
