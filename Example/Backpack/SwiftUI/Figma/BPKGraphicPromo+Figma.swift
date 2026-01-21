import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKGraphicPromoFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKGraphicPromo.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10872-2409"

    var body: some View {
        Backpack_SwiftUI.BPKGraphicPromo(
            kicker: "Travel tips",
            headline: "Three peaks challenge",
            subheadline: "How to complete the trip in three days",
            image: Image(systemName: "photo"),
            type: .button,
            layoutType: .mobile,
            overlay: .solid(.off),
            variant: .onDark,
            verticalAlignment: .top
        )
        .fallbackColor(Color(.coreAccentColor))
    }
}
