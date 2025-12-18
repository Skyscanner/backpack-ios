import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKRatingFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKRating<BPKText>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10911-25511"

    @FigmaEnum(
        "Size",
        mapping: [
            "Default": .default,
            "Large": .large
        ]
    )
    var size: Backpack_SwiftUI.BPKRating<BPKText>.Size = .default

    var body: some View {
        Backpack_SwiftUI.BPKRating(
            title: "Excellent",
            value: 4.5,
            ratingScale: .zeroToFive,
            size: size,
            subtitle: "1,532 reviews",
            showScale: true
        )
    }
}
