# Backpack-SwiftUI/Link

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack-SwiftUI.svg?style=flat)](https://cocoapods.org/pods/Backpack-SwiftUI)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack-SwiftUI/Link)

## Overview

BPKLink renders inline rich text that contains one or more links while preserving the reading flow of the surrounding content. It mirrors the guidance from the Skyscanner Backpack design system: links should feel lightweight, stay within the sentence they belong to, and clearly communicate where they will take the traveller.

## Key capabilities

- Accepts Markdown strings so you can author copy using familiar `[link](url)` syntax.
- Automatically applies Backpack typography and link styling, with variants for light (`.default`) and dark (`.onContrast`) backgrounds.
- Routes `http`/`https` URLs through the system handler and exposes a closure for custom schemes.
- Supports custom `BPKFontStyle` values to match the hierarchy of your layout.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `markdown` | `String` | – | Text containing markdown links to be rendered. |
| `style` | `BPKLinkStyle` | `.default` | Visual style for light (`.default`) or dark (`.onContrast`) backgrounds. |
| `fontStyle` | `BPKFontStyle` | `.bodyDefault` | Typography token applied to the rendered text. |
| `onCustomLink` | `(URL) -> Void` | `{ _ in }` | Closure invoked when the tapped link uses a non-http(s) scheme. |

## Usage

### Basic inline link

```swift
import Backpack_SwiftUI

BPKLink(
    markdown: "By continuing you agree to the [Terms of Use](https://www.example.com/terms)."
)
```

### Links on contrast backgrounds

```swift
import Backpack_SwiftUI

BPKLink(
    markdown: "See all [travel updates](https://www.example.com/updates).",
    style: .onContrast
)
.background(Color(BPKColor.surfaceContrastColor))
```

### Handling custom URL schemes

```swift
import Backpack_SwiftUI
import Backpack_Common

BPKLink(
    markdown: "Read the [terms](app://terms) and [privacy policy](app://privacy).",
    style: .onContrast
) { url in
    switch url.host ?? url.path {
    case "terms", "/terms":
        presentTermsSheet()
    case "privacy", "/privacy":
        presentPrivacySheet()
    default:
        break
    }
}
.background(Color(BPKColor.surfaceContrastColor))
```

### Presenting in-app actions

```swift
import Backpack_SwiftUI

struct ContentView: View {
    @State private var showBottomSheet = false

    var body: some View {
        BPKLink(
            markdown: "Check your [boarding pass](app://boarding-pass)."
        ) { url in
            if url.host == "boarding-pass" {
                showBottomSheet = true
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            BoardingPassSheet()
        }
    }
}
```

### Custom typography

```swift
import Backpack_SwiftUI

BPKLink(
    markdown: "Find out more about [routes](https://www.example.com/routes).",
    fontStyle: .bodyDefaultEmphasized
)
```

## Behaviour

- Links with the `http` or `https` scheme defer to the system via `OpenURLAction`. This keeps universal links, SafariViewController, and default browser behaviour intact.
- Any other scheme is passed to the `onCustomLink` closure so you can trigger in-app navigation or feature-specific flows.
- The component keeps underline styling and colour fidelity provided by Backpack tokens, ensuring consistent affordances across light and dark surfaces.


## Accessibility

- `BPKLink` exposes accessibility traits for links and provides system-standard focus and activation behaviour.
- The underline and colour pairings meet Backpack contrast requirements for both styles.
- Text respects Dynamic Type because typography is driven by Backpack font styles.
- Provide meaningful link text instead of raw URLs so assistive technologies can describe the action clearly.
