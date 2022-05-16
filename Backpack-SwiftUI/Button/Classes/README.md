# Backpack / Button

## Usage

### SwiftUI

```swift
import Backpack_SwiftUI

/// Regular button that defaults to size `small` and style `.primary`
BPKButton("Tap Me!") {
    message = "Button Tapped!"
}

/// Set size
BPKButton("Tap Me!", size: .large) {
    message = "Button Tapped!"
}

/// Add an icon
BPKButton("Tap Me!", icon: BPKButton.Icon(icon: .account, position: .leading)) {
    message = "Button Tapped!"
}

/// Or shorter
BPKButton("Tap Me!", icon: .leading(icon: .account)) {
    message = "Button Tapped!"
}

// Have Icon Only
BPKButton(icon: .account, accessibilityLabel: "Account") {
    message = "Button Tapped!"
}

// Control loading and enabled state with Binding
@State var paymentInProgress = false
@State var isFormValid = false

BPKButton("Pay!", loading: $paymentInProgress, enabled: $isFormValid) {
    paymentProcessor.processPayment()
}

```
