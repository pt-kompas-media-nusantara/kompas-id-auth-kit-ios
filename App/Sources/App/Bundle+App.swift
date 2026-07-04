
import Foundation

extension Bundle {
    
    /// Properti pembungkus (convenience property) untuk mengakses bundle utama (`Bundle.main`).
    /// Berfungsi sebagai jalan pintas terpusat untuk memuat berkas konfigurasi atau aset dari bundle aplikasi utama.
    static var app: Bundle {
        Bundle.main
    }
}
