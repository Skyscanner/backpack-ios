import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKStarRatingFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKStarRating.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10911-49221"

    @FigmaEnum(
        "Size",
        mapping: [
            "Small": .small,
            "Large": .large
        ]
    )
    var size: BPKStarRatingSize = .small

    var body: some View {
        Backpack_SwiftUI.BPKStarRating(
            rating: .constant(3.5),
            maxRating: 5,
            size: size,
            rounding: .down
        )
    }
}
