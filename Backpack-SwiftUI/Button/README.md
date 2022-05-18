# Button

## Usage

### Basic button with a title and action closure. 
If you don't specify a `.buttonStyle(<type>)` it will use the `.primary` type

```swift
BPKButton("Button title") {
    print("Button tap closure")
}
```

### Styled `.secondary` Button.

```swift 
BPKButton("Button title") {
    print("Button tap closure")
}
.buttonStyle(.secondary)
```

### Button with a title and icon. 

Set the icon to:
* `.leading(icon: <BPKIcon>)` 
* `.trailing(icon: <BPKICon>)`

```swift
BPKButton(
    "Button title",
    icon: .leading(icon: .longArrowRight)
) {
    print("Button tap closure")
}

BPKButton(
    "Button title",
    icon: .trailing(icon: .longArrowRight)
) {
    print("Button tap closure")
}
```

### Button with `loading` state. 

Pass in a `@State` variable or use `.constant(true)` 

```swift
BPKButton(
    "Button title",
    loading: $isLoading
) {
    print("Button tap closure")
}
```

### Button with `disabled` state. 

Pass in a `@State` variable or use `.constant(true)` 

```swift
BPKButton(
    "Button title",
    enabled: $isEnabled
) {
    print("Button tap closure")
}
```

### Button with `icon` only
> Pass in `accessibilityLabel` when creating a button with just an icon

```swift
BPKButton(
    icon: .longArrowRight,
    accessibilityLabel: "Button label"
) {
    print("Button tap closure")
}
```

### Button with `large` size

```swift
BPKButton(
    "Button title",
    size: .large
) {
    print("Button tap closure")
}
```