import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKMultiSelectChipGroupFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKMultiSelectChipGroup.self
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
        Backpack_SwiftUI.BPKMultiSelectChipGroup(
            chips: [
                .init(text: "Shenzhen", selected: false, onClick: {}),
                .init(text: "London", selected: false, onClick: {}),
                .init(text: "Edinburgh", selected: true, onClick: {}),
                .init(text: "Manchester", selected: false, onClick: {})
            ],
            style: style,
            type: .rail(stickyChip: nil)
        )
    }
}
