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
import SwiftUI
import Backpack_SwiftUI

@MainActor
final class BPKCardListBehaviourTests: XCTestCase {
    func test_givenTabletOptIn_whenSizeClassChanges_thenColumnsAdaptWithoutDroppingOddCard() throws {
        let model = CardListTestModel()
        model.expanded = true
        let fixture = host(model: model, adaptive: true)
        defer { fixture.isHidden = true }
        let compact = try frames(model)
        XCTAssertGreaterThan(compact[1].minY, compact[0].minY)

        model.sizeClass = .regular
        settle(fixture)
        let regular = try frames(model)
        XCTAssertEqual(regular[0].minY, regular[1].minY, accuracy: 1)
        XCTAssertEqual(regular[0].width, regular[1].width, accuracy: 1)
        XCTAssertEqual(regular[0].width, regular[2].width, accuracy: 1)
        XCTAssertGreaterThan(regular[2].minY, regular[0].minY)
        XCTAssertTrue(model.expanded)

        model.sizeClass = .compact
        settle(fixture)
        XCTAssertGreaterThan(try frames(model)[1].minY, try frames(model)[0].minY)
    }

    func test_givenDefaultOrFalseOptIn_whenRegular_thenUsesOneColumn() throws {
        for adaptive: Bool? in [nil, false] {
            let model = CardListTestModel()
            model.sizeClass = .regular
            let fixture = host(model: model, adaptive: adaptive)
            defer { fixture.isHidden = true }
            let cards = try frames(model, count: 2)
            XCTAssertGreaterThan(cards[1].minY, cards[0].minY)
        }
    }

    func test_givenExpandedList_whenEmptyThenPopulated_thenBindingAndHeaderSurvive() throws {
        let model = CardListTestModel()
        let fixture = host(model: model, adaptive: true, header: true, empty: true)
        defer { fixture.isHidden = true }
        XCTAssertNil(model.frames["card-2"])
        model.expanded = true
        settle(fixture)
        XCTAssertEqual(try frames(model).count, 3)

        model.count = 0
        model.sizeClass = .regular
        settle(fixture)
        XCTAssertNotNil(model.frames["header"])
        XCTAssertNotNil(model.frames["empty"])
        XCTAssertFalse(model.frames.keys.contains { $0.hasPrefix("card-") })
        XCTAssertTrue(model.expanded)

        model.count = 3
        settle(fixture)
        XCTAssertEqual(try frames(model).count, 3)
        XCTAssertNil(model.frames["empty"])
        XCTAssertTrue(model.expanded)
    }

    func test_givenIndependentSlots_whenEmpty_thenOnlySuppliedSlotsRender() {
        for header in [false, true] {
            for empty in [false, true] {
                let model = CardListTestModel()
                model.count = 0
                let fixture = host(model: model, header: header, empty: empty)
                XCTAssertEqual(model.frames["header"] != nil, header)
                XCTAssertEqual(model.frames["empty"] != nil, empty)
                XCTAssertFalse(model.frames.keys.contains { $0.hasPrefix("card-") })
                fixture.isHidden = true
            }
        }
    }

    func test_givenTwoColumns_whenOnlyOneCard_thenRetainsHalfWidth() throws {
        let model = CardListTestModel()
        model.sizeClass = .regular
        model.expanded = true
        let fixture = host(model: model, adaptive: true)
        defer { fixture.isHidden = true }
        let fullRowWidth = try frames(model)[0].width
        model.count = 1
        settle(fixture)
        XCTAssertEqual(try frames(model, count: 1)[0].width, fullRowWidth, accuracy: 1)
    }

    func test_givenRail_whenTabletOptInEnabled_thenSingleCardStillFillsWidth() throws {
        let model = CardListTestModel()
        model.sizeClass = .regular
        model.count = 1
        let fixture = host(model: model, adaptive: true, layout: .rail())
        defer { fixture.isHidden = true }
        XCTAssertEqual(try frames(model, count: 1)[0].width, 600 - 2 * BPKSpacing.base.value, accuracy: 1)
    }

    private func frames(_ model: CardListTestModel, count: Int = 3) throws -> [CGRect] {
        try (0..<count).map { try XCTUnwrap(model.frames["card-\($0)"]) }
    }

    private func host(
        model: CardListTestModel,
        adaptive: Bool? = nil,
        header: Bool = false,
        empty: Bool = false,
        layout: BPKCardListLayout = .stack(accessory: .expand(expandText: "More", collapseText: "Less"))
    ) -> UIWindow {
        let view = CardListTestFixture(model: model, adaptive: adaptive, header: header, empty: empty, layout: layout)
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 600, height: 900))
        window.rootViewController = UIHostingController(rootView: view)
        window.makeKeyAndVisible()
        settle(window)
        return window
    }

    private func settle(_ window: UIWindow) {
        window.rootViewController?.view.layoutIfNeeded()
        RunLoop.current.run(until: Date().addingTimeInterval(0.1))
    }
}

private final class CardListTestModel: ObservableObject {
    @Published var count = 3
    @Published var expanded = false
    @Published var sizeClass = UserInterfaceSizeClass.compact
    var frames: [String: CGRect] = [:]
}

private struct CardListTestElement: Identifiable {
    let id: Int
}

private struct CardListTestFixture: View {
    @ObservedObject var model: CardListTestModel
    let adaptive: Bool?
    let header: Bool
    let empty: Bool
    let layout: BPKCardListLayout

    var body: some View {
        configuredList
            .environment(\.horizontalSizeClass, model.sizeClass)
            .onPreferenceChange(CardListFramesKey.self) { model.frames = $0 }
    }

    private var configuredList: some View {
        var list = BPKCardList(
            title: "Destinations", description: nil, layout: layout,
            initiallyShownCardsCount: 2,
            elements: (0..<model.count).map { CardListTestElement(id: $0) },
            showingAllCards: $model.expanded
        ) { element in
            BPKText("Card \(element.id)")
                .frame(maxWidth: .infinity)
                .captureCardListFrame("card-\(element.id)")
        }
        if let adaptive { list = list.useTwoColumnsOnTablet(adaptive) }
        if header { list = list.headerContent { BPKText("Filter").captureCardListFrame("header") } }
        if empty { list = list.emptyContent { BPKText("No results").captureCardListFrame("empty") } }
        return list
    }
}

private struct CardListFramesKey: PreferenceKey {
    static var defaultValue: [String: CGRect] = [:]
    static func reduce(value: inout [String: CGRect], nextValue: () -> [String: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { _, new in new })
    }
}

private extension View {
    func captureCardListFrame(_ name: String) -> some View {
        background(GeometryReader { proxy in
            Color.clear.preference(key: CardListFramesKey.self, value: [name: proxy.frame(in: .global)])
        })
    }
}
