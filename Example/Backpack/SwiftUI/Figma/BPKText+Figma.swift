import SwiftUI
import Figma
import Backpack_SwiftUI

/// Figma Code Connect implementation for BPKText
struct BPKTextFigmaConnect: FigmaConnect {
    let component = BPKText.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10911-51565"

    /// Text content property
    @FigmaString("Text Prop")
    var text: String = "Hello World"

    /// Text style property
    @FigmaEnum(
        "Style",
        mapping: [
            "Base Larken": BPKFontStyle.baseLarken,
            "Body Default": BPKFontStyle.bodyDefault,
            "Body Longform": BPKFontStyle.bodyLongform,
            "Caption": BPKFontStyle.caption,
            "Footnote": BPKFontStyle.footnote,
            "Heading 1": BPKFontStyle.heading1,
            "Heading 2": BPKFontStyle.heading2,
            "Heading 3": BPKFontStyle.heading3,
            "Heading 4": BPKFontStyle.heading4,
            "Heading 5": BPKFontStyle.heading5,
            "Hero 1": BPKFontStyle.hero1,
            "Hero 2": BPKFontStyle.hero2,
            "Hero 3": BPKFontStyle.hero3,
            "Hero 4": BPKFontStyle.hero4,
            "Hero 5": BPKFontStyle.hero5,
            "Label 1": BPKFontStyle.label1,
            "Label 2": BPKFontStyle.label2,
            "Label 3": BPKFontStyle.label3,
            "SM Larken": BPKFontStyle.smLarken,
            "Subheading": BPKFontStyle.subheading,
            "XS Larken": BPKFontStyle.xsLarken
        ]
    )
    var style: Backpack_SwiftUI.BPKFontStyle = .bodyDefault
    
    var body: some View {
        BPKText(text, style: style)
    }
}
