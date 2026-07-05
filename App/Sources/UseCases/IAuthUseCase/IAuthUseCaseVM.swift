import FactoryKit
import Foundation
import XAuthKit

@MainActor
final class IAuthUseCaseVM: ObservableObject {
    @Injected(\.appRouter) private var router: AppRouter

    @Published var resultText: String = "Menunggu Aksi..."
    @Published var isLoading: Bool = false

    // Input Fields State (With default values)
    @Published var checkType: String = "isi"
    @Published var checkValue: String = "isi"

    @Published var appleToken: String = "isi"

    @Published var emailInput: String = "isi"
    @Published var passwordInput: String = "isi"

    @Published var googleToken: String = "isi"
    @Published var googleState: String = "isi"

    @Published var regEmail: String = "isi"
    @Published var regFirstName: String = "isi"
    @Published var regLastName: String = "isi"
    @Published var regPassword: String = "isi"

    @Published var otpFlag: Int = 1
    @Published var otpPhone: String = "isi"
    @Published var otpCountry: String = "isi"

    @Published var verifyCountry: String = "isi"
    @Published var verifyOtp: String = "isi"
    @Published var verifyPhone: String = "isi"

    private let authService: any AuthService

    init(
        authService: any AuthService = Container.shared.authService()
    ) {
        self.authService = authService
    }

    func checkRegisteredUser() async {
        isLoading = true
        resultText = "Memeriksa pengguna terdaftar..."
        do {
            let result = try await authService.checkRegisteredUser(
                type: checkType, value: checkValue)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func checkUserByPurchaseToken() async {
        isLoading = true
        resultText = "Memeriksa pengguna dengan purchase token..."
        do {
            let result = try await authService.checkUserByPurchaseToken()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByApple() async {
        isLoading = true
        resultText = "Memproses login Apple..."
        do {
            let result = try await authService.loginByApple(appleToken: appleToken)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByEmail() async {
        isLoading = true
        resultText = "Memproses login email..."
        do {
            let result = try await authService.loginByEmail(
                email: emailInput, password: passwordInput)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByGoogle() async {
        isLoading = true
        resultText = "Memproses login Google..."
        do {
            let result = try await authService.loginByGoogle(
                googleToken: googleToken, state: googleState)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByPurchaseToken() async {
        isLoading = true
        resultText = "Memproses login dengan purchase token..."
        do {
            let result = try await authService.loginByPurchaseToken()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func postLogout() async {
        isLoading = true
        resultText = "Memproses logout..."
        do {
            let result = try await authService.postLogout()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func postRefreshToken() async {
        isLoading = true
        resultText = "Memproses penyegaran token..."
        do {
            let result = try await authService.postRefreshToken()
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func registerForm() async {
        isLoading = true
        resultText = "Memproses pendaftaran..."
        do {
            let result = try await authService.registerForm(
                email: regEmail, firstName: regFirstName, lastName: regLastName,
                password: regPassword)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func sendOTP() async {
        isLoading = true
        resultText = "Mengirim OTP..."
        do {
            let result = try await authService.sendOTP(
                flag: otpFlag, phoneNumber: otpPhone, countryCode: otpCountry)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func verifyOTP() async {
        isLoading = true
        resultText = "Memverifikasi OTP..."
        do {
            let result = try await authService.verifyOTP(
                countryCode: verifyCountry, otp: verifyOtp, phoneNumber: verifyPhone)
            resultText = result
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func execute() async {
        await checkUserByPurchaseToken()
    }
}
