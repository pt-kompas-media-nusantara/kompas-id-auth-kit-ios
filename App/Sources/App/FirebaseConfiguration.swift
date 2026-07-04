
import Foundation
import Firebase

/// Protokol abstraksi untuk menangani proses inisialisasi dan konfigurasi Firebase SDK.
protocol FirebaseConfiguration {
    /// Mengonfigurasi Firebase menggunakan berkas `.plist` spesifik berdasarkan skema aktif.
    func configure() async
}

/// Implementasi konkret untuk memuat berkas konfigurasi Firebase (`GoogleService-Info.plist`) secara dinamis.
struct FirebaseConfigurationImpl: FirebaseConfiguration {
    
    /// Mengonfigurasi instance Firebase secara dinamis saat startup.
    ///
    /// Logika pemuatan berkas konfigurasi dilakukan dengan membaca key `GOOGLE_SERVICE_INFO_PLIST_NAME` 
    /// dari Info.plist aplikasi. Hal ini memungkinkan pemisahan konfigurasi GoogleService-Info 
    /// antara lingkungan Staging dan Production berdasarkan skema build aktif.
    func configure() async {
        let key = "GOOGLE_SERVICE_INFO_PLIST_NAME"
        
        // Membaca nama berkas plist Firebase yang aktif dari Info.plist
        guard let firebaseName = Bundle.app.object(forInfoDictionaryKey: key) as? String,
              let plistLocation = Bundle.app.path(forResource: firebaseName, ofType: "plist"),
              let _ = FirebaseOptions(contentsOfFile: plistLocation) else { return }
        
        // TODO: Uncomment baris di bawah jika berkas Google Service Plist asli yang valid telah disertakan di proyek
        // FirebaseApp.configure(options: options)
    }
}

extension FirebaseConfigurationImpl {
    /// Factory method untuk membuat instance dari FirebaseConfiguration.
    static func create() -> FirebaseConfiguration {
        FirebaseConfigurationImpl()
    }
}
