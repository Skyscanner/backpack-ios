# Backpack-SwiftUI/BPKTextArea

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKTextArea.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/TextArea)

## Default

| Day                                                                                                                                                   | Night                                                                                                                                                 |
| ----------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_text-area___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_text-area___default_dm.png" alt="" width="375" /> |

# Usage

A text editor that allows users to enter multiple lines of text.

```swift
struct BPKTextAreaExampleView: View {
    @State private var text: String = ""

    var body: some View {
        VStack(spacing: 20) {
            BPKTextArea($text, placeholder: "Enter your text", charLimit: 100)
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

### Changing the State
    
```swift
  BPKTextArea(text: $text)
    .inputState(.error)
```
