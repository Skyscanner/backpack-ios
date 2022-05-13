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
    
    let title: String
    let icon: Icon?
    let size: BPKButton.Size
    var style: BPKButton.Style = .primary
    let action: () -> Void
    @Binding var loading: Bool
    @Binding var enabled: Bool
    
    public init(
        _ title: String = "",
        icon: Icon? = nil,
        loading: Binding<Bool> = .constant(false),
        enabled: Binding<Bool> = .constant(true),
        size: BPKButton.Size = .default,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self._loading = loading
        self._enabled = enabled
        self.action = action
        self.size = size
    }
    
    public var body: some View {
        Button(action: action) {
            ZStack {
                if loading {
                    ProgressView()
                        .scaleEffect(size.spinnerScale)
                        .accessibilityHidden(true)
                }
                contentView
                    .opacity(loading ? 0 : 1)
            }
        }
        .buttonStyle(BPKButtonStyle(style: style, size: size, loading: loading, enabled: enabled, iconOnly: isIconOnly))
        .disabled(!enabled || loading)
        .clipShape(RoundedRectangle(cornerRadius: .sm))
    }
    
    public func buttonStyle(_ style: BPKButton.Style) -> BPKButton {
        var result = self
        result.style = style
        return result
    }
    
    private var titleContent: some View {
        Text(title)
            .font(style: size.fontStyle)
            .lineLimit(1)
    }
    
    private var isIconOnly: Bool {
        icon != nil && title == ""
    }
    
    private var iconSize: BPKIcon.Size {
        size == .large ? .large : .small
    }
    
    private func iconWithTitleContent(icon: Icon) -> some View {
        HStack(spacing: BPKSpacing.md.value) {
            if icon.position == .leading {
                BPKIconView(icon.icon, size: iconSize)
                titleContent
            } else {
                titleContent
                BPKIconView(icon.icon, size: iconSize)
            }
        }
    }
    
    private func iconOnlyContent(icon: Icon) -> some View {
        BPKIconView(icon.icon, size: iconSize)
    }
    
    private var contentView: some View {
        Group {
            if let icon = icon {
                if title != "" {
                    iconWithTitleContent(icon: icon)
                } else {
                    iconOnlyContent(icon: icon)
                }
            } else {
                titleContent
            }
        }
    }
}

private struct BPKButtonStyle: ButtonStyle {
    let style: BPKButton.Style
    let size: BPKButton.Size
    let loading: Bool
    let enabled: Bool
    let iconOnly: Bool
    
    func currentState(isPressed: Bool) -> BPKButton.CurrentState {
        if !enabled { return .disabled }
        if loading { return .loading }
        if isPressed { return .highlighted }
        return .regular
    }
    
    private var buttonWidth: CGFloat? {
        iconOnly ? size.height : nil
    }
    
    private func backgroundColor(_ configuration: Configuration) -> BPKColor {
        return style.colors.from(state: currentState(isPressed: configuration.isPressed)).background
    }
    
    private func foregroundColor(_ configuration: Configuration) -> BPKColor {
        return style.colors.from(state: currentState(isPressed: configuration.isPressed)).foreground
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: buttonWidth, height: size.height)
            .padding([.leading, .trailing], sidesPadding)
            .background(backgroundColor(configuration))
            .foregroundColor(foregroundColor(configuration))
            .clipShape(RoundedRectangle(cornerRadius: .sm))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
    
    private var sidesPadding: BPKSpacing {
        style == .link || style == .linkOnDark || iconOnly ? .none : .base
    }
}

extension BPKButton {
    public struct Icon {
        let icon: BPKIcon
        let position: IconPosition
        
        public init(icon: BPKIcon, position: IconPosition) {
            self.icon = icon
            self.position = position
        }
    }
    
    public enum Size {
        /// Default, smaller, button size.
        case `default`
        
        /// Larger button size.
        case large
        
        var height: CGFloat {
            self == .default ? 36 : 48
        }
        
        var fontStyle: BPKFontStyle {
            self == .default ? .label2 : .label1
        }
        
        var spinnerScale: CGFloat {
            self == .default ? 0.75 : 1
        }
    }
    
    public enum Style {
        /// Primary button style, suitable for use as the primary call to action
        case primary
        
        /// Secondary button style, suitable for secondary call to actions.
        case secondary
        
        /// Should typically be paired with a confirmation.
        case destructive
        
        /// the primary style.
        case featured
        
        /// Link button style, suitable for inline display and de-emphasized actions.
        case link
        
