import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKSegmentedControlFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKSegmentedControl.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?m=auto&node-id=10911-36313&t=jgEnRqFMmoR4dtlN-1"

    @FigmaEnum(
        "Style",
        mapping: [
            "Surface Contrast": .defaultStyle,
            "Default": .defaultStyle
        ]
    )
    var style: Backpack_SwiftUI.BPKSegmentedControl.Style = .defaultStyle

    @FigmaEnum(
        "Choices",
        mapping: [
            "Two": ["Item 1", "Item 2"],
            "Three": ["Item 1", "Item 2", "Item 3"],
            "Four": ["Item 1", "Item 2", "Item 3", "Item 4"]
        ]
    )
    var items: [String] = ["Item 1", "Item 2", "Item 3"]

    @FigmaEnum(
        "Selected",
        mapping: [
            "1": .constant(0),
            "2": .constant(1),
            "3": .constant(2),
            "4": .constant(3)
        ]
    )
    var selectedIndex: Binding<Int> = .constant(0)

    var body: some View {
        BPKSegmentedControl(
            items: items,
            selectedIndex: selectedIndex,
            accessibilityLabel: "Segmented Control",
            style: style
        )
    }
}
