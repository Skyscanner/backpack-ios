/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

/*
 * Note that in some places we are having to resolve the correct UIColors from dynamic values ourselves to ensure
 * that we support overriding UIViewController interface styles. if we allow UIKit to resolve them for us,
 * it may do so wrongly.
 * This is because UIKit only sets the UIView's trait collection on a handful of lifecycle methods, and we
 * are using dynamic colours outside of these. If we do not manually resolve colours using self.traitCollection,
 * then UIKit will fall back to using [UITraitCollection currentTraitCollection] which does not reflect the override.
 */

#import "BPKButton.h"
#import "BPKButtonAppearance.h"
#import "BPKButtonAppearanceSet.h"
#import "BPKButtonAppearanceSets.h"

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
@interface BPKButton ()
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

@implementation BPKButton

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithSize:size style:style];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    }

    return self;
}

-(UIColor *)applyHighlightToColor:(UIColor *)color highlighted:(BOOL)highlighted {
    if (!highlighted) {
        return color;
    }
    return [BPKColor blend:color with:BPKColor.skyGray weight:0.85f];
}

- (BPKButtonAppearance *)themedAppearance:(BPKButtonAppearance *)appearance highlighted:(BOOL)highlighted {
    BPKButtonAppearance *themedAppearance = [appearance clone];
    switch (self.style) {
        case BPKButtonStylePrimary:
            if (self.primaryContentColor) {
                themedAppearance.foregroundColor = [self applyHighlightToColor:self.primaryContentColor highlighted:highlighted];
            }
            if (self.primaryGradientStartColor) {
                themedAppearance.gradientStartColor = [self applyHighlightToColor:self.primaryGradientStartColor highlighted:highlighted];
            }
            if (self.primaryGradientEndColor) {
                themedAppearance.gradientEndColor = [self applyHighlightToColor:self.primaryGradientEndColor highlighted:highlighted];
            }
            break;
        case BPKButtonStyleSecondary:
            if (self.secondaryContentColor) {
                themedAppearance.foregroundColor = [self applyHighlightToColor:self.secondaryContentColor highlighted:highlighted];
            }
            if (self.secondaryBorderColor) {
                themedAppearance.borderColor = [self applyHighlightToColor:self.secondaryBorderColor highlighted:highlighted];
            }
            if (self.secondaryBackgroundColor) {
                themedAppearance.gradientStartColor = [self applyHighlightToColor:self.secondaryBackgroundColor highlighted:highlighted];
                themedAppearance.gradientEndColor = [self applyHighlightToColor:self.secondaryBackgroundColor highlighted:highlighted];
            }
            break;
        case BPKButtonStyleDestructive:
            if (self.destructiveContentColor) {
                themedAppearance.foregroundColor = [self applyHighlightToColor:self.destructiveContentColor highlighted:highlighted];
            }
            if (self.destructiveBorderColor) {
                themedAppearance.borderColor = [self applyHighlightToColor:self.destructiveBorderColor highlighted:highlighted];
            }
            if (self.destructiveBackgroundColor) {
                themedAppearance.gradientStartColor = [self applyHighlightToColor:self.destructiveBackgroundColor highlighted:highlighted];
                themedAppearance.gradientEndColor = [self applyHighlightToColor:self.destructiveBackgroundColor highlighted:highlighted];
            }
            break;
        case BPKButtonStyleFeatured:
            if (self.featuredContentColor) {
                themedAppearance.foregroundColor = [self applyHighlightToColor:self.featuredContentColor highlighted:highlighted];
            }
            if (self.featuredGradientStartColor) {
                themedAppearance.gradientStartColor = [self applyHighlightToColor:self.featuredGradientStartColor highlighted:highlighted];
            }
            if (self.featuredGradientEndColor) {
                themedAppearance.gradientEndColor = [self applyHighlightToColor:self.featuredGradientEndColor highlighted:highlighted];
            }
            break;
        case BPKButtonStyleLink:
            if (self.linkContentColor) {
                if (highlighted) {
                    themedAppearance.foregroundColor = [self.linkContentColor colorWithAlphaComponent:0.8f];
                } else {
                    themedAppearance.foregroundColor = self.linkContentColor;
                }
            }
            break;
        case BPKButtonStyleOutline:
            break;
    }

    return themedAppearance;
}

