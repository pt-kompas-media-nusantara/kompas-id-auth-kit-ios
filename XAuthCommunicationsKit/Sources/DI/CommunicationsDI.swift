import FactoryKit
import Foundation

extension Container {
    // Registrasikan ModelRepository ke Container secara publik
    // agar modul lain yang mengimpor Factory & XAuthCommunicationsKit bisa me-resolve.
    // Implementasinya (ModelRepositoryImpl) tetap tersembunyi sebagai internal modul.
    public var modelRepository: Factory<ModelRepository> {
        self { ModelRepositoryImpl() }
    }
}
