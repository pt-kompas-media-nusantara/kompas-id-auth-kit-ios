
import XCTest
@testable import XAuthCommunicationsKit

class ModelRepositoryImplTest: XCTestCase {
    
    func test_should_return_1() async throws {
        let sut = ModelRepositoryImpl()
        let result = try await sut.data()
        XCTAssertEqual(1, result.value)
    }
}
