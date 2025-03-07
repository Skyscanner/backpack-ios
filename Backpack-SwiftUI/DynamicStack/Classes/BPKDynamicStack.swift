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

//  A dynamic stack view that adapts its layout based on the user's Dynamic Type size setting.
public struct BPKDynamicStack<Content: View>: View {
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize

    private let threshold: DynamicTypeSize
    private let primaryLayout: AnyLayout
    private let secondaryLayout: AnyLayout
    private let content: Content

    /**
     Initialises the stack with custom layouts and a threshold for switching based on Dynamic Type size.
     - Parameters:
       - threshold: The Dynamic Type size threshold at which the layout switches.
       - primaryLayout: The layout used for smaller text sizes.
       - secondaryLayout: The layout used for larger text sizes.
       - content: The view content inside the stack.
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
     Convenience initialiser that allows specifying alignment and spacing while maintaining dynamic layout switching.
     - Parameters:
       - horizontalAlignment: The alignment for the vertical stack.
       - verticalAlignment: The alignment for the horizontal stack.
       - spacing: The spacing between elements in both layouts.
       - threshold: The Dynamic Type size threshold at which the layout switches.
       - content: The view content inside the stack.
     */
    public init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: BPKSpacing = .none,
        threshold: DynamicTypeSize = .accessibility1,
        @ViewBuilder content: () -> Content
    ) {
        self.init(
            threshold: threshold,
            primaryLayout: AnyLayout(HStackLayout(alignment: verticalAlignment, spacing: spacing.value)),
            secondaryLayout: AnyLayout(VStackLayout(alignment: horizontalAlignment, spacing: spacing.value)),
            content: content
        )
    }

    public var body: some View {
        let layout = dynamicTypeSize >= threshold ? secondaryLayout : primaryLayout

        layout {
            content
        }
    }
}
