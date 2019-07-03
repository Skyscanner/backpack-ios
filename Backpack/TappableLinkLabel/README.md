# Backpack/TappableLinkLabel

## Usage

`BPKTappableLinkLabel`/`Backpack.TappableLinkLabel` is a view that renders flowing text that can include tappable links as part of its content.

### Objective-C

```objectivec
#import <Backpack/TappableLinkLabel.h>

BPKTappableLinkLabel *tappableLinkLabel = [[BPKTappableLinkLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
tappableLinkLabel.text = @“Find out more about our terms of service.”
tappableLinkLabel.delegate = self;

[tappableLinkLabel addLinkToURL:[NSURL URLWithString:@"http:..."] withRange:NSRange(location:24, length:16)];
[tappableLinkLabel addLinkToTransitInformation:@{} withRange:NSRange(location:24, length:16)];
// Position label with autolayout or other method

// Apply alternative style:
tappableLinkLabel.style = BPKTappableLinkLabelStyleAlternative;

...

#pragma mark - <BPKTappableLinkLabelDelegate>

- (void)tappableLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url {
    [_presenter urlTapped:url];
}

- (void)tappableLabel:(BPKTappableLinkLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    // do stuff
}
```

### Swift

```swift
import Backpack

let tappableLinkLabel = Backpack.TappableLinkLabel(fontStyle: .textBase)
tappableLinkLabel.text = “Find out more about our terms of service.”
tappableLinkLabel.delegate = self;

tappableLinkLabel.addLink(to: URL(string: "https:...")!, withRange: Range(location:24, length:16));
tappableLinkLabel.addLink(toTransitInformation: ["identifier": "some link thing"], withRange: Range(location:24, length:16));
// Position label with autolayout or other method

// Apply alternative style:
tappableLinkLabel.style = .alternative

...

extension MyClass: BPKTappableLinkLabelDelegate {
  func tappableLabel(_ label: TappableLinkLabel, didSelectLinkWith url: URL) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  func tappableLabel(_ label: TappableLinkLabel,
                       didSelectLinkWithTransitInformation components: [AnyHashable: Any]) {
      print(components)
  }
}
```

### Appearance attributes
`(UIColor)linkContentColor`

`(BPKFontMapping)fontMapping`

