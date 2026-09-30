/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest
@testable import Backpack

final class BPKBottomSheetNativeSheetTests: XCTestCase {

    // MARK: - Modal style

    func test_givenModalStyle_whenCreated_thenPresentsANativePageSheetAtHalf() throws {
        // Given
        let content = UIViewController()

        // When
        let sut = BPKBottomSheet(contentViewController: content, scrollViewToTrack: UIScrollView())

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        XCTAssertEqual(sheet.modalPresentationStyle, .pageSheet)
        XCTAssertEqual(sheet.sheetPresentationController?.detents.map(\.identifier), [.bpkHalf, .bpkFull])
        XCTAssertEqual(sheet.sheetPresentationController?.selectedDetentIdentifier, .bpkHalf)
        XCTAssertEqual(sheet.sheetPresentationController?.prefersGrabberVisible, true)
        XCTAssertTrue(sut.contentViewController === content)
    }

    func test_givenContentWithoutAScrollView_whenCreated_thenTheSheetFitsTheContent() throws {
        // When
        let sut = BPKBottomSheet(contentViewController: UIViewController())

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        XCTAssertEqual(sheet.sheetPresentationController?.detents.map(\.identifier), [.bpkFit])
    }

    func test_givenABottomSection_whenCreated_thenItIsPinnedInTheSheet() throws {
        // Given
        let bottomSection = UIViewController()

        // When
        let sut = BPKBottomSheet(
            contentViewController: UIViewController(),
            scrollViewToTrack: UIScrollView(),
            bottomSectionViewController: bottomSection
        )
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        sheet.loadViewIfNeeded()

        // Then
        XCTAssertTrue(sut.bottomSectionViewController === bottomSection)
        XCTAssertTrue(bottomSection.parent === sheet)
    }

    func test_givenAnOnDismissedClosure_whenSet_thenTheNativeSheetKeepsIt() throws {
        // Given
        let sut = BPKBottomSheet(contentViewController: UIViewController())
        var dismissed = false

        // When
        sut.onDismissed = { dismissed = true }
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        sheet.onDismissed?()

        // Then
        XCTAssertTrue(dismissed)
    }

    func test_givenAModalSheet_whenCreated_thenTheSheetKeepsTheBottomSheetAlive() throws {
        // Given
        weak var weakBottomSheet: BPKBottomSheet?
        var sheet: BPKSheetViewController?

        // When
        autoreleasepool {
            let bottomSheet = BPKBottomSheet(contentViewController: UIViewController())
            weakBottomSheet = bottomSheet
            sheet = bottomSheet.viewControllerToPresent as? BPKSheetViewController
        }

        // Then
        XCTAssertNotNil(sheet)
        XCTAssertNotNil(weakBottomSheet)
    }

    // MARK: - Persistent style

    func test_givenPersistentStyle_whenCreated_thenKeepsTheFloatingPanel() {
        // When
        let sut = BPKBottomSheet(
            contentViewController: UIViewController(),
            scrollViewToTrack: UIScrollView(),
            presentationStyle: .persistent
        )

        // Then
        XCTAssertTrue(sut.viewControllerToPresent is BPKFloatingPanelController)
    }
}