        /// Primary on Dark button style, suitable for use on dark coloured backgrounds.
        case primaryOnDark
        
        /// Primary on Light button style, suitable for use on light coloured backgrounds.
        case primaryOnLight
        
        /// Secondary on Dark button style, suitable for use on dark coloured backgrounds.
        case secondaryOnDark
        
        /// Link on Dark button style, suitable for use on dark coloured backgrounds.
        case linkOnDark
    }
    
    public enum IconPosition {
        /// The image positioned on the leading side of the label.
        case leading
        
        /// The image positioned on the trailing side of the label.
        case trailing
    }
}

extension BPKButton {
    enum CurrentState {
        case regular, loading, highlighted, disabled
        
        func foregroundColor(_ style: BPKButton.Style) -> BPKColor {
            switch self {
            case .regular: return style.colors.regular.foreground
            case .loading: return style.colors.loading.foreground
            case .highlighted: return style.colors.highlighted.foreground
            case .disabled: return style.colors.disabled.foreground
            }
        }
        
        func backgroundColor(_ style: BPKButton.Style) -> BPKColor {
            switch self {
            case .regular: return style.colors.regular.background
            case .loading: return style.colors.loading.background
            case .highlighted: return style.colors.highlighted.background
            case .disabled: return style.colors.disabled.background
            }
        }
    }
}

extension BPKButton.Style {
    struct ColorSets {
        let regular: Colors
        let highlighted: Colors
        let disabled: Colors
        let loading: Colors
        
        func from(state: BPKButton.CurrentState) -> Colors {
            switch state {
            case .regular: return regular
            case .loading: return loading
            case .highlighted: return highlighted
            case .disabled: return disabled
            }
        }
        
        struct Colors {
            let foreground: BPKColor
            let background: BPKColor
            
            static func with(_ foreground: BPKColor, and background: BPKColor) -> Colors {
                Colors(foreground: foreground, background: background)
            }
            
            static let staticDisabled = Colors(foreground: .skyGrayTint04, background: .skyGrayTint06)
            static let disabled = Colors(
                foreground: .skyGrayTint04.darkVariant(.blackTint03),
                background: .skyGrayTint06.darkVariant(.blackTint01)
            )
        }
        
        private static func regular(regular: Colors, highlighted: Colors) -> ColorSets {
            ColorSets(
                regular: regular,
                highlighted: highlighted,
                disabled: .disabled,
                loading: .disabled
            )
        }
        
        private static func regularStatic(regular: Colors, highlighted: Colors) -> ColorSets {
            ColorSets(
                regular: regular,
                highlighted: highlighted,
                disabled: .staticDisabled,
                loading: .staticDisabled
            )
        }
        
        private static func clear(regularForeground: BPKColor, highlightedForeground: BPKColor) -> ColorSets {
            let disabled = Colors(foreground: .skyGrayTint04.darkVariant(.blackTint03), background: .clear)
            return ColorSets(
                regular: Colors(foreground: regularForeground, background: .clear),
                highlighted: Colors(foreground: highlightedForeground, background: .clear),
                disabled: disabled,
                loading: disabled
            )
        }
        
        private static let pressedMonteverde = BPKColor(value: UIColor(red: 0, green: 0.416, blue: 0.38, alpha: 1))
        private static let textPrimary = BPKColor.white.darkVariant(.black)
        private static let textSecondary = BPKColor.skyBlueShade01.darkVariant(.skyBlueTint01)
        private static let backgroundSecondary = BPKColor.skyGrayTint06.darkVariant(.blackTint02)
        private static let destructiveColor = BPKColor(value: UIColor(red: 0.699, green: 0.182, blue: 0.269, alpha: 1))
            .darkVariant(BPKColor(value: UIColor(red: 0.972, green: 0.361, blue: 0.465, alpha: 1))
            )
        
