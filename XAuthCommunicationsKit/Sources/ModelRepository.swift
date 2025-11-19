
import Foundation

public protocol ModelRepository {
    func data() async throws -> Model
}
