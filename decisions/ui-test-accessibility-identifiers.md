# UI test accessibility identifiers

## Decision
* **Standalone Components**: No accessibility identifiers for UI tests. Consumers can add them as needed.
* **Components in Larger UIs**:
  * **Hardcoded identifiers** if the component is used in a single place.
  * **Dynamic identifiers** if the component is reused in multiple places.

## Thinking

### Standalone components
Standalone components are components that are not part of a larger UI. They are typically used in isolation and are not composed of other components. Examples of standalone components are `BpkButton`, `BpkText`, `BpkIcon`, etc.

These components can receive accessibility identifiers from the consumer if they need to be tested in a UI test. This is because the consumer is the one that knows the context in which the component is being used.

**Example**

```swift
BPKButton("Search") {
    /* Tap code */
}
.accessibilityIdentifier("search_button")
```

### Components that are part of a larger UI
Components that are part of a larger UI are typically composed of other components. Examples of these components are `BpkAppSearchModal`, `BpkImageGalleryImageGrid`, `BpkNudger`, etc.

These components contain nested interactive elements and need to be exposed to UI tests. We need to add accessibility identifiers to these components to make them testable.
Based on how we expect the component to be used we can decide whether to add hardcoded or dynamic accessibility identifiers.

For components that likely take a single instance in a UI, we can add hardcoded accessibility identifiers. This is because the component is likely to be used in a single place and the identifier is not likely to change. 

**Example**
- Check out `AppSearchModal`

In other cases like `BpkNudger` where the component can be reused in multiple places, we can add dynamic accessibility identifiers. Dynamic identifiers are added to components using a specialised modifier for each identifier we want to add. This allows us to add multiple instances of the same component to a UI and have them be uniquely identifiable.

**Example**
- Check out `BpkNudger`