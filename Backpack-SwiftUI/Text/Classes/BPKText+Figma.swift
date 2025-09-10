import SwiftUI
// import Figma -> TODO: SPM Migration Required
import Backpack_Common

/// Figma Code Connect implementation for BPKText
struct BPKTextFigmaConnect: FigmaConnect {
    let component = BPKText.self
    let figmaNodeUrl = "https://www.figma.com/design/irZ3YBx8vOm16ICkAr7mB3/Backpack-Components?node-id=2965-0"

    /// Text content property
    @FigmaString("Text Content")
    var text: String = "Hello World"
    
    /// Text style property
    @FigmaEnum(
        "Style",
        mapping: [
            "Heading 1": BPKFontStyle.heading1,
            "Heading 2": BPKFontStyle.heading2,
            "Heading 3": BPKFontStyle.heading3,
            "Heading 4": BPKFontStyle.heading4,
            "Heading 5": BPKFontStyle.heading5,
            "Body Longform": BPKFontStyle.bodyLongform,
            "Body Default": BPKFontStyle.bodyDefault,
            "Label 1": BPKFontStyle.label1,
            "Label 2": BPKFontStyle.label2,
            "Footnote": BPKFontStyle.footnote,
            "Caption": BPKFontStyle.caption
        ]
    )
    var style: BPKFontStyle = .bodyDefault
    
    /// Text color property
    @FigmaEnum(
        "Color",
        mapping: [
            "Primary": BPKColor.textPrimaryColor,
            "Secondary": BPKColor.textSecondaryColor,
            "Disabled": BPKColor.textDisabledColor,
            "Primary Inverse": BPKColor.textPrimaryInverseColor,
            "Error": BPKColor.textErrorColor,
            "Link": BPKColor.textLinkColor
        ],
        hideDefault: true
    )
    var color: BPKColor? = nil
    
    /// Line limit property
    @FigmaEnum(
        "Line Limit",
        mapping: [
            "Single Line": 1,
            "Two Lines": 2,
            "Three Lines": 3,
            "Unlimited": nil
        ],
        hideDefault: true
    )
    var lineLimit: Int? = 1
    
    /// Strikethrough property
    @FigmaBoolean("Strikethrough", hideDefault: true)
    var strikethrough: Bool = false
    
    var body: some View {
        BPKText(text, style: style)
            .figmaApply(color != nil) {
                $0.foregroundColor(color!)
            }
            .figmaApply(lineLimit != 1) {
                $0.lineLimit(lineLimit)
            }
            .figmaApply(strikethrough) {
                $0.strikethrough(true)
            }
    }
}

// MARK: - Xcode Preview
#Preview("BPKText Figma Connect") {
    VStack(spacing: 16) {
        BPKTextFigmaConnect()
        
        BPKTextFigmaConnect()
            .foregroundColor(.corePrimaryColor)
        
        BPKTextFigmaConnect()
            .lineLimit(nil)
        
        BPKTextFigmaConnect()
            .strikethrough(true)
    }
    .padding()
}
