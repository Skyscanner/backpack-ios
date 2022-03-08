/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BPKButton.h"
#import "BPKLegacyLinkButton.h"
#import "BPKButtonAppearance.h"
#import "BPKButtonAppearanceSet.h"
#import <Backpack/Backpack-Swift.h>
#import "UIColor+BPKButton.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Font.h>
#import <Backpack/Gradient.h>
#import <Backpack/Icon.h>
#import <Backpack/Radii.h>
#import <Backpack/Spacing.h>
#import <Backpack/UIView+BPKRTL.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKLegacyLinkButton ()
@property(nonatomic, getter=isInitializing) BOOL initializing;

@property(nonatomic) BPKGradientLayer *gradientLayer;

@property(nonatomic, readonly) BOOL hasTitle;
@property(nonatomic, readonly, getter=hasIcon) BOOL hasIcon;
@property(nonatomic, readonly, getter=isIconOnly) BOOL iconOnly;
@property(nonatomic, readonly, getter=isTextOnly) BOOL textOnly;
@property(nonatomic, readonly, getter=isTextAndIcon) BOOL textAndIcon;

@property(nonatomic, readonly) UIColor *currentContentColor;
@property(nonatomic, readonly) BPKButtonAppearance *currentAppearance;
@property(nonatomic, readonly) BPKFontStyle currentFontStyle;
@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) NSNumber *cornerRadius;
@end

@implementation BPKLegacyLinkButton

- (instancetype)initWithSize:(BPKButtonSize)size {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault];
    }

    return self;
}

-(UIColor *)applyHighlightToColor:(UIColor *)color highlighted:(BOOL)highlighted {
    return highlighted ? [UIColor dimColor:color] : color;
}

- (BPKButtonAppearance *)themedAppearance:(BPKButtonAppearance *)appearance highlighted:(BOOL)highlighted {
    BPKButtonAppearance *themedAppearance = [appearance clone];
    if (self.linkContentColor) {
        if (highlighted) {
            themedAppearance.foregroundColor = [UIColor reduceOpacityOfColor:self.linkContentColor];
        } else {
            themedAppearance.foregroundColor = self.linkContentColor;
        }
    }
    return themedAppearance;
}

- (BPKButtonAppearance *)currentAppearance {
    BPKButtonAppearanceSet *appearanceSet = BPKButtonAppearanceSets.link;

    if (self.isLoading) {
        return appearanceSet.loadingAppearance;
    }
    if (!self.isEnabled) {
        return appearanceSet.disabledAppearance;
    }
    if (self.highlighted) {
        return [self themedAppearance:appearanceSet.highlightedAppearance highlighted:YES];
    }
    return [self themedAppearance:appearanceSet.regularAppearance highlighted:NO];
}

- (UIColor *)currentContentColor {
    return self.currentAppearance.foregroundColor;
}

- (void)setupWithSize:(BPKButtonSize)size {
    self.initializing = YES;

    _cornerRadius = @(BPKCornerRadiusSm);

    self.layer.masksToBounds = YES;
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;

    // Use this to get the title value if one has been set in storyboard.
    if (self.titleLabel != nil && self.titleLabel.text != nil) {
        _title = self.titleLabel.text;
    }

    self.size = size;
    self.imagePosition = BPKButtonImagePositionTrailing;

    self.gradientLayer = [[BPKGradientLayer alloc] init];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];

    [self updateEdgeInsets];
    [self updateAppearance];
    [self updateTitle];
    self.initializing = NO;
}

- (BOOL)hasTitle {
    return self.titleLabel.text.length > 0 && self.currentAttributedTitle != nil;
}

- (BOOL)hasIcon {
    // A button has an image if `currentImage` is set with the exception
    // of when the image is one of the two dummy images used for the
    // positoning hack for the text only button in the loading state

    return self.currentImage != nil && self.currentImage != [[self class] defaultDummyImage] && self.currentImage != [[self class] largeDummyImage];
}

- (BOOL)isIconOnly {
    return self.currentImage && !self.hasTitle;
}

- (BOOL)isTextOnly {
    return !self.hasIcon && self.hasTitle;
}

- (BOOL)isTextAndIcon {
    return self.hasIcon && self.hasTitle;
}

#pragma mark - Style setters

- (void)setSize:(BPKButtonSize)size {
    BPKAssertMainThread();
    if (_size != size || self.isInitializing) {
        _size = size;

        [self updateTitle];
    }
}

