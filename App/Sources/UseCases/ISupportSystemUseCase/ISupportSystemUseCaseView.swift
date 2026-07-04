import SwiftUI

struct ISupportSystemUseCaseView: View {
    @StateObject private var viewModel = ISupportSystemUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ISupportSystemUseCase Test")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini memeriksa apakah versi sistem operasi perangkat (iOS) masih didukung untuk menjalankan aplikasi.")
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
                            Text("Memeriksa sistem...")
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
                    Text(viewModel.isLoading ? "Memeriksa..." : "Periksa Mock OS")
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
        .navigationTitle("Support System Use Case")
        .navigationBarTitleDisplayMode(.inline)
    }
}
