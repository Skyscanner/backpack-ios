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
@testable import Backpack_SwiftUI

final class DialogLayoutTests: XCTestCase {
    private let dialogWidth: CGFloat = 352
    /// Room for the text and button, but less than twice that, so sharing the height evenly with the
    /// header would squeeze the text.
    private let windowHeight: CGFloat = 300
    /// Less than the text, its spacing and the button need, so the text has to scroll.
    private let shortWindowHeight: CGFloat = 160

    func test_whenHeaderCanShrink_thenTextAndButtonGetTheirHeightFirst() {
        let textAndButtonHeight = height(of: dialog { Color.clear.frame(height: 0) }, offered: .greatestFiniteMagnitude)
        let header = HeightRecorder()

        layOut(dialog { header.view }, height: windowHeight)

        XCTAssertEqual(header.height, windowHeight - textAndButtonHeight, accuracy: 0.5)
    }

    func test_whenTextDoesNotFit_thenDialogStaysWithinTheOfferedHeight() {
        let imageDialog = dialog { DialogImageView(image: Image("dialog_image", bundle: TestsBundle.bundle)) }

        XCTAssertLessThanOrEqual(height(of: imageDialog, offered: shortWindowHeight), shortWindowHeight + 0.5)
    }

    // MARK: - Helpers

    private func dialog<Header: View>(@ViewBuilder header: () -> Header) -> some View {
        DialogWithHeaderContent(
            textContent: DialogTextContent(
                title: "Title in here",
                text: "Description that goes two lines ideally, but sometimes it can go longer",
                contentAlignment: .leading
            ),
            actions: DialogActionsView(buttons: [BPKDialogButton("Confirmation") {}]),
            headerView: header
        )
    }

    private func height<V: View>(of view: V, offered height: CGFloat) -> CGFloat {
        UIHostingController(rootView: view)
            .sizeThatFits(in: CGSize(width: dialogWidth, height: height))
            .height
    }

    private func layOut<V: View>(_ view: V, height: CGFloat) {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: dialogWidth, height: height))
        // The window sits at the top of the test device's screen, so without this its status bar
        // area would take height from the dialog.
        window.rootViewController = UIHostingController(rootView: view.ignoresSafeArea())
        window.makeKeyAndVisible()
        window.layoutIfNeeded()
    }
}

/// A header that takes whatever height it's offered, like a resizable image, and records it.
private final class HeightRecorder {
    private(set) var height: CGFloat = 0

    var view: some View {
        GeometryReader { proxy in
            let _ = self.record(proxy.size.height)
            Color.clear
        }
    }

    private func record(_ height: CGFloat) {
        self.height = height
    }
}
