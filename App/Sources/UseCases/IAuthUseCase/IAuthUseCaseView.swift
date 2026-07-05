import SwiftUI

struct IAuthUseCaseView: View {
    @StateObject private var viewModel = IAuthUseCaseVM()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header Panel
                VStack(alignment: .leading, spacing: 8) {
                    Text("IAuthUseCase Dashboard")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Kelola dan uji seluruh metode otentikasi akun di sisi iOS secara dinamis.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // Result Card (Monitor Execution Output)
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Hasil Eksekusi")
                            .font(.headline)
                            .fontWeight(.bold)
                        Spacer()
                        if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    Divider()
                    
                    Text(viewModel.resultText)
                        .font(.system(.subheadline, design: .monospaced))
                        .foregroundColor(viewModel.resultText.contains("Gagal") ? .red : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .animation(.easeInOut, value: viewModel.resultText)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(viewModel.resultText.contains("Gagal") ? Color.red.opacity(0.3) : Color.blue.opacity(0.2), lineWidth: 1)
                        )
                )
                .padding(.horizontal)
                
                // Segmented Actions
                VStack(spacing: 16) {
                    // Group 1: User & Token Verification
                    ActionCardView(title: "Status & Verifikasi User", iconName: "checkmark.shield.fill") {
                        VStack(spacing: 12) {
                            // Check Registered User
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Check Registered User")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 8) {
                                    TextField("Type", text: $viewModel.checkType)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Value", text: $viewModel.checkValue)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                ActionButton(title: "Periksa Pengguna", systemImage: "person.fill.badge.plus") {
                                    await viewModel.checkRegisteredUser()
                                }
                            }
                            
                            Divider()
                            
                            // Check User By Purchase Token
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Check User By Purchase Token")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                ActionButton(title: "Periksa Purchase Token", systemImage: "key.fill") {
                                    await viewModel.checkUserByPurchaseToken()
                                }
                            }
                        }
                    }
                    
                    // Group 2: Login Methods
                    ActionCardView(title: "Metode Log In", iconName: "lock.open.fill") {
                        VStack(spacing: 14) {
                            // Login By Email
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Email Login")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                TextField("Email", text: $viewModel.emailInput)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                SecureField("Password", text: $viewModel.passwordInput)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                ActionButton(title: "Login dengan Email", systemImage: "envelope.fill") {
                                    await viewModel.loginByEmail()
                                }
                            }
                            
                            Divider()
                            
                            // Login By Apple
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Apple Login")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                TextField("Access Token Apple", text: $viewModel.appleToken)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                ActionButton(title: "Login dengan Apple", systemImage: "applelogo") {
                                    await viewModel.loginByApple()
                                }
                            }
                            
                            Divider()
                            
                            // Login By Google
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Google Login")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                TextField("Access Token Google", text: $viewModel.googleToken)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                TextField("State", text: $viewModel.googleState)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                ActionButton(title: "Login dengan Google", systemImage: "globe") {
                                    await viewModel.loginByGoogle()
                                }
                            }
                            
                            Divider()
                            
                            // Login By Purchase Token
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Login By Purchase Token")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                ActionButton(title: "Login Purchase Token", systemImage: "cart.fill") {
                                    await viewModel.loginByPurchaseToken()
                                }
                            }
                        }
                    }
                    
                    // Group 3: Form Registration & OTP
                    ActionCardView(title: "Registrasi & Kode OTP", iconName: "paperplane.fill") {
                        VStack(spacing: 14) {
                            // Register Form
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Register Account Form")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                TextField("Email", text: $viewModel.regEmail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                HStack(spacing: 8) {
                                    TextField("First Name", text: $viewModel.regFirstName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Last Name", text: $viewModel.regLastName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                SecureField("Password", text: $viewModel.regPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                ActionButton(title: "Daftar Akun Baru", systemImage: "doc.text.badge.plus") {
                                    await viewModel.registerForm()
                                }
                            }
                            
                            Divider()
                            
                            // Send OTP
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Send OTP Code")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 8) {
                                    Stepper("Flag: \(viewModel.otpFlag)", value: $viewModel.otpFlag, in: 0...99)
                                        .font(.footnote)
                                    TextField("Phone", text: $viewModel.otpPhone)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.phonePad)
                                    TextField("Country", text: $viewModel.otpCountry)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                ActionButton(title: "Kirim OTP", systemImage: "message.fill") {
                                    await viewModel.sendOTP()
                                }
                            }
                            
                            Divider()
                            
                            // Verify OTP
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Verify OTP Code")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                HStack(spacing: 8) {
                                    TextField("Country", text: $viewModel.verifyCountry)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("OTP", text: $viewModel.verifyOtp)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    TextField("Phone", text: $viewModel.verifyPhone)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                ActionButton(title: "Verifikasi OTP", systemImage: "checkmark.circle.fill") {
                                    await viewModel.verifyOTP()
                                }
                            }
                        }
                    }
                    
                    // Group 4: Session Control
                    ActionCardView(title: "Kontrol Sesi Pengguna", iconName: "arrow.triangle.2.circlepath") {
                        VStack(spacing: 12) {
                            ActionButton(title: "Segarkan Token (Refresh)", systemImage: "arrow.clockwise.circle.fill") {
                                await viewModel.postRefreshToken()
                            }
                            ActionButton(title: "Keluar (Log Out)", systemImage: "arrow.backward.circle.fill", isDestructive: true) {
                                await viewModel.postLogout()
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle("Auth Testing Suite")
        .navigationBarTitleDisplayMode(.inline)
        .disabled(viewModel.isLoading)
    }
}

// MARK: - Helper Views for Gorgeous UI Style

struct ActionCardView<Content: View>: View {
    let title: String
    let iconName: String
    let content: Content
    
    init(title: String, iconName: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.iconName = iconName
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
                    .font(.system(size: 16, weight: .bold))
                Text(title)
                    .font(.system(size: 16, weight: .bold))
            }
            content
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}

struct ActionButton: View {
    let title: String
    let systemImage: String
    var isDestructive: Bool = false
    let action: () async -> Void
    
    @Environment(\.isEnabled) private var isEnabled
    
    var body: some View {
        Button(action: {
            Task {
                await action()
            }
        }) {
            HStack {
                Image(systemName: systemImage)
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isDestructive ? Color.red : Color.blue)
            .cornerRadius(10)
        }
        .opacity(isEnabled ? 1.0 : 0.6)
    }
}