- (void)setImagePosition:(BPKButtonImagePosition)imagePosition {
    if (_imagePosition != imagePosition || self.isInitializing) {
        _imagePosition = imagePosition;

        [self setNeedsLayout];
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    _title = [title copy];
    [self updateTitle];
}

- (void)updateTitle {
    if (self.title) {
        NSAttributedString *attributedTitle = [BPKFont attributedStringWithFontStyle:self.currentFontStyle
                                                                             content:self.title
                                                                           textColor:self.currentContentColor];
        [self setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    } else {
        [self setAttributedTitle:nil forState:UIControlStateNormal];
        [self setAttributedTitle:nil forState:UIControlStateHighlighted];
    }

    [self updateFont];
    [self updateEdgeInsets];
}

- (void)setImage:(UIImage *_Nullable)image {
    BPKAssertMainThread();
    [super setImage:image forState:UIControlStateNormal];

    [self updateAppearance];
    [self updateTitle];
    [self updateEdgeInsets];
}

#pragma mark - State setters

- (void)setEnabled:(BOOL)enabled {
    BPKAssertMainThread();
    BOOL changed = self.isEnabled != enabled;

    [super setEnabled:enabled];

    if (changed) {
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setSelected:(BOOL)selected {
    BPKAssertMainThread();
    NSAssert(NO, @"The Backpack button does not support selected");
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
    BPKAssertMainThread();
    BOOL changed = self.isHighlighted != highlighted;

    [super setHighlighted:highlighted];

    if (changed) {
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setIsLoading:(BOOL)isLoading {
    BPKAssertMainThread();
    if (_isLoading != isLoading) {
        _isLoading = isLoading;
        [self updateLoadingState:isLoading];
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.gradientLayer.frame = self.layer.bounds;
    self.layer.cornerRadius = 0;
    CGFloat buttonTitleIconSpacing = [[self class] buttonTitleIconSpacing];

    if (self.isTextAndIcon || (self.isLoading && self.isTextOnly)) {
        if (self.imagePosition == BPKButtonImagePositionTrailing) {
            UIEdgeInsets titleEdgeInsets =
                [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                leading:-(CGRectGetWidth(self.imageView.bounds) + buttonTitleIconSpacing / 2.0)
                                                 bottom:0
                                               trailing:(CGRectGetWidth(self.imageView.bounds) + buttonTitleIconSpacing / 2.0)];
            self.titleEdgeInsets = titleEdgeInsets;

            UIEdgeInsets imageEdgeInsets =
                [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                leading:(CGRectGetWidth(self.titleLabel.bounds) + buttonTitleIconSpacing / 2.0)
                                                 bottom:0
                                               trailing:-(CGRectGetWidth(self.titleLabel.bounds) + buttonTitleIconSpacing / 2.0)];
            self.imageEdgeInsets = imageEdgeInsets;
        } else {
            UIEdgeInsets titleEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:(buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:-(buttonTitleIconSpacing / 2.0)];
            self.titleEdgeInsets = titleEdgeInsets;

            UIEdgeInsets imageEdgeInsets = [self bpk_makeRTLAwareEdgeInsetsWithTop:0
                                                                           leading:-(buttonTitleIconSpacing / 2.0)
                                                                            bottom:0
                                                                          trailing:(buttonTitleIconSpacing / 2.0)];
            self.imageEdgeInsets = imageEdgeInsets;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.contentEdgeInsets = [self contentEdgeInsetsForSize:self.size];
    }

    self.spinner.center = self.imageView.center;
    self.imageView.alpha = self.isLoading ? .0f : 1.f;
}

- (CGSize)intrinsicContentSize {
    CGSize superSize = [super intrinsicContentSize];
    if (self.isIconOnly || self.isTextOnly) {
        return superSize;
    }

    return CGSizeMake(superSize.width + [[self class] buttonTitleIconSpacing], superSize.height);
}

#pragma mark Spacing

- (UIEdgeInsets)contentEdgeInsetsForSize:(BPKButtonSize)size {
    return UIEdgeInsetsMake(BPKSpacingNone, BPKSpacingNone, BPKSpacingNone, BPKSpacingNone);
}

#pragma mark - Updates

- (void)updateAppearance {
    BPKButtonAppearance *appearance = self.currentAppearance;
    self.tintColor = appearance.foregroundColor;
    self.imageView.tintColor = appearance.foregroundColor;
    self.spinner.tintColor = appearance.foregroundColor;

    if (appearance.gradientStartColor != nil && appearance.gradientEndColor != nil) {
        self.gradientLayer.gradient = [self gradientWithTopColor:appearance.gradientStartColor bottomColor:appearance.gradientEndColor];
    } else {
        self.gradientLayer.gradient = nil;
    }

    if (appearance.borderColor != nil) {
        self.layer.borderColor = appearance.borderColor.CGColor;
        self.layer.borderWidth = 2;
    } else {
        self.layer.borderWidth = 0;
    }

    [self setNeedsDisplay];
}

- (void)updateFont {
    if (self.isIconOnly) {
        self.titleLabel.font = [UIFont systemFontOfSize:0];
        [self setAttributedTitle:nil forState:UIControlStateNormal];
    }

    [self setNeedsDisplay];
}

- (void)updateEdgeInsets {
    if (self.isIconOnly) {
        self.imageEdgeInsets = UIEdgeInsetsZero;
        self.titleEdgeInsets = UIEdgeInsetsZero;
    }

    self.contentEdgeInsets = [self contentEdgeInsetsForSize:self.size];
    [self setNeedsLayout];
}

#pragma mark - Helpers

- (BPKFontStyle)currentFontStyle {
    switch (self.size) {
    case BPKButtonSizeDefault:
        return BPKFontStyleTextLabel2;
    case BPKButtonSizeLarge:
        return BPKFontStyleTextHeading4;
    default:
        NSAssert(NO, @"Unknown button size %ld", (unsigned long)self.size);
        return BPKFontStyleTextLabel2;
    }
}

- (BPKGradient *)gradientWithSingleColor:(UIColor *)color {
    NSParameterAssert(color);

    return [self gradientWithTopColor:color bottomColor:color];
}

- (BPKGradient *)gradientWithTopColor:(UIColor *)top bottomColor:(UIColor *)bottom {
    NSParameterAssert(top);
    NSParameterAssert(bottom);

    UIColor *resolvedTopColor = [top resolvedColorWithTraitCollection:self.traitCollection];
    UIColor *resolvedBottomColor = [bottom resolvedColorWithTraitCollection:self.traitCollection];

    BPKGradientDirection direction = BPKGradientDirectionDown;
    return [[BPKGradient alloc] initWithColors:@[resolvedTopColor, resolvedBottomColor]
                                    startPoint:[BPKGradient startPointForDirection:direction]
                                      endPoint:[BPKGradient endPointForDirection:direction]];
}

- (void)setupSpinner {
    self.spinner = [[UIActivityIndicatorView alloc] init];
    switch (self.size) {
    case BPKButtonSizeDefault:
        self.spinner.transform = CGAffineTransformMakeScale(.75f, .75f);
        break;

    case BPKButtonSizeLarge:
        self.spinner.transform = CGAffineTransformMakeScale(1.f, 1.f);
        break;
    }

    [self addSubview:self.spinner];
}

- (void)updateLoadingState:(BOOL)loading {
    self.enabled = !loading;
    self.spinner.hidden = !self.isLoading;

    if (!self.spinner && self.isLoading) {
        [self setupSpinner];
    }

    if (loading) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }

    // For text only buttons we piggy back on
    // the icon implementation which shows the spinner
    // in the same location as the icon by creating
    // a dummy image. This dummy image is rendered
    // with opacity 0.0 but it serves to create the
    // required space in the layout to show the spinner.
    if (self.isTextOnly) {
        if (loading) {
            [self setImage:[self dummyImage]];
            self.imageView.layer.opacity = 0.0;
        } else {
            [self setImage:nil];
            self.imageView.layer.opacity = 1.0;
        }
    }
}

- (void)setLinkContentColor:(UIColor *_Nullable)linkContentColor {
    if (linkContentColor != _linkContentColor) {
        _linkContentColor = linkContentColor;
        [self updateAppearance];
        [self updateTitle];
    }
}

// Note this is needed as the system does not correctly respond to the trait collection change to update the background
// color.
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
        [self updateAppearance];
        [self updateTitle];
    }
#endif
}

+ (CGFloat)buttonTitleIconSpacing {
    return BPKSpacingIconText;
}

- (UIImage *)dummyImage {
    switch (self.size) {
    case BPKButtonSizeDefault:
        return [[self class] defaultDummyImage];
    case BPKButtonSizeLarge:
        return [[self class] largeDummyImage];
    default:
        NSAssert(NO, @"Unknown size %lu", (unsigned long)self.size);
    }
}

+ (UIImage *)defaultDummyImage {
    static dispatch_once_t onceToken;
    static UIImage *image;

    dispatch_once(&onceToken, ^{
      BPKAssertMainThread();
      CGSize size = [BPKIcon concreteSizeForIconSize:BPKIconSizeSmall];

      UIGraphicsBeginImageContextWithOptions(size, YES, 0);
      [UIColor.blackColor setFill];
      UIRectFill(CGRectMake(0, 0, size.width, size.height));
      image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
    });

    return image;
}

+ (UIImage *)largeDummyImage {
    static dispatch_once_t onceToken;
    static UIImage *image;

    dispatch_once(&onceToken, ^{
      BPKAssertMainThread();
      CGSize size = [BPKIcon concreteSizeForIconSize:BPKIconSizeLarge];

      UIGraphicsBeginImageContextWithOptions(size, YES, 0);
      [UIColor.blackColor setFill];
      UIRectFill(CGRectMake(0, 0, size.width, size.height));
      image = UIGraphicsGetImageFromCurrentImageContext();
      UIGraphicsEndImageContext();
    });

    return image;
}

@end

NS_ASSUME_NONNULL_END
