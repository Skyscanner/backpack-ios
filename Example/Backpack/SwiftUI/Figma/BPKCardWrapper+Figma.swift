import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKCardWrapperFigmaConnect<HeaderContent: View, WrappedContent: CardWrappable>: FigmaConnect {
    let component = Backpack_SwiftUI.BPKCardWrapper<HeaderContent, WrappedContent>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-49736"

    var body: some View {
        Backpack_SwiftUI.BPKCardWrapper(
            backgroundColor: .coreAccentColor,
            header: {
                HStack {
                    BPKIconView(.flag)
                    BPKText("Header", style: .caption)
                        .foregroundColor(.textOnDarkColor)
                    Spacer()
                }
                .padding(.md)
            },
            card: {
                Backpack_SwiftUI.BPKCard(elevation: .none) {
                    BPKText("Card content", style: .bodyDefault)
                }
            }
        )
    }
}
