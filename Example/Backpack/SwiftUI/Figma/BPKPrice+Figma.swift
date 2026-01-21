import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKPriceFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKPrice.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10911-19302"

    @FigmaString("Price")
    var price: String = "£1,830"

    @FigmaString("Leading text")
    var leadingText: String = "App only deal"

    @FigmaString("Previous price")
    var previousPrice: String = "£2,030"

    @FigmaString("Trailing text")
    var trailingText: String = "per person"

    @FigmaEnum(
        "Size",
        mapping: [
            "Large": .large,
            "Small": .small,
            "Extra small": .extraSmall
        ]
    )
    var size: Backpack_SwiftUI.BPKPrice.Size = .large

    @FigmaEnum(
        "Alignment",
        mapping: [
            "Leading": .leading,
            "Trailing": .trailing,
            "Row": .row
        ]
    )
    var alignment: Backpack_SwiftUI.BPKPrice.Alignment = .leading

    var body: some View {
        Backpack_SwiftUI.BPKPrice(
            price: price,
            leadingText: leadingText,
            previousPrice: previousPrice,
            trailingText: trailingText,
            icon: nil,
            alignment: alignment,
            size: size
        )
    }
}
