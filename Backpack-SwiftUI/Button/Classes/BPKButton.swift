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

public struct BPKButton: View {
    private let title: String?
    private let icon: Icon?
    private let size: BPKButton.Size
    private var style: BPKButton.Style = .primary
    private var accessibilityLabel: String
    private let action: () -> Void
    
    @Binding private var loading: Bool
    @Binding private var enabled: Bool
    
    public init(
        icon: BPKIcon,
        accessibilityLabel: String,
        loading: Binding<Bool> = .constant(false),
        enabled: Binding<Bool> = .constant(true),
        size: BPKButton.Size = .default,
        action: @escaping () -> Void
    ) {
        self.title = nil
        self.accessibilityLabel = accessibilityLabel
        self.icon = Icon(icon: icon, position: .leading)
        self._loading = loading
        self._enabled = enabled
        self.action = action
        self.size = size
    }
    
    public init(
        _ title: String,
        icon: Icon? = nil,
        loading: Binding<Bool> = .constant(false),
        enabled: Binding<Bool> = .constant(true),
        size: BPKButton.Size = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.accessibilityLabel = title
        self.icon = icon
        self._loading = loading
        self._enabled = enabled
        self.action = action
        self.size = size
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                ButtonLoadingContentView(loading: loading, size: size)
                ButtonContentView(title: title, size: size, icon: icon)
                    .opacity(loading ? 0 : 1)
            }
        }
        .accessibilityLabel(accessibilityLabel)
        .buttonStyle(buttonStyle)
        .disabled(!enabled || loading)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
    }
    
    public func buttonStyle(_ style: BPKButton.Style) -> BPKButton {
        var result = self
        result.style = style
        return result
    }
    
    public func accessiblityLabel(_ text: String) -> BPKButton {
        var result = self
        result.accessibilityLabel = accessibilityLabel
        return result
    }
    
    private var buttonStyle: CurrentStateButtonStyle {
        CurrentStateButtonStyle(
            style: style,
            size: size,
            iconOnly: isIconOnly,
            getCurrentState: currentState(isPressed:),
            colorProvider: ButtonColorProvider(
                colorSetFactory: DefaultButtonColorSetFactory()
            )
        )
    }
    
    private func currentState(isPressed: Bool) -> BPKButton.CurrentState {
        if !enabled { return .disabled }
        if loading { return .loading }
        if isPressed { return .highlighted }
        return .regular
    }
    
    private var isIconOnly: Bool {
        icon != nil && title == nil
    }
}

private struct ButtonLoadingContentView: View {
    let loading: Bool
    let size: BPKButton.Size
    
    var body: some View {
        if loading {
            BPKSpinner(spinnerSize, style: .disabled)
                .accessibilityHidden(true)
        }
    }
    
    private var spinnerSize: BPKSpinner.Size {
        size == .default ? .sm : .lg
    }
}

private struct ButtonContentView: View {
    let title: String?
    let size: BPKButton.Size
    let icon: BPKButton.Icon?
    
    var body: some View {
        if let icon = icon {
            if let title = title, title != "" {
                content(withIcon: icon, title: title)
            } else {
                content(withIcon: icon)
            }
        } else if let title = title {
            content(withTitle: title)
        }
    }
    
    private var fontStyle: BPKFontStyle {
        size == .default ? .label2 : .label1
    }
    
    private func content(withTitle title: String) -> some View {
        Text(title)
            .font(style: fontStyle)
            .lineLimit(1)
    }
    
    private var iconSize: BPKIcon.Size {
        size == .large ? .large : .small
    }
    
    private func content(withIcon icon: BPKButton.Icon, title: String) -> some View {
        HStack(spacing: BPKSpacing.md.value) {
            if icon.position == .leading {
                content(withIcon: icon)
                content(withTitle: title)
            } else {
                content(withTitle: title)
                content(withIcon: icon)
            }
        }
    }
    
    private func content(withIcon icon: BPKButton.Icon) -> BPKIconView {
        BPKIconView(icon.icon, size: iconSize)
    }
}

struct BPKButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKButton("Click Me!") {}
            BPKButton("Click Me!", icon: BPKButton.Icon(icon: .account, position: .leading)) {}
            BPKButton("Click Me!", loading: .constant(true)) {}
            BPKButton("Click Me!") {}
            .buttonStyle(.link)
        }
        .previewLayout(.sizeThatFits)
    }
}
