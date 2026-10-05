import XCTest
import UIKit
@testable import Backpack_SwiftUI

final class UIKitDialogContainerViewModifierTests: XCTestCase {
    func test_whenPresenterIsReleased_thenWeakReferenceIsCleared() {
        // Given
        let reference = WeakPresenterReference()
        var presenter: UIViewController? = UIViewController()
        reference.controller = presenter

        // When
        presenter = nil

        // Then
        XCTAssertNil(reference.controller)
    }
}
