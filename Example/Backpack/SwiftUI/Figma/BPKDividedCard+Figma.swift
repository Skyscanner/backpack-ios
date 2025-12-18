import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKDividedCardFigmaConnect<PrimaryContent: View, SecondaryContent: View>: FigmaConnect {
    let component = Backpack_SwiftUI.BPKDividedCard<PrimaryContent, SecondaryContent>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-49338"

    var body: some View {
        Backpack_SwiftUI.BPKDividedCard(
            alignment: .center,
            cardStyle: .onContrast,
            elevation: .default,
            primaryContent: {
                BPKText("Primary content", style: .heading3)
                    .padding()
            },
            secondaryContent: {
                BPKText("Secondary content", style: .bodyDefault)
                    .padding()
            }
        )
    }
}
