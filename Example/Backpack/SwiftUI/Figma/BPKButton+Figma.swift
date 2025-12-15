import SwiftUI
import Figma
import Backpack_SwiftUI

// MARK: - Icon = Left
struct BpkButton_IconLeft_CodeConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKButton.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-8677"
    let variant = ["Icon" : "Left"]

    private var title: String = "Label"

    @FigmaEnum(
        "Style",
        mapping: [
            "Primary": .primary,
            "Secondary": .secondary,
            "Featured": .featured,
            "Primary on light": .primaryOnLight,
            "Primary on dark": .primaryOnDark,
            "Secondary on dark": .secondaryOnDark,
            "Destructive": .destructive,
            "Link": .link,
            "Link on dark": .linkOnDark
        ]
    )
    var style: Backpack_SwiftUI.BPKButton.Style = .primary

    @FigmaEnum("Size", mapping: ["Default": .default, "Large": .large])
    var size: Backpack_SwiftUI.BPKButton.Size = .default

    static let any_icon = Backpack_SwiftUI.BPKIcon.arrowRight

    @FigmaEnum(
        "Icon",
        mapping: [
            "Left": .init(icon: Self.any_icon, position: .leading),
            "None": nil,
            "Right": .init(icon: Self.any_icon, position: .trailing),
            "Icon only": .init(icon: Self.any_icon, position: .leading)
        ]
    )
    var icon: Backpack_SwiftUI.BPKButton.Icon? = .init(icon: .arrowRight, position: .leading)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(false),
            "Hover": .constant(false),
            "Pressed": .constant(false),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var loadingBinding: Binding<Bool> = .constant(false)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(true),
            "Hover": .constant(true),
            "Pressed": .constant(true),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var enabledBinding: Binding<Bool> = .constant(false)

    var body: some View {
        BPKButton(
            title,
            icon: icon,
            loading: loadingBinding,
            enabled: enabledBinding,
            size: size,
            action: {}
        )
        .buttonStyle(style)
    }
}

// MARK: - Icon = Right
struct BpkButton_IconRight_CodeConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKButton.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-8677"
    let variant = ["Icon" : "Right"]

    private var title: String = "Label"

    @FigmaEnum(
        "Style",
        mapping: [
            "Primary": .primary,
            "Secondary": .secondary,
            "Featured": .featured,
            "Primary on light": .primaryOnLight,
            "Primary on dark": .primaryOnDark,
            "Secondary on dark": .secondaryOnDark,
            "Destructive": .destructive,
            "Link": .link,
            "Link on dark": .linkOnDark
        ]
    )
    var style: Backpack_SwiftUI.BPKButton.Style = .primary

    @FigmaEnum("Size", mapping: ["Default": .default, "Large": .large])
    var size: Backpack_SwiftUI.BPKButton.Size = .default

    static let any_icon = Backpack_SwiftUI.BPKIcon.arrowRight
    @FigmaEnum(
        "Icon",
        mapping: [
            "Left": .init(icon: Self.any_icon, position: .leading),
            "None": nil,
            "Right": .init(icon: Self.any_icon, position: .trailing),
            "Icon only": .init(icon: Self.any_icon, position: .leading)
        ]
    )
    var icon: Backpack_SwiftUI.BPKButton.Icon? = .init(icon: .arrowRight, position: .leading)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(false),
            "Hover": .constant(false),
            "Pressed": .constant(false),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var loadingBinding: Binding<Bool> = .constant(false)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(true),
            "Hover": .constant(true),
            "Pressed": .constant(true),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var enabledBinding: Binding<Bool> = .constant(false)

    var body: some View {
        BPKButton(
            title,
            icon: icon,
            loading: loadingBinding,
            enabled: enabledBinding,
            size: size,
            action: {}
        )
        .buttonStyle(style)
    }
}

// MARK: - Icon = None
struct BpkButton_IconNone_CodeConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKButton.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-8677"
    let variant = ["Icon" : "None"]

    private var title: String = "Label"

    @FigmaEnum(
        "Style",
        mapping: [
            "Primary": .primary,
            "Secondary": .secondary,
            "Featured": .featured,
            "Primary on light": .primaryOnLight,
            "Primary on dark": .primaryOnDark,
            "Secondary on dark": .secondaryOnDark,
            "Destructive": .destructive,
            "Link": .link,
            "Link on dark": .linkOnDark
        ]
    )
    var style: Backpack_SwiftUI.BPKButton.Style = .primary

    @FigmaEnum("Size", mapping: ["Default": .default, "Large": .large])
    var size: Backpack_SwiftUI.BPKButton.Size = .default

    static let any_icon = Backpack_SwiftUI.BPKIcon.arrowRight
    @FigmaEnum(
        "Icon",
        mapping: [
            "Left": .init(icon: Self.any_icon, position: .leading),
            "None": nil,
            "Right": .init(icon: Self.any_icon, position: .trailing),
            "Icon only": .init(icon: Self.any_icon, position: .leading)
        ]
    )
    var icon: Backpack_SwiftUI.BPKButton.Icon? = .init(icon: .arrowRight, position: .leading)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(false),
            "Hover": .constant(false),
            "Pressed": .constant(false),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var loadingBinding: Binding<Bool> = .constant(false)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(true),
            "Hover": .constant(true),
            "Pressed": .constant(true),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var enabledBinding: Binding<Bool> = .constant(false)

    var body: some View {
        BPKButton(
            title,
            icon: icon,
            loading: loadingBinding,
            enabled: enabledBinding,
            size: size,
            action: {}
        )
        .buttonStyle(style)
    }
}

// MARK: - Icon = Icon only
struct BpkButton_IconOnly_CodeConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKButton.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-8677"
    let variant = ["Icon" : "Icon only"]

    private var title: String = "Label"
    static let any_icon: Backpack_SwiftUI.BPKIcon = .arrowRight

    @FigmaEnum(
        "Style",
        mapping: [
            "Primary": .primary,
            "Secondary": .secondary,
            "Featured": .featured,
            "Primary on light": .primaryOnLight,
            "Primary on dark": .primaryOnDark,
            "Secondary on dark": .secondaryOnDark,
            "Destructive": .destructive,
            "Link": .link,
            "Link on dark": .linkOnDark
        ]
    )
    var style: Backpack_SwiftUI.BPKButton.Style = .primary

    @FigmaEnum("Size", mapping: ["Default": .default, "Large": .large])
    var size: Backpack_SwiftUI.BPKButton.Size = .default

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(false),
            "Hover": .constant(false),
            "Pressed": .constant(false),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var loadingBinding: Binding<Bool> = .constant(false)

    @FigmaEnum(
        "State",
        mapping: [
            "Normal": .constant(true),
            "Hover": .constant(true),
            "Pressed": .constant(true),
            "Loading": .constant(true),
            "Disabled": .constant(false)
        ]
    )
    var enabledBinding: Binding<Bool> = .constant(false)

    var body: some View {
        BPKButton(
            icon: Self.any_icon,
            accessibilityLabel: title,
            loading: loadingBinding,
            enabled: enabledBinding,
            size: size,
            action: {}
        )
        .buttonStyle(style)
    }
}
