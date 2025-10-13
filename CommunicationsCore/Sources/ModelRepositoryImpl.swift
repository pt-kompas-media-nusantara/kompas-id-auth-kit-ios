
import Foundation

class ModelRepositoryImpl: ModelRepository {
    
    func data() async throws -> Model {
        Model(value: 1)
    }
}
