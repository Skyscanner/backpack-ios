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
        style: BPKNavigationBarStyle,
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
        .frame(width: 300)
    }
    
    private func viewContent() -> some View {
        VStack {
            Image("dialog_image", bundle: TestsBundle.bundle)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(height: 100)
                .bpkOverlay(.linear(.high, .top))
                .clipped()
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
}
