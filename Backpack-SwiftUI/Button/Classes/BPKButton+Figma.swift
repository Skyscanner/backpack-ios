import SwiftUI
// import Figma -> TODO: SPM Migration Required
import Backpack_Common

/// Figma Code Connect implementation for BPKButton
struct BPKButtonFigmaConnect: FigmaConnect {
    let component = BPKButton.self
    let figmaNodeUrl = "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0"
    
    /// Button text property
    @FigmaString("Text Content")
    var text: String = "Label"
    
    /// Button style property
    @FigmaEnum(
        "Style",
        mapping: [
            "Primary": BPKButton.Style.primary,
            "Secondary": BPKButton.Style.secondary,
            "Featured": BPKButton.Style.featured,
            "Destructive": BPKButton.Style.destructive,
            "Primary on Dark": BPKButton.Style.primaryOnDark,
            "Primary on Light": BPKButton.Style.primaryOnLight,
            "Secondary on Dark": BPKButton.Style.secondaryOnDark,
            "Link": BPKButton.Style.link,
            "Link on Dark": BPKButton.Style.linkOnDark
        ]
    )
    var style: BPKButton.Style = .primary
    
    /// Button size property
    @FigmaEnum(
        "Size",
        mapping: [
            "Default": BPKButton.Size.default,
            "Large": BPKButton.Size.large
        ]
    )
    var size: BPKButton.Size = .default
    
    /// Button enabled state
    @FigmaEnum(
        "State",
        mapping: [
            "Normal": true,
            "Disabled": false,
            "Loading": true,
            "Pressed": true,
            "Focused": true,
            "Hover": true
        ]
    )
    var enabled: Bool = true
    
    /// Button loading state
    @FigmaEnum(
        "State",
        mapping: [
            "Normal": false,
            "Disabled": false,
            "Loading": true,
            "Pressed": false,
            "Focused": false,
            "Hover": false
        ]
    )
    var loading: Bool = false
    
    /// Icon variant property
    @FigmaVariant("Icon")
    var iconVariant: String = "None"
    
    var body: some View {
        Group {
            switch iconVariant {
            case "None":
                BPKButton(
                    text,
                    loading: .constant(loading),
                    enabled: .constant(enabled),
                    size: size
                ) { }
                .buttonStyle(style)
                
            case "Left":
                BPKButton(
                    text,
                    icon: .leading(icon: .longArrowRight),
                    loading: .constant(loading),
                    enabled: .constant(enabled),
                    size: size
                ) { }
                .buttonStyle(style)
                
            case "Right":
                BPKButton(
                    text,
                    icon: .trailing(icon: .longArrowRight),
                    loading: .constant(loading),
                    enabled: .constant(enabled),
                    size: size
                ) { }
                .buttonStyle(style)
                
            case "Icon only":
                BPKButton(
                    icon: .longArrowRight,
                    accessibilityLabel: text,
                    loading: .constant(loading),
                    enabled: .constant(enabled),
                    size: size
                ) { }
                .buttonStyle(style)
                
            default:
                BPKButton(
                    text,
                    loading: .constant(loading),
                    enabled: .constant(enabled),
                    size: size
                ) { }
                .buttonStyle(style)
            }
        }
    }
}

// Separate FigmaConnect implementations for each icon variant to match the Compose pattern

/// Figma Code Connect implementation for BPKButton without icon
@FigmaConnect(url: "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0")
@FigmaVariant(key: "Icon", value: "None")
struct BPKButtonNoIconFigmaConnect {
    
