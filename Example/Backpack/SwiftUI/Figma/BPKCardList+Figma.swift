import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKCardListFigmaConnect<Element: Identifiable, Content: View>: FigmaConnect {
    let component = Backpack_SwiftUI.BPKCardList<Element, Content>.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-37205"

    struct SampleElement: Identifiable {
        let id = UUID()
        let title: String
    }

    var body: some View {
        Backpack_SwiftUI.BPKCardList(
            title: "Card List Title",
            description: "Description of the card list",
            layout: .stack(accessory: nil),
            elements: [
                SampleElement(title: "Card 1"),
                SampleElement(title: "Card 2"),
                SampleElement(title: "Card 3")
            ]
        ) { element in
            Backpack_SwiftUI.BPKCard {
                BPKText(element.title, style: .bodyDefault)
            }
        }
    }
}
