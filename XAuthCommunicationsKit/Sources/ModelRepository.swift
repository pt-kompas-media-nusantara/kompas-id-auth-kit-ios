
import Foundation

public protocol ModelRepository: Sendable {
    func data() async throws -> Model
}