    @FigmaProperty(FigmaType.Enum, "Style")
    let style: BPKButton.Style = Figma.mapping(
        "Primary": BPKButton.Style.primary,
        "Secondary": BPKButton.Style.secondary,
        "Featured": BPKButton.Style.featured,
        "Destructive": BPKButton.Style.destructive,
        "Primary on Dark": BPKButton.Style.primaryOnDark,
        "Primary on Light": BPKButton.Style.primaryOnLight,
        "Secondary on Dark": BPKButton.Style.secondaryOnDark,
        "Link": BPKButton.Style.link,
        "Link on Dark": BPKButton.Style.linkOnDark
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let enabled: Bool = Figma.mapping(
        "Normal": true,
        "Disabled": false,
        "Loading": true,
        "Pressed": true,
        "Focused": true,
        "Hover": true
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let loading: Bool = Figma.mapping(
        "Normal": false,
        "Disabled": false,
        "Loading": true,
        "Pressed": false,
        "Focused": false,
        "Hover": false
    )
    
    @FigmaProperty(FigmaType.Enum, "Size")
    let size: BPKButton.Size = Figma.mapping(
        "Default": BPKButton.Size.default,
        "Large": BPKButton.Size.large
    )
    
    @Composable
    func ButtonExample() {
        BPKButton(
            "Label",
            loading: .constant(loading),
            enabled: .constant(enabled),
            size: size
        ) { }
        .buttonStyle(style)
    }
}

/// Figma Code Connect implementation for BPKButton with left icon
@FigmaConnect(url: "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0")
@FigmaVariant(key: "Icon", value: "Left")
struct BPKButtonLeftIconFigmaConnect {
    
    @FigmaProperty(FigmaType.Enum, "Style")
    let style: BPKButton.Style = Figma.mapping(
        "Primary": BPKButton.Style.primary,
        "Secondary": BPKButton.Style.secondary,
        "Featured": BPKButton.Style.featured,
        "Destructive": BPKButton.Style.destructive,
        "Primary on Dark": BPKButton.Style.primaryOnDark,
        "Primary on Light": BPKButton.Style.primaryOnLight,
        "Secondary on Dark": BPKButton.Style.secondaryOnDark,
        "Link": BPKButton.Style.link,
        "Link on Dark": BPKButton.Style.linkOnDark
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let enabled: Bool = Figma.mapping(
        "Normal": true,
        "Disabled": false,
        "Loading": true,
        "Pressed": true,
        "Focused": true,
        "Hover": true
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let loading: Bool = Figma.mapping(
        "Normal": false,
        "Disabled": false,
        "Loading": true,
        "Pressed": false,
        "Focused": false,
        "Hover": false
    )
    
    @FigmaProperty(FigmaType.Enum, "Size")
    let size: BPKButton.Size = Figma.mapping(
        "Default": BPKButton.Size.default,
        "Large": BPKButton.Size.large
    )
    
    @Composable
    func ButtonExample() {
        BPKButton(
            "Label",
            icon: .leading(icon: .longArrowRight),
            loading: .constant(loading),
            enabled: .constant(enabled),
            size: size
        ) { }
        .buttonStyle(style)
    }
}

/// Figma Code Connect implementation for BPKButton with right icon
@FigmaConnect(url: "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0")
@FigmaVariant(key: "Icon", value: "Right")
struct BPKButtonRightIconFigmaConnect {
    
    @FigmaProperty(FigmaType.Enum, "Style")
    let style: BPKButton.Style = Figma.mapping(
        "Primary": BPKButton.Style.primary,
        "Secondary": BPKButton.Style.secondary,
        "Featured": BPKButton.Style.featured,
        "Destructive": BPKButton.Style.destructive,
        "Primary on Dark": BPKButton.Style.primaryOnDark,
        "Primary on Light": BPKButton.Style.primaryOnLight,
        "Secondary on Dark": BPKButton.Style.secondaryOnDark,
        "Link": BPKButton.Style.link,
        "Link on Dark": BPKButton.Style.linkOnDark
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let enabled: Bool = Figma.mapping(
        "Normal": true,
        "Disabled": false,
        "Loading": true,
        "Pressed": true,
        "Focused": true,
        "Hover": true
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let loading: Bool = Figma.mapping(
        "Normal": false,
        "Disabled": false,
        "Loading": true,
        "Pressed": false,
        "Focused": false,
        "Hover": false
    )
    
    @FigmaProperty(FigmaType.Enum, "Size")
    let size: BPKButton.Size = Figma.mapping(
        "Default": BPKButton.Size.default,
        "Large": BPKButton.Size.large
    )
    
    @Composable
    func ButtonExample() {
        BPKButton(
            "Label",
            icon: .trailing(icon: .longArrowRight),
            loading: .constant(loading),
            enabled: .constant(enabled),
            size: size
        ) { }
        .buttonStyle(style)
    }
}

/// Figma Code Connect implementation for BPKButton with icon only
@FigmaConnect(url: "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0")
@FigmaVariant(key: "Icon", value: "Icon only")
struct BPKButtonIconOnlyFigmaConnect {
    
    @FigmaProperty(FigmaType.Enum, "Style")
    let style: BPKButton.Style = Figma.mapping(
        "Primary": BPKButton.Style.primary,
        "Secondary": BPKButton.Style.secondary,
        "Featured": BPKButton.Style.featured,
        "Destructive": BPKButton.Style.destructive,
        "Primary on Dark": BPKButton.Style.primaryOnDark,
        "Primary on Light": BPKButton.Style.primaryOnLight,
        "Secondary on Dark": BPKButton.Style.secondaryOnDark,
        "Link": BPKButton.Style.link,
        "Link on Dark": BPKButton.Style.linkOnDark
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let enabled: Bool = Figma.mapping(
        "Normal": true,
        "Disabled": false,
        "Loading": true,
        "Pressed": true,
        "Focused": true,
        "Hover": true
    )
    
    @FigmaProperty(FigmaType.Enum, "State")
    let loading: Bool = Figma.mapping(
        "Normal": false,
        "Disabled": false,
        "Loading": true,
        "Pressed": false,
        "Focused": false,
        "Hover": false
    )
    
    @FigmaProperty(FigmaType.Enum, "Size")
    let size: BPKButton.Size = Figma.mapping(
        "Default": BPKButton.Size.default,
        "Large": BPKButton.Size.large
    )
    
    @Composable
    func ButtonExample() {
        BPKButton(
            icon: .longArrowRight,
            accessibilityLabel: "Label",
            loading: .constant(loading),
            enabled: .constant(enabled),
            size: size
        ) { }
        .buttonStyle(style)
    }
}