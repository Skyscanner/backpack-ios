import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKHotelStarRatingFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKHotelStarRating.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10911-49171"

    @FigmaEnum(
        "Size",
        mapping: [
            "Small": .small,
            "Large": .large
        ]
    )
    var size: BPKStarRatingSize = .small

    var body: some View {
        Backpack_SwiftUI.BPKHotelStarRating(
            rating: .constant(4),
            size: size
        )
    }
}
