import Foundation

public struct Model: Sendable {
    
    public init(value: Int) {
        self.value = value
    }
    
    public let value: Int
}
