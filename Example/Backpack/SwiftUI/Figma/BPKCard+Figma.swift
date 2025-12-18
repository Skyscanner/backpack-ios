import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKCardFigmaConnect<Content: View>: FigmaConnect {
    let component = Backpack_SwiftUI.BPKCard<Content>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-49749"

    var body: some View {
        Backpack_SwiftUI.BPKCard(
            padding: .small,
            cardStyle: .onContrast,
            cornerStyle: .small,
            elevation: .default
        ) {
            BPKText("Card content", style: .bodyDefault)
        }
    }
}
