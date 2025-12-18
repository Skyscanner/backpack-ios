import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKChipFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKChip.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?node-id=10858-56092"

    @FigmaEnum(
        "Style",
        mapping: [
            "Default": .default,
            "On dark": .onDark,
            "On image": .onImage
        ]
    )
    var style: Backpack_SwiftUI.BPKChipStyle = .default

    var body: some View {
        Backpack_SwiftUI.BPKChip(
            "Chip",
            icon: .accessibility,
            selected: false,
            style: style,
            onClick: {}
        )
    }
}
