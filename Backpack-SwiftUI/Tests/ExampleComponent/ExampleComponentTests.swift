import XCTest
@testable import Backpack_SwiftUI

class ExampleComponentTests: XCTestCase {
    func testExampleComponent() {
        let sut = ExampleComponent(content: "Example Content")
        XCTAssertEqual(sut.content, "Example Content")
    }
}
