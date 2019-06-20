# Backpack/TappableLinkLabel

## Usage

`BPKTappableLinkLabel`/`Backpack.TappableLinkLabel` is a subclass of BPKLabel with the ability to add Skyscanner style links. 

### Objective-C

```objectivec
#import <Backpack/TappableLinkLabel.h>

BPKTappableLinkLabel *tappableLinkLabel = [[BPKTappableLinkLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
tappableLinkLabel.text = @“Find out more about our terms of service.”
tappableLinkLabel.delegate = self;

[tappableLinkLabel addLinkToURL:[NSURL URLWithString:@"http:..."] withRange:NSRange(location:24, length:16)];
// Position label with autolayout or other method

...

#pragma BPKTappableLabelDelegate

- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [delegate openURL:url];
}
```

### Swift

```swift
import Backpack

let tappableLinkLabel = Backpack.TappableLinkLabel(fontStyle: .base)
tappableLinkLabel.text = “Find out more about our terms of service.”
tappableLinkLabel.delegate = self;

tappableLinkLabel.addLinkToURL(url: "https:...", withRange: Range(location:24, length:16));
// Position label with autolayout or other method

...

extension MyClass: BPKTappableLinkLabelDelegate {
    func attributedLabel(_ label: BPKTappableLinkLabel!, didSelectLinkWith url: URL!) {
        delegate?.openURL(url)
    }
}
```

### Appearance attributes
`(UIColor)linkContentColor`

`(BPKFontMapping)fontMapping`

