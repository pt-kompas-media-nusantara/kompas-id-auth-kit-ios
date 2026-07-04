import SwiftUI

struct IArticlesUseCaseView: View {
    @StateObject private var viewModel = IArticlesUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("IArticlesUseCase Test")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini bertanggung jawab mengelola pemuatan artikel premium dari server.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Log Eksekusi")
                            .font(.headline)
                        Spacer()
                        Text(viewModel.statusText)
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(viewModel.statusText == "Sukses" ? .green : .blue)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(8)
                    }
                    Divider()
                    
                    if viewModel.isExecuting {
                        HStack(spacing: 10) {
                            ProgressView()
                            Text("Mengambil artikel...")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 8)
                    }
                    
                    ScrollView {
                        Text(viewModel.logOutput.isEmpty ? "Belum ada data artikel dimuat." : viewModel.logOutput)
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
                
                Button(action: {
                    Task {
                        await viewModel.execute()
                    }
                }) {
                    Text(viewModel.isExecuting ? "Memuat..." : "Muat Mock Artikel")
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
        .navigationTitle("Articles Use Case")
        .navigationBarTitleDisplayMode(.inline)
    }
}
