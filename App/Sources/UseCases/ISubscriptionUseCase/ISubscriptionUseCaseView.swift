import SwiftUI

struct ISubscriptionUseCaseView: View {
    @StateObject private var viewModel = ISubscriptionUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("ISubscriptionUseCase Test")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Use case ini bertanggung jawab memverifikasi status pembelian & langganan aktif user.")
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
                            Text("Memverifikasi langganan...")
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
                    Text(viewModel.isLoading ? "Memverifikasi..." : "Verifikasi Mock Langganan")
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
        .navigationTitle("Subscription Use Case")
        .navigationBarTitleDisplayMode(.inline)
    }
}
