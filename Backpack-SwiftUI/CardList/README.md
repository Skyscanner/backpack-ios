# Section Header

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](hhttps://cocoapods.org/pods/Backpack-SwiftUI)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/swiftui/Structs/BPKCardList.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/CardList)

## Rail

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-5-elements_lm.png" alt="" width="375" /> |<img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-swiftui_card-list___rail-5-elements_dm.png" alt="" width="375" /> |

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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
        Text("Element \(element.id)")
    }
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
                }
    ),
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
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
    initiallyShownCards: 2,
    elements: Array(repeating: TestElement(id: 1), count: 4)) {
        Text("Element \(element.id)")
    }
```