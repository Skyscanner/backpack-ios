# UI test accessibility identifiers

## Decision
* **Standalone Components**: No accessibility identifiers for UI tests. Consumers can add them as needed.
* **Interactive components in Larger UIs**:
  * **Hardcoded identifiers** if the component is used in a single place.
  * **Dynamic identifiers** if the component is reused in multiple places.

## Thinking

### Standalone components
Standalone components are components that are not part of a larger UI. 
They are typically used in isolation and are not composed of other components. 
Examples of standalone components are `BpkButton`, `BpkText`, `BpkIcon`, etc.

These components can receive accessibility identifiers from the consumer if they need to be tested in a UI test. 
This is because the consumer is the one that knows the context in which the component is being used.

**Example**

```swift
BPKButton("Search") {
    /* Tap code */
}
.accessibilityIdentifier("search_button")
```

### Interactive components that are part of a larger UI
These components contain nested interactive elements and need to be exposed to UI tests. 
We need to add accessibility identifiers to these elements inside the component to make them testable.
Based on how we expect the component to be used we can decide whether to 
add hardcoded or dynamic accessibility identifiers to the interactive elements.

Examples of these components are `BpkAppSearchModal`, `BpkImageGalleryImageGrid`, `BpkNudger`, etc.

For components are likely to be used only once per screen like `AppSearchModal`, 
we can add hardcoded accessibility identifiers. When a component is used only once, 
we don't run the risk of duplicate identifiers on the screen.

In other cases like `BpkNudger` where the component can be reused in multiple places, 
we add dynamic accessibility identifiers. Dynamic identifiers are added to components 
using a specialised modifier for each identifier we want to add. 
This allows us to add multiple instances of the same component to a UI and have them be uniquely identifiable.

**Example**
- [Static identifiers in AppSearchModal](../Backpack-SwiftUI/AppSearchModal)
- [Dynamic identifiers in BpkNudger](../Backpack-SwiftUI/Nudger)
