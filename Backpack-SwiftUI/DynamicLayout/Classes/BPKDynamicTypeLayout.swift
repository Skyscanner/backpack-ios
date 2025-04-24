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

import SwiftUI
import Backpack_Common

///  A dynamic layout view that adapts its layout based on the user's Dynamic Type size setting.
public struct BPKDynamicTypeLayout<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let threshold: DynamicTypeSize
    private let primaryLayout: AnyLayout
    private let secondaryLayout: AnyLayout
    private let content: Content

    /**
     Initialises the wrapper layout with custom layouts inside and a threshold for switching based on Dynamic Type size.
     - Parameters:
       - threshold: The Dynamic Type size threshold at which the layout switches.
       - primaryLayout: The layout used for smaller text sizes.
       - secondaryLayout: The layout used for larger text sizes.
       - content: The view content inside the layout.
     */
    public init(
        threshold: DynamicTypeSize = .accessibility1,
        primaryLayout: AnyLayout = AnyLayout(HStackLayout()),
        secondaryLayout: AnyLayout = AnyLayout(VStackLayout()),
        @ViewBuilder content: () -> Content
    ) {
        self.threshold = threshold
        self.primaryLayout = primaryLayout
        self.secondaryLayout = secondaryLayout
        self.content = content()
    }

    /**
     Initialises the stack with custom alignments, spacing, and a threshold for switching layouts on Dynamic Type size.
     - Parameters:
       - primaryHStackAlignment: The vertical alignment for the primary horizontal stack.
       - primaryHStackSpacing: The spacing between elements in the primary horizontal stack.
       - secondaryVStackSpacing: The spacing between elements in the secondary vertical stack.
       - secondaryVStackAlignment: The horizontal alignment for the secondary vertical stack.
       - threshold: The Dynamic Type size threshold at which the layout switches.
       - content: The view content inside the stack.
     */
    public init(
        primaryHStackAlignment: VerticalAlignment = .center,
        primaryHStackSpacing: BPKSpacing = .none,
        secondaryVStackAlignment: HorizontalAlignment = .center,
        secondaryVStackSpacing: BPKSpacing = .none,
        threshold: DynamicTypeSize = .accessibility1,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            threshold: threshold,
            primaryLayout: AnyLayout(
                HStackLayout(
                    alignment: primaryHStackAlignment,
                    spacing: primaryHStackSpacing.value
                )
            ),
            secondaryLayout: AnyLayout(
                VStackLayout(
                    alignment: secondaryVStackAlignment,
                    spacing: secondaryVStackSpacing.value
                )
            ),
            content: content
        )
    }

    public var body: some View {
        BPKDynamicLayout(
            primaryLayout: primaryLayout,
            secondaryLayout: secondaryLayout,
            activateSecondaryLayout: .constant(dynamicTypeSize >= threshold)
        ) {
            content
        }
    }
}
