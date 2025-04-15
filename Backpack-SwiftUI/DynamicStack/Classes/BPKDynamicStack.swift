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

/// A stack view that switches between two layouts depending on a given condition.
///
/// `BPKDynamicStack` allows you to provide two different layout configurations (e.g., HStack or VStack)
/// and dynamically switches between them based on an external Boolean condition, such as a Dynamic Type size threshold.
public struct BPKDynamicStack<Content: View>: View {
    private let primaryLayout: AnyLayout
    private let secondaryLayout: AnyLayout
    @Binding var activateSecondaryLayout: Bool
    private let content: Content

    /**
     Initialises a dynamic stack that switches between two layouts depending on the value of `activateSecondaryLayout`.

     - Parameters:
       - primaryLayout: The primary layout to use when `activateSecondaryLayout` is false.
       - secondaryLayout: The secondary layout to use when `activateSecondaryLayout` is true.
       - activateSecondaryLayout: A binding that controls which layout is active.
       - content: A view builder that provides the content inside the stack.
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
        self.content = content()
    }

    public var body: some View {
        let layout = activateSecondaryLayout ? secondaryLayout : primaryLayout

        layout {
            content
        }
    }
}
