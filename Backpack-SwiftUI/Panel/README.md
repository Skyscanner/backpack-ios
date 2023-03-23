#  Backpack-SwiftUI/Panel

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKPanel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Panel)

## Default
| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_panel___default_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_panel___default_dm.png" alt="" width="375" /> |

## Usage

```swift
import SwiftUI
import Backpack_SwiftUI

struct PanelExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: BPKSpacing.md.value) {
            BPKText("Default", style: .heading4)
            BPKPanel() {
                exampleContent
            }
            
            BPKText("No padding", style: .heading4)
            BPKPanel(padding: false) {
                exampleContent
            }
            Spacer()
        }
        .padding(.base)
    }
    
    private var exampleContent: some View {
        VStack {
            BPKText("Content")
                .foregroundColor(.textOnLightColor)
        }
        .frame(maxWidth: .greatestFiniteMagnitude)
        .padding()
        .background(.statusWarningFillColor)
    }
}
```