        static let primary = ColorSets.regular(
            regular: .with(textPrimary, and: .monteverde),
            highlighted: .with(textPrimary, and: pressedMonteverde)
        )
        static let secondary = ColorSets.regular(
            regular: .with(textSecondary, and: backgroundSecondary),
            highlighted: .with(textSecondary, and: .skyGrayTint05.darkVariant(.blackTint01))
        )
        static let secondaryOnDark = ColorSets.regular(
            regular: .with(.white, and: .white.withAlphaComponent(0.1)),
            highlighted: .with(.white, and: .white.withAlphaComponent(0.15))
        )
        static let destructive = ColorSets.regular(
            regular: .with(destructiveColor, and: backgroundSecondary),
            highlighted: .with(textPrimary, and: destructiveColor)
        )
        static let featured = ColorSets.regular(
            regular: .with(textPrimary, and: .primaryColor),
            highlighted: .with(textPrimary, and: .skyBlueShade01)
        )
        static let link = ColorSets.clear(
            regularForeground: .primaryColor,
            highlightedForeground: .skyBlueShade01.darkVariant(.skyBlue)
        )
        static let linkOnDark = ColorSets.clear(
            regularForeground: .white,
            highlightedForeground: .white.withAlphaComponent(0.6)
        )
        static let primaryOnDark = ColorSets.regularStatic(
            regular: Colors(foreground: .skyGray, background: .white),
            highlighted: Colors(foreground: .skyGray, background: .skyGrayTint05)
        )
        static let primaryOnLight = ColorSets.regularStatic(
            regular: Colors(foreground: .white, background: .skyGray),
            highlighted: Colors(foreground: .white, background: .skyGrayTint01)
        )
    }
    var colors: ColorSets {
        switch self {
        case .primary: return .primary
        case .secondary: return .secondary
        case .secondaryOnDark: return .secondaryOnDark
        case .destructive: return .destructive
        case .featured: return .featured
        case .link: return .link
        case .linkOnDark: return .linkOnDark
        case .primaryOnDark: return .primaryOnDark
        case .primaryOnLight: return .primaryOnLight
        }
    }
}

struct Example: View {
    @State var times = 0
    @State var enabled = true
    @State var loading = false
    @State var title: String = "Click Me"
    @State var trailingIcon = true
    @State var buttonType: BPKButton.Style = .primary
    
    var body: some View {
        VStack {
            Toggle("Enabled", isOn: $enabled)
            Toggle("Loading", isOn: $loading)
            Toggle("Icon Position", isOn: $trailingIcon)
            HStack {
                Text("Change Title")
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
            }
            Text("Tapped \(times) times")
            Spacer()
            HStack {
                Spacer()
                BPKButton(
                    title,
                    icon: BPKButton.Icon(icon: .plus, position: trailingIcon ? .trailing : .leading),
                    loading: $loading,
                    enabled: $enabled,
                    size: .default
                ) { times += 1 }
                .buttonStyle(buttonType)
                Spacer()
                BPKButton(
                    title,
                    icon: BPKButton.Icon(icon: .plus, position: trailingIcon ? .trailing : .leading),
                    loading: $loading,
                    enabled: $enabled,
                    size: .large
                ) { times += 1 }
                .buttonStyle(buttonType)
                Spacer()
            }
            .padding()
            .background(buttonType == .primaryOnDark || buttonType == .secondaryOnDark || buttonType == .linkOnDark ? .black : .backgroundColor)
            Spacer()
            Picker("Style", selection: $buttonType) {
                Text("Primary").tag(BPKButton.Style.primary)
                Text("Primary On Light").tag(BPKButton.Style.primaryOnLight)
                Text("Primary On Dark").tag(BPKButton.Style.primaryOnDark)
                Text("Destructive").tag(BPKButton.Style.destructive)
                Text("Featured").tag(BPKButton.Style.featured)
                Text("Secondary").tag(BPKButton.Style.secondary)
                Text("Secondry On Dark").tag(BPKButton.Style.secondaryOnDark)
                Text("Link").tag(BPKButton.Style.link)
                Text("Link On Dark").tag(BPKButton.Style.linkOnDark)
            }
            .pickerStyle(.inline)
        }
        .padding()
    }
}
struct BPKButton_Previews: PreviewProvider {
    static var previews: some View {
        //        Group {
        //            HStack {
        //                VStack {
        //                    BPKButton("Click Me!") {}
        //                    BPKButton("Click Me!", icon: BPKButton.Icon(icon: .account, position: .leading)) {}
        //                    BPKButton("Click Me!", loading: .constant(true)) {}
        //                    BPKButton("Click Me!") {}
        //                    .buttonStyle(.link)
        //                }
        //                VStack {
        //                    BPKButton("Click Me!", size: .large) {}
        //                    BPKButton("Click Me!", icon: BPKButton.Icon(icon: .account, position: .leading), size: .large) {}
        //                    BPKButton("Click Me!", loading: .constant(true), size: .large) {}
        //                    BPKButton("Click Me!", size: .large) {}
        //                    .buttonStyle(.link)
        //                }
        //            }
        //            .previewLayout(.sizeThatFits)
        //        }
        Example()
    }
}