- (BPKButtonAppearance *)currentAppearance {
    BPKButtonAppearanceSet *appearanceSet = BPKButtonAppearanceSets.primary;

    switch (self.style) {
        case BPKButtonStylePrimary:
            appearanceSet = BPKButtonAppearanceSets.primary;
            break;
        case BPKButtonStyleSecondary:
            appearanceSet = BPKButtonAppearanceSets.secondary;
            break;
        case BPKButtonStyleDestructive:
            appearanceSet = BPKButtonAppearanceSets.destructive;
            break;
        case BPKButtonStyleFeatured:
            appearanceSet = BPKButtonAppearanceSets.featured;
            break;
        case BPKButtonStyleLink:
            appearanceSet = BPKButtonAppearanceSets.link;
            break;
        case BPKButtonStyleOutline:
            appearanceSet = BPKButtonAppearanceSets.outline;
            break;
    }

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

- (void)setupWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
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
    self.style = style;
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

- (void)setStyle:(BPKButtonStyle)style {
    BPKAssertMainThread();
    if (_style != style || self.isInitializing) {
        _style = style;

        [self updateAppearance];
        [self updateTitle];
        [self updateEdgeInsets];
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

    if (self.style != BPKButtonStyleLink) {
        if (self.cornerRadius != nil && !self.iconOnly) {
            self.layer.cornerRadius = self.cornerRadius.doubleValue;
        } else {
            // Pill shape
            CGFloat radius = CGRectGetHeight(self.bounds) / 2.0f;
            [self.layer setCornerRadius:radius];
        }
    } else {
        self.layer.cornerRadius = 0;
    }
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
        self.contentEdgeInsets = [self contentEdgeInsetsForStyle:self.style size:self.size];
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

- (UIEdgeInsets)contentEdgeInsetsForStyle:(BPKButtonStyle)style size:(BPKButtonSize)size {
    switch (style) {
        case BPKButtonStyleLink:
            return UIEdgeInsetsMake(BPKSpacingNone, BPKSpacingNone, BPKSpacingNone, BPKSpacingNone);

            // NOTE: Explicit fall-through
        case BPKButtonStylePrimary:
        case BPKButtonStyleFeatured:
        case BPKButtonStyleSecondary:
        case BPKButtonStyleDestructive:
        case BPKButtonStyleOutline:
            switch (size) {
                case BPKButtonSizeDefault: {
                    if (self.isIconOnly) {
                        return UIEdgeInsetsMake(BPKSpacingMd, BPKSpacingMd, BPKSpacingMd, BPKSpacingMd);
                    } else {
                        return UIEdgeInsetsMake(BPKSpacingMd, BPKSpacingSm * 3, BPKSpacingMd, BPKSpacingSm * 3);
                    }
                }
                case BPKButtonSizeLarge: {
                    if (self.isIconOnly) {
                        return UIEdgeInsetsMake(BPKSpacingSm * 3, BPKSpacingSm * 3, BPKSpacingSm * 3, BPKSpacingSm * 3);
                    } else {
                        return UIEdgeInsetsMake(BPKSpacingSm * 3, BPKSpacingBase, BPKSpacingSm * 3, BPKSpacingBase);
                    }
                }
                default:
                    NSAssert(NO, @"Unknown size %d", (int)size);
                    break;
            }
            break;
        default:
            NSAssert(NO, @"Unknown style %d", (int)style);
    }
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

    self.contentEdgeInsets = [self contentEdgeInsetsForStyle:self.style size:self.size];
    [self setNeedsLayout];
}

#pragma mark - Helpers

- (BPKFontStyle)currentFontStyle {
    switch (self.size) {
        case BPKButtonSizeDefault:
            return BPKFontStyleTextSmEmphasized;
        case BPKButtonSizeLarge:
            return BPKFontStyleTextLgEmphasized;
        default:
            NSAssert(NO, @"Unknown button size %ld", (unsigned long)self.size);
            return BPKFontStyleTextSmEmphasized;
    }
}

- (BPKGradient *)gradientWithSingleColor:(UIColor *)color {
    NSParameterAssert(color);

    return [self gradientWithTopColor:color bottomColor:color];
}

- (BPKGradient *)gradientWithTopColor:(UIColor *)top bottomColor:(UIColor *)bottom {
    NSParameterAssert(top);
    NSParameterAssert(bottom);

    UIColor *resolvedTopColor = top;
    UIColor *resolvedBottomColor = bottom;

#if __BPK_DARK_MODE_SUPPORTED
    if (@available(iOS 13.0, *)) {
        resolvedTopColor = [top resolvedColorWithTraitCollection:self.traitCollection];
        resolvedBottomColor = [bottom resolvedColorWithTraitCollection:self.traitCollection];
    }
#endif

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

- (void)setFeaturedContentColor:(UIColor *_Nullable)featuredContentColor {
    if (featuredContentColor != _featuredContentColor) {
        _featuredContentColor = featuredContentColor;
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setFeaturedGradientStartColor:(UIColor *_Nullable)featuredGradientStartColor {
    if (featuredGradientStartColor != _featuredGradientStartColor) {
        _featuredGradientStartColor = featuredGradientStartColor;
        [self updateAppearance];
    }
}

- (void)setFeaturedGradientEndColor:(UIColor *_Nullable)featuredGradientEndColor {
    if (featuredGradientEndColor != _featuredGradientEndColor) {
        _featuredGradientEndColor = featuredGradientEndColor;
        [self updateAppearance];
    }
}

- (void)setPrimaryContentColor:(UIColor *_Nullable)primaryContentColor {
    if (primaryContentColor != _primaryContentColor) {
        _primaryContentColor = primaryContentColor;
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setPrimaryGradientStartColor:(UIColor *_Nullable)primaryGradientStartColor {
    if (primaryGradientStartColor != _primaryGradientStartColor) {
        _primaryGradientStartColor = primaryGradientStartColor;
        [self updateAppearance];
    }
}

- (void)setPrimaryGradientEndColor:(UIColor *_Nullable)primaryGradientEndColor {
    if (primaryGradientEndColor != _primaryGradientEndColor) {
        _primaryGradientEndColor = primaryGradientEndColor;
        [self updateAppearance];
    }
}

- (void)setSecondaryContentColor:(UIColor *_Nullable)secondaryContentColor {
    if (secondaryContentColor != _secondaryContentColor) {
        _secondaryContentColor = secondaryContentColor;
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setSecondaryBackgroundColor:(UIColor *_Nullable)secondaryBackgroundColor {
    if (secondaryBackgroundColor != _secondaryBackgroundColor) {
        _secondaryBackgroundColor = secondaryBackgroundColor;
        [self updateAppearance];
    }
}

- (void)setSecondaryBorderColor:(UIColor *_Nullable)secondaryBorderColor {
    if (secondaryBorderColor != _secondaryBorderColor) {
        _secondaryBorderColor = secondaryBorderColor;
        [self updateAppearance];
    }
}

- (void)setDestructiveContentColor:(UIColor *_Nullable)destructiveContentColor {
    if (destructiveContentColor != _destructiveContentColor) {
        _destructiveContentColor = destructiveContentColor;
        [self updateAppearance];
        [self updateTitle];
    }
}

- (void)setDestructiveBackgroundColor:(UIColor *_Nullable)destructiveBackgroundColor {
    if (destructiveBackgroundColor != _destructiveBackgroundColor) {
        _destructiveBackgroundColor = destructiveBackgroundColor;
        [self updateAppearance];
    }
}

- (void)setDestructiveBorderColor:(UIColor *_Nullable)destructiveBorderColor {
    if (destructiveBorderColor != _destructiveBorderColor) {
        _destructiveBorderColor = destructiveBorderColor;
        [self updateAppearance];
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
    // TODO change to BPKSpacingMd
    return BPKSpacingSm;
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
