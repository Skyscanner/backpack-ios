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
import Backpack_Common
@testable import Backpack

final class BPKBottomSheetNativeSheetTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        BpkConfiguration.shared.reset()
        try BpkConfiguration.shared.set(configs: [.nativeBottomSheet])
    }

    override func tearDown() {
        BpkConfiguration.shared.reset()
        super.tearDown()
    }

    // MARK: - Configuration off

    func test_givenNoConfiguration_whenCreatedWithAScrollView_thenKeepsTheFloatingPanel() {
        // Given
        BpkConfiguration.shared.reset()

        // When
        let sut = BPKBottomSheet(contentViewController: UIViewController(), scrollViewToTrack: UIScrollView())

        // Then
        XCTAssertTrue(sut.viewControllerToPresent is BPKFloatingPanelController)
    }

    func test_givenNoConfiguration_whenCreatedToFitTheContent_thenKeepsTheFloatingPanel() {
        // Given
        BpkConfiguration.shared.reset()
        let content = UIViewController()

        // When
        let sut = BPKBottomSheet(contentViewController: content)

        // Then
        XCTAssertTrue(sut.viewControllerToPresent is BPKFloatingPanelController)
        XCTAssertTrue(sut.contentViewController === content)
    }

    func test_givenAnotherConfiguration_whenCreated_thenKeepsTheFloatingPanel() throws {
        // Given
        BpkConfiguration.shared.reset()
        try BpkConfiguration.shared.set(configs: [.all])

        // When
        let sut = BPKBottomSheet(contentViewController: UIViewController())

        // Then
        XCTAssertTrue(sut.viewControllerToPresent is BPKFloatingPanelController)
    }

    // MARK: - Modal style

    func test_givenModalStyle_whenCreated_thenPresentsANativePageSheetAtHalf() throws {
        // Given
        let content = UIViewController()

        // When
        let sut = BPKBottomSheet(contentViewController: content, scrollViewToTrack: UIScrollView())

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        XCTAssertEqual(sheet.modalPresentationStyle, .pageSheet)
        XCTAssertEqual(sheet.sheetPresentationController?.detents.map(\.identifier), [.bpkHalf, .large])
        XCTAssertEqual(sheet.sheetPresentationController?.selectedDetentIdentifier, .bpkHalf)
        XCTAssertEqual(sheet.sheetPresentationController?.prefersGrabberVisible, true)
        XCTAssertEqual(sheet.sheetPresentationController?.prefersEdgeAttachedInCompactHeight, false)
        XCTAssertTrue(sut.contentViewController === content)
    }

    func test_givenATopInset_whenCreated_thenTheFullPositionIsStillTheLargeHeight() throws {
        // When
        let sut = BPKBottomSheet(
            contentViewController: UIViewController(),
            scrollViewToTrack: UIScrollView(),
            insets: BottomSheetInsets(full: 64, half: 300, tip: nil)
        )

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        XCTAssertEqual(sheet.sheetPresentationController?.detents.map(\.identifier), [.bpkHalf, .large])
    }

    func test_givenAHalfHeight_whenItFitsTheSheet_thenTheHalfPositionUsesIt() throws {
        // When
        let sut = BPKBottomSheet(
            contentViewController: UIViewController(),
            scrollViewToTrack: UIScrollView(),
            insets: BottomSheetInsets(full: nil, half: 300, tip: nil)
        )

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        let half = try XCTUnwrap(sheet.sheetPresentationController?.detents.first)
        XCTAssertEqual(half.resolvedValue(in: DetentContext(maximumDetentValue: 700)), 300)
    }

    func test_givenAHalfHeight_whenItReachesTheTallestHeight_thenOnlyTheFullPositionIsLeft() throws {
        // When
        let sut = BPKBottomSheet(
            contentViewController: UIViewController(),
            scrollViewToTrack: UIScrollView(),
            insets: BottomSheetInsets(full: nil, half: 800, tip: nil)
        )

        // Then
        let sheet = try XCTUnwrap(sut.viewControllerToPresent as? BPKSheetViewController)
        let half = try XCTUnwrap(sheet.sheetPresentationController?.detents.first)
        XCTAssertNil(half.resolvedValue(in: DetentContext(maximumDetentValue: 700)))
    }

    func test_givenContentAndABottomSection_whenCreated_thenTheirViewsAreLoaded() {
        // Given
        let content = UIViewController()
        let bottomSection = UIViewController()

        // When
        _ = BPKBottomSheet(
            contentViewController: content,
            scrollViewToTrack: UIScrollView(),
            bottomSectionViewController: bottomSection
        )

        // Then
        XCTAssertTrue(content.isViewLoaded)
        XCTAssertTrue(bottomSection.isViewLoaded)
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

private final class DetentContext: NSObject, UISheetPresentationControllerDetentResolutionContext {
    let containerTraitCollection = UITraitCollection()
    let maximumDetentValue: CGFloat

    init(maximumDetentValue: CGFloat) {
        self.maximumDetentValue = maximumDetentValue
    }
}
