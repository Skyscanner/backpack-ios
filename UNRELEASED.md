# Unreleased

**Added:**

- Backpack/Icon
  - Added a new class `BPKIconView`(`IconView` in Swift) for displaying icons. It is based on `UIImageView` and the perfect choice when you just want to display an icon with a tint.

    ```objective-c
    #import <Backpack/Color.h>
    #import <Backpack/Icon.h>

    BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:BPKIconNameAccessibility
                                                               size:BPKIconSizeLarge];
    iconView.tintColor = BPKColor.blue500;
    ```

