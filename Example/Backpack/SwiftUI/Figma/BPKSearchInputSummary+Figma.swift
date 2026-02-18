import SwiftUI
import Figma
import Backpack_SwiftUI

struct BPKSearchInputSummaryFigmaConnect: FigmaConnect {
    let component = Backpack_SwiftUI.BPKSearchInputSummary.self
    let figmaNodeUrl = "https://www.figma.com/design/KXf2gHNLDe2cXWUoHl4cTX/Backpack%E2%80%A8Foundations---Components?m=auto&node-id=10911-27935&t=5Hnxfi4qZQ1ZKPYw-1"

    @FigmaEnum(
        "Prefix",
        mapping: [
            "Icon": BPKSearchInputSummary.InputPrefix.icon(.search),
            "Label": BPKSearchInputSummary.InputPrefix.text("Label"),
            "None": nil
        ]
    )
    var inputPrefix: BPKSearchInputSummary.InputPrefix? = .icon(.search)

    @FigmaEnum(
        "State",
        mapping: [
            "Placeholder": Binding<String>.constant(""),
            "Entered": Binding<String>.constant("Barcelona"),
            "Focused": Binding<String>.constant("Barcelona")
        ]
    )
    var textBinding: Binding<String> = .constant("")

    @FigmaEnum(
        "State",
        mapping: [
            "Placeholder": BPKSearchInputSummary.Style.default,
            "Entered": BPKSearchInputSummary.Style.default,
            "Focused": BPKSearchInputSummary.Style.focused
        ]
    )
    var style: BPKSearchInputSummary.Style = .default

    @FigmaBoolean("Clear?", defaultValue: true)
    var showClear: Bool = true

    var body: some View {
        BPKSearchInputSummary(
            placeholder: "Country, city or airport",
            inputPrefix: inputPrefix,
            clearAction: .init(accessibilityLabel: "Clear", action: {}),
            textBinding
        )
        .customStyle(style)
    }
}
