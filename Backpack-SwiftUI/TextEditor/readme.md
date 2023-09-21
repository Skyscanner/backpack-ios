# Backpack-SwiftUI/Nudger

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKNudger.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Nudger)

## Default

| Day                                                                                                                                                        | Night                                                                                                                                                      |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| https://raw.githubusercontent.com/Skyscanner/backpack-ios/bae8133c95fc52e7b4662dc77134019746230c51/screenshots/iPhone-swiftui_text-editor___default_lm.png | https://raw.githubusercontent.com/Skyscanner/backpack-ios/bae8133c95fc52e7b4662dc77134019746230c51/screenshots/iPhone-swiftui_text-editor___default_dm.png |

# Usage

an adjustable control that allows a user to select a numerical value between a min/max determined by the consumer.

```swift
struct BPKTextEditorExampleView: View {
    @State private var text: String = ""

    var body: some View {
        VStack(spacing: 20) {
            BPKTextEditor($text, placeholder: "Enter your text", charLimit: 100)
                .frame(height: 200)
                .padding()

            Text("Entered text: \(text)")
                .font(.body)
                .foregroundColor(.black)
                .padding()
        }
        .background(Color.white)
        .padding()
    }
}
```
