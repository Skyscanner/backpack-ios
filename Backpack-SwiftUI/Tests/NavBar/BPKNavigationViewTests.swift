/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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
import UIKit
@testable import Backpack_SwiftUI
import SnapshotTesting

class BPKNavigationViewTests: XCTestCase {
    private func navView<Content: View>(
        style: BPKNavigationView<Content>.Style,
        content: @escaping () -> Content
    ) -> some View {
        BPKNavigationView(
            title: "Title",
            leadingItems: [.init(type: .backButton(""), action: {})],
            trailingItems: [
                .init(type: .icon(.account, ""), action: {}),
                .init(type: .title("Action"), action: {})
            ],
            style: style,
            content: { content() }
        )
    }
    
    private func viewContent() -> some View {
        VStack {
            Image("dialog_image", bundle: TestsBundle.bundle)
                .resizable()
                .aspectRatio(contentMode: .fill)
            Text("Screen content")
        }
        .ignoresSafeArea(edges: .top)
    }
    
    func test_default() {
        assertSnapshot(navView(style: .default(.automatic), content: viewContent))
    }
    
    func test_transparent() {
        assertSnapshot(navView(style: .transparent(.automatic), content: viewContent))
    }
    
    func test_surfaceContrast() {
        assertSnapshot(navView(style: .surfaceContrast, content: viewContent))
    }
    
    func test_titleDisplayMode_default() {
        let largeSUT = BPKNavigationView<Text>.Style.default(.large)
        XCTAssertEqual(largeSUT.displayMode, .large)

        let inlineSUT = BPKNavigationView<Text>.Style.default(.inline)
        XCTAssertEqual(inlineSUT.displayMode, .inline)

        let automaticSUT = BPKNavigationView<Text>.Style.default(.automatic)
        XCTAssertEqual(automaticSUT.displayMode, .automatic)
    }

    func test_titleDisplayMode_transparent() {
        let largeSUT = BPKNavigationView<Text>.Style.transparent(.large)
        XCTAssertEqual(largeSUT.displayMode, .large)

        let inlineSUT = BPKNavigationView<Text>.Style.transparent(.inline)
        XCTAssertEqual(inlineSUT.displayMode, .inline)

        let automaticSUT = BPKNavigationView<Text>.Style.transparent(.automatic)
        XCTAssertEqual(automaticSUT.displayMode, .automatic)
    }

    func test_titleDisplayMode_surfaceContrast() {
        let sut = BPKNavigationView<Text>.Style.surfaceContrast
        XCTAssertEqual(sut.displayMode, .inline)
    }
    
    func test_navBarAppearance_default() {
        let sut = BPKNavigationView<Text>.Style.default(.automatic).navBarAppearance
        
        XCTAssertEqual(sut.backgroundColor, BPKColor.canvasColor.value)
        XCTAssertEqual(sut.shadowColor, BPKColor.lineColor.value)
        XCTAssertEqual(sut.titleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textPrimaryColor.value)
        XCTAssertEqual(sut.largeTitleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textPrimaryColor.value)
    }
    
    func test_navBarAppearance_transparent() {
        let sut = BPKNavigationView<Text>.Style.transparent(.automatic).navBarAppearance
        
        XCTAssertNil(sut.backgroundColor)
        XCTAssertNil(sut.shadowColor)
        XCTAssertEqual(sut.titleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textOnDarkColor.value)
        XCTAssertEqual(sut.largeTitleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textOnDarkColor.value)
    }
    
    func test_navBarAppearance_surfaceContrast() {
        let sut = BPKNavigationView<Text>.Style.surfaceContrast.navBarAppearance
        
        XCTAssertEqual(sut.backgroundColor, BPKColor.surfaceContrastColor.value)
        XCTAssertEqual(sut.shadowColor, BPKColor.lineOnDarkColor.value)
        XCTAssertEqual(sut.titleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textOnDarkColor.value)
        XCTAssertEqual(sut.largeTitleTextAttributes[.foregroundColor] as? UIColor, BPKColor.textOnDarkColor.value)
    }
}
