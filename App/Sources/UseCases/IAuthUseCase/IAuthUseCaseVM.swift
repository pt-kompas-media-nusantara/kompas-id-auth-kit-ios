import FactoryKit
import Foundation
@preconcurrency import KompasIdLibrary
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

    private let authUseCase: any IAuthUseCase

    init(
        authUseCase: any IAuthUseCase = Container.shared.authUseCase(),
    ) {
        self.authUseCase = authUseCase
    }

    func checkRegisteredUser() async {
        isLoading = true
        resultText = "Memeriksa pengguna terdaftar..."
        do {
            let result = try await authUseCase.checkRegisteredUser(
                type: checkType, value: checkValue)
            resultText = "Sukses: \(result)"
            if let success = result as? ResultsSuccess<CheckRegisteredUserModel> {
                // success.value is your CheckRegisteredUserModel
                print("\(success)")
            } else if let failure = result as? ResultsError<NetworkError> {
                // failure.error is your NetworkError
                let networkError = failure.error
                // → handle error
                throw NetworkRequestError.badRequest ini cara handlenya gimana
            }
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func checkUserByPurchaseToken() async {
        isLoading = true
        resultText = "Memeriksa pengguna dengan purchase token..."
        do {
            let result = try await authUseCase.checkUserByPurchaseToken()
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByApple() async {
        isLoading = true
        resultText = "Memproses login Apple..."
        do {
            let result = try await authUseCase.loginByApple(accessTokenByApple: appleToken)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByEmail() async {
        isLoading = true
        resultText = "Memproses login email..."
        do {
            let result = try await authUseCase.loginByEmail(
                email: emailInput, password: passwordInput)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByGoogle() async {
        isLoading = true
        resultText = "Memproses login Google..."
        do {
            let result = try await authUseCase.loginByGoogle(
                accessTokenByGoogle: googleToken, state: googleState)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func loginByPurchaseToken() async {
        isLoading = true
        resultText = "Memproses login dengan purchase token..."
        do {
            let result = try await authUseCase.loginByPurchaseToken()
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func postLogout() async {
        isLoading = true
        resultText = "Memproses logout..."
        do {
            let result = try await authUseCase.postLogout()
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func postRefreshToken() async {
        isLoading = true
        resultText = "Memproses penyegaran token..."
        do {
            let result = try await authUseCase.postRefreshToken()
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func registerForm() async {
        isLoading = true
        resultText = "Memproses pendaftaran..."
        do {
            let result = try await authUseCase.registerForm(
                email: regEmail, firstName: regFirstName, lastName: regLastName,
                password: regPassword)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func sendOTP() async {
        isLoading = true
        resultText = "Mengirim OTP..."
        do {
            let result = try await authUseCase.sendOTP(
                flag: Int32(otpFlag), phoneNumber: otpPhone, countryCode: otpCountry)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func verifyOTP() async {
        isLoading = true
        resultText = "Memverifikasi OTP..."
        do {
            let result = try await authUseCase.verifyOTP(
                countryCode: verifyCountry, otp: verifyOtp, phoneNumber: verifyPhone)
            resultText = "Sukses: \(result)"
        } catch {
            resultText = "Gagal: \(error.localizedDescription)"
        }
        isLoading = false
    }

    func execute() async {
        await checkUserByPurchaseToken()
    }
}
