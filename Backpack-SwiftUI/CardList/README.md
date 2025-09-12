# Card List

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKCardList.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/CardList)

## Rail

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-3-elements_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-3-elements_dm.png" alt="" width="375" /> |

### Single item rail

When the rail layout receives only one element it expands to fill the full available width instead of rendering a horizontally scrollable container. This mirrors the expected design parity and provides a better visual balance for solitary content.

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-1-element_lm.png" alt="Single rail element light" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-1-element_dm.png" alt="Single rail element dark" width="375" /> |

Usage example:

```swift
BPKCardList(
    title: "Recommended",
    description: nil,
    layout: .rail(), // single element => full width
    elements: [Model(id: 1)]
) { element in
    MyCardView(model: element)
}
```

## Rail with section header button

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-12-elements-with-section-header-button_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-12-elements-with-section-header-button_dm.png" alt="" width="375" /> |

## Stack

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-3-to-12-elements_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-3-to-12-elements_dm.png" alt="" width="375" /> |

## Stack with expand accessory

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-expand_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-expand_dm.png" alt="" width="375" /> |

## Stack with button accessory

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-button_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-button_dm.png" alt="" width="375" /> |

## Stack with expand accessory and section header button

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-expand-with-section-header-button_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___stack-accessory-expand-with-section-header-button_dm.png" alt="" width="375" /> |



## Usage

To create a Card List component, you need to choose if you want a rail (horizontal) layout or a stack (vertical) layout.

### Header Padding (optional)

You can control the padding around the section header using the `headerPadding:` parameter. This accepts an `Edge.Set` and `BPKSpacing` value.

```swift
headerPadding: ([.leading, .trailing, .bottom], .base)
```

If no value is provided, it defaults to `(.all, .base)`.

### Controlling the expanded state (optional)

For a `.stack` layout, you can control its expanded state by providing a `Binding<Bool>` to the `showingAllCards` parameter. This is useful when you want to control the expansion from a parent view.

The parameter is ignored for `.rail` layouts.

### Rail layout

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .rail(),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
) { element in
    Text("Element \(element.id)")
}

#### Fixed card width (optional)

You can constrain each card in a rail to a fixed width by supplying `cardWidth:`:

```swift
BPKCardList(
    title: "Section title",
    description: nil,
    layout: .rail(cardWidth: 240),
    elements: models
) { element in
    ProductCard(model: element)
}
```

If `cardWidth` is omitted the card sizes are determined by their intrinsic content. The single-item full-width behaviour still applies regardless of `cardWidth` (the width is ignored in the 1‑item case so the card stretches).
```

#### Section header

You can also specify a button with an icon for the section header.

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .rail(
        sectionHeaderAction: .init(
            icon: .addCircle,
            accessibilityLabel: "Add item") {
                print("Tap add button")
            },
        cardWidth: 240
    ),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
) { element in
    Text("Element \(element.id)")
}
```

### Stack layout

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .stack(),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
    ) {
        Text("Element \(element.id)")
    }
```


#### Accessory (optional)

Using stack layout, you can optionally choose to show an accesory option. There are currently 3 options to choose from:

** Section Header Button **

Button with an icon for the section header

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
        layout: .stack(
        accessory: .sectionHeaderButton(
            .init(
                icon: .addCircle,
                accessibilityLabel: "Add item") {
                    print("Tap add button")
            }
        )
    ),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
    ) {
        Text("Element \(element.id)")
    }
```

** Expand **

Option with a button on the bottom to toggle between showing `initiallyShownCards` number of elements and the total number of elements.
Text for both states of the button are required, and a section header button can be provided optionally.

##### Without Section Header Button

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .stack(
        accessory: .expand(expandText: "Show more", collapseText: "Show less"),
    ),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
    ) {
        Text("Element \(element.id)")
    }
```

##### With Section Header Button

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .stack(
        accessory: .expand(
            expandText: "Show more",
            collapseText: "Show less",
            sectionHeaderButton:
                .init(
                    icon: .addCircle,
                    accessibilityLabel: "Add item") {
                        print("Tap add button")
                    }
        )
    ),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
    ) {
        Text("Element \(element.id)")
    }
```

** Footer Button **

Configurable button to be shown at the bottom

```swift
import Backpack_SwiftUI

struct TestElement: Identifiable {
    let id: Int
}

BPKCardList(
    title: "Section title",
    description: "Description about this section (optional)",
    layout: .stack(
        accessory: .footerButton(
            .init(
                title: "Add item",
                icon: .init(icon: .addCircle, position: .trailing),
                accessibilityLabel: "Add item") {
                    print("Tap add button")
            }
        )
    ),
    initiallyShownCardsCount: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4),
    headerPadding: ([.leading, .trailing, .bottom], .base)
    ) {
        Text("Element \(element.id)")
    }
```
