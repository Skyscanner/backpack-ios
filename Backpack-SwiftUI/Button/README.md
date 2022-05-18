# Button

## Usage

### Basic button with a title and action closure. 
If you don't specify a `.buttonStyle(<type>)` it will use the `.primary` type

```Swift
BPKButton("Button title") {
    print("Button tap closure")
}
```

### Styled `.secondary` Button.

```Swift 
BPKButton("Button title") {
    print("Button tap closure")
}
.buttonStyle(.secondary)
```

### Button with a title and icon. 

Set the icon to:
* `.leading(icon: <BPKIcon>)` 
* `.trailing(icon: <BPKICon>)`

```Swift
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

```Swift
BPKButton(
    "Button title",
    loading: $isLoading
) {
    print("Button tap closure")
}
```

### Button with `disabled` state. 

Pass in a `@State` variable or use `.constant(true)` 

```Swift
BPKButton(
    "Button title",
    enabled: $isEnabled
) {
    print("Button tap closure")
}
```

### Button with `icon` only
> Pass in `accessibilityLabel` when creating a button with just an icon

```Swift
BPKButton(
    icon: .longArrowRight,
    accessibilityLabel: "Button label"
) {
    print("Button tap closure")
}
```

### Button with `large` size

```Swift
BPKButton(
    "Button title",
    size: .large
) {
    print("Button tap closure")
}
```

## Button types

* .primary
* .secondary
* .destructive
* .featured
* .link
* .primaryOnDark
* .primaryOnLight
* .secondaryOnDark
* .linkOnDark