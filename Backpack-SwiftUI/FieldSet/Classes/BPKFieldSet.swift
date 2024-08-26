/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2023 Skyscanner Ltd. All rights reserved.
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
import UIKit

public protocol BPKFieldSetStatusHandling: View {
    associatedtype WrappedView: BPKFieldSetStatusHandling
    
    func inputState(_ state: BPKFieldSet<WrappedView>.State) -> WrappedView
}

/// A component which wraps its content (view) and optionally adds a title, description and error label (depending on the field's state) around it.
/// Supported states are Default, and Error. The states are dispatched to the wrapped view. The wrapped view must conform to `BPKFieldSetStatusHandling` to ensure it can handle the dispatched state.
///
/// Use `inputState(_ state: State)` to change the state of the field set.
///
/// Use `accessibilityPrefix(_ prefix: String)` to add a prefix to each accessibilityIdentifier
/// that gets added to all fieldset's subcomponents

public struct BPKFieldSet<Content: BPKFieldSetStatusHandling>: View {
    private var state: BPKFieldSet<Content.WrappedView>.State = .default
    private let label: String?
    private let content: Content
    private var description: String?
    private var accessibilityPrefix: String?
    
    public init(
        label: String? = nil,
        description: String? = nil,
        content: () -> Content
    ) {
        self.label = label
        self.description = description
        self.content = content()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .sm) {
            labelView
            content
                .inputState(state)
                .padding(.bottom, .sm)
                .accessibilityIdentifier(accessibilityIdentifier(for: "wrapped_view"))
            descriptionView
            if case let .error(message) = state {
                errorMessage(message)
                    .padding(.top, .sm)
            }
        }
    }
    
    @ViewBuilder
    private var labelView: some View {
        if let label {
            BPKText(label, style: .label2)
                .foregroundColor(state.labelColor)
                .accessibilityIdentifier(accessibilityIdentifier(for: "label"))
        }
    }
    
    @ViewBuilder
    private var descriptionView: some View {
        if let description {
            BPKText(description, style: .caption)
                .foregroundColor(state.descriptionColor)
                .accessibilityIdentifier(accessibilityIdentifier(for: "descritpion"))
        }
    }
    
    private func errorMessage(_ message: String) -> some View {
        HStack(spacing: .md) {
            BPKIconView(.exclamationCircle)
                .foregroundColor(.textErrorColor)
                .accessibilityHidden(true)
            BPKText(message, style: .caption)
                .foregroundColor(.textErrorColor)
                .accessibilityIdentifier(accessibilityIdentifier(for: "error_message"))
        }
    }
    
    public func inputState(_ state: BPKFieldSet<Content.WrappedView>.State) -> BPKFieldSet {
        var result = self
        result.state = state
        return result
    }
}

// MARK: - Accessibility

extension BPKFieldSet {
    public func accessibilityPrefix(_ prefix: String?) -> BPKFieldSet {
        var result = self
        result.accessibilityPrefix = prefix
        return result
    }
    
    private func accessibilityIdentifier(for label: String) -> String {
        if let prefix = accessibilityPrefix {
            return "\(prefix)_\(label)"
        }
        return ""
    }
}

// MARK: - Previews

#Preview("Default State") {
    ScrollView {
        constructViews(inErrorState: false)
        .padding()
    }
}

#Preview("Error State") {
    ScrollView {
        constructViews(inErrorState: true)
        .padding()
    }
}

// swiftlint:disable closure_body_length
@ViewBuilder
private func constructViews(inErrorState: Bool) -> some View {
    VStack(spacing: .base) {
        Text("With Label & Description").fontWeight(.bold)
        constructFieldSet(
            withLabel: "Label",
            andDescription: "Description",
            wrappedView: BPKTextField(placeholder: "Enter text", .constant("")),
            errorState: inErrorState
            )
        Divider()
        Text("With Label & No Description").fontWeight(.bold)
        constructFieldSet(
            withLabel: "Label",
            wrappedView: BPKTextField(placeholder: "Enter text", .constant("")),
            errorState: inErrorState
        )
        Divider()
        Text("With No Label & Description").fontWeight(.bold)
        constructFieldSet(
            andDescription: "Description",
            wrappedView: BPKTextArea(.constant(""), placeholder: "Enter text"),
            errorState: inErrorState
        )
        Divider()
        Text("With No Label & No Description").fontWeight(.bold)
        constructFieldSet(
            wrappedView: BPKSelect(
                placeholder: "Breakfast Choices",
                options: ["Porridge", "Eggs", "Swift UI"],
                selectedIndex: .constant(1)
            ),
            errorState: inErrorState
        )
    }
}

@ViewBuilder
private func constructFieldSet(
    withLabel label: String? = nil,
    andDescription description: String? = nil,
    wrappedView: some BPKFieldSetStatusHandling,
    errorState: Bool = false
) -> some View {
    BPKFieldSet(label: label, description: description) {
        wrappedView
    }
    .if(errorState) { view in
        view.inputState(.error(message: "Error Message"))
    }
}
