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

/// A layout wrapper view that switches between two layouts depending on a given condition.
///
/// `BPKDynamicLayout` allows you to provide two different layout configurations (e.g., HStack or VStack)
/// and dynamically switches between them based on an external Boolean condition, such as a Dynamic Type size threshold.
public struct BPKDynamicLayout<Content: View>: View {
    private let primaryLayout: AnyLayout
    private let secondaryLayout: AnyLayout
    @Binding var activateSecondaryLayout: Bool
    private let secondaryLayoutSizeClass: UserInterfaceSizeClass?
    private let content: Content
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    /**
     Initialises a dynamic layout that switches between two layouts depending on the value of `activateSecondaryLayout`.

     - Parameters:
       - primaryLayout: The primary layout to use when `activateSecondaryLayout` is false.
       - secondaryLayout: The secondary layout to use when `activateSecondaryLayout` is true.
       - activateSecondaryLayout: A binding that controls which layout is active.
       - content: A view builder that provides the content inside the layout.
     */
    public init(
        primaryLayout: AnyLayout,
        secondaryLayout: AnyLayout,
        activateSecondaryLayout: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self.primaryLayout = primaryLayout
        self.secondaryLayout = secondaryLayout
        _activateSecondaryLayout = activateSecondaryLayout
        self.secondaryLayoutSizeClass = nil
        self.content = content()
    }

    /**
     Initialises a dynamic layout that follows the width of the window it's shown in.

     Use it instead of checking the device type or the screen size: the window's size class changes with
     Split View, Slide Over, rotation, and folding or unfolding an iPhone Duo, and the layout follows it.

     ```swift
     BPKDynamicLayout(
         primaryLayout: AnyLayout(HStackLayout(spacing: BPKSpacing.base.value)),
         secondaryLayout: AnyLayout(VStackLayout(spacing: BPKSpacing.base.value)),
         secondaryLayoutForHorizontalSizeClass: .compact
     ) {
         FlightSummary()
         FareSummary()
     }
     ```

     - Parameters:
       - primaryLayout: The layout to use in any other horizontal size class.
       - secondaryLayout: The layout to use when the window's horizontal size class matches.
       - secondaryLayoutForHorizontalSizeClass: The horizontal size class that activates the secondary layout.
       - content: A view builder that provides the content inside the layout.
     */
    public init(
        primaryLayout: AnyLayout,
        secondaryLayout: AnyLayout,
        secondaryLayoutForHorizontalSizeClass sizeClass: UserInterfaceSizeClass,
        @ViewBuilder content: () -> Content
    ) {
        self.primaryLayout = primaryLayout
        self.secondaryLayout = secondaryLayout
        _activateSecondaryLayout = .constant(false)
        self.secondaryLayoutSizeClass = sizeClass
        self.content = content()
    }

    public var body: some View {
        let layout = usesSecondaryLayout ? secondaryLayout : primaryLayout

        layout {
            content
        }
    }

    private var usesSecondaryLayout: Bool {
        guard let secondaryLayoutSizeClass else {
            return activateSecondaryLayout
        }
        return horizontalSizeClass == secondaryLayoutSizeClass
    }
}
