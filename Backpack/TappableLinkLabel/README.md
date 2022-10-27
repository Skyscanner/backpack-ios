# Backpack/TappableLinkLabel

[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKTappableLinkLabel.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/TappableLinkLabel)

## With multiple links

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-tappable-link-label___multiple_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-tappable-link-label___multiple_dm.png) |

## Alternate style

| Day | Night |
| --- | --- |
| ![iPhone 8 simulator](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-tappable-link-label___alternate-style_lm.png) |![iPhone 8 simulator - dark mode](https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone%208-tappable-link-label___alternate-style_dm.png) |

## Usage

`BPKTappableLinkLabel` is a view that renders flowing text that can include tappable links as part of its content.

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

// Apply custom text color:
tappableLinkLabel.textColor = BPKColor.panjin;

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

let tappableLinkLabel = BPKTappableLinkLabel(fontStyle: .textBase)
tappableLinkLabel.text = “Find out more about our terms of service.”
tappableLinkLabel.delegate = self

tappableLinkLabel.addLink(to: URL(string: "https:...")!, withRange: Range(location:24, length:16))
tappableLinkLabel.addLink(toTransitInformation: ["identifier": "some link thing"], withRange: Range(location:24, length:16))
// Position label with autolayout or other method

// Apply alternative style:
tappableLinkLabel.style = .alternative

// Apply custom text color:
tappableLinkLabel.textColor = BPKColor.panjin

...

extension MyClass: BPKTappableLinkLabelDelegate {
  func tappableLabel(_ label: BPKTappableLinkLabel, didSelectLinkWith url: URL) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
  }

  func tappableLabel(_ label: BPKTappableLinkLabel,
                       didSelectLinkWithTransitInformation components: [AnyHashable: Any]) {
      print(components)
  }
}
```

### Appearance attributes

- `(UIColor)linkContentColor`
