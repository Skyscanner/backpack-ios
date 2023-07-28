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
import SnapshotTesting
import Backpack_SwiftUI

class BPKSnippetViewTests: XCTestCase {
    func testSnippetDefault() {
        assertSnapshot(
            BPKSnippet(
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn"
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSnippetNoImageWithHeadline() {
        assertSnapshot(
            BPKSnippet(
                image: Image("", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn",
                headline: "Headline Text"
            )
            .frame(width: 375)
            .padding()
        )
    }

    func testSnippetWithHeadline() {
        assertSnapshot(
            BPKSnippet(
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn",
                headline: "Headline Text"
            )
            .frame(width: 375)
            .padding()
        )
    }
    
    func testSnippetWithAllTextFields() {
        assertSnapshot(
            BPKSnippet(
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn",
                headline: "Headline Text",
                description: "Description",
                bodyText: "Body Text"
            )
            .frame(width: 375)
            .padding()
        )
    }

    func testSnippetWithLongDescription() {
        assertSnapshot(
            BPKSnippet(
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn",
                headline: "Headline Text",
                description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." +
                "Nulla tempus nec velit sit amet volutpat. Suspendisse potenti." +
                "Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                bodyText: "Body Text"
            )
            .frame(width: 375)
            .padding()
        )
    }

    func testSnippetWithLongBodyText() {
        assertSnapshot(
            BPKSnippet(
                image: Image("dialog_image", bundle: TestsBundle.bundle),
                accessibilityLabel: "City at dawn",
                headline: "Headline Text",
                description: "Description",
                bodyText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit." +
                "Nulla tempus nec velit sit amet volutpat. Suspendisse potenti." +
                "Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
            )
            .frame(width: 375)
            .padding()
        )
    }
}
