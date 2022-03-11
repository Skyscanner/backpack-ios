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
#import "UIColor+BPKButton.h"

#import <Backpack/Backpack-Swift.h>
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

@property(nonatomic) BPKGradientLayer *gradientLayer;

@property(nonatomic, strong) UIActivityIndicatorView *spinner;
@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UIStackView *contentStack;
@property(nonatomic, strong) NSLayoutConstraint *heightConstraint;
@property(nonatomic, strong) NSLayoutConstraint *widthConstraint;
@property(nonatomic, strong) NSLayoutConstraint *stackLeadingConstraint;
@property(nonatomic, strong) NSLayoutConstraint *stackTrailingConstraint;
@property(nonatomic, strong) NSLayoutConstraint *stackTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *stackBottomConstraint;

@end

@implementation BPKButton

- (instancetype)initWithSize:(BPKButtonSize)size style:(BPKButtonStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        _size = size;
        _style = style;
        [self setup];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        _size = BPKButtonSizeDefault;
        _style = BPKButtonStylePrimary;
        [self setup];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        _size = BPKButtonSizeDefault;
        _style = BPKButtonStylePrimary;
        [self setup];
    }

    return self;
}

- (UIView *)createContentView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectZero];
    contentView.backgroundColor = BPKColor.clear;
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    contentView.clipsToBounds = NO;
    [contentView setUserInteractionEnabled:NO];
    return contentView;
}

- (BPKLabel *)createTitleLabel {
    BPKLabel *titleLabel = [[BPKLabel alloc] initWithFontStyle:[self fontStyleForSize:self.size]];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [titleLabel setUserInteractionEnabled:NO];
    return titleLabel;
}

- (UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setUserInteractionEnabled:NO];
    return imageView;
}

- (UIStackView *)createContentStack {
    UIStackView *stack = [[UIStackView alloc] initWithFrame:CGRectZero];
    stack.axis = UILayoutConstraintAxisHorizontal;
    stack.spacing = BPKSpacingMd;
    stack.translatesAutoresizingMaskIntoConstraints = NO;
    return stack;
}

- (void)configureAccesibilityTraits {
    self.isAccessibilityElement = YES;

    self.accessibilityTraits = self.isEnabled ? UIAccessibilityTraitButton : (UIAccessibilityTraitNotEnabled | UIAccessibilityTraitButton);
    self.accessibilityLabel = self.title;
    self.titleLabel.isAccessibilityElement = NO;
    self.imageView.isAccessibilityElement = NO;
    self.spinner.isAccessibilityElement = NO;
}

- (void)setup {
    self.contentView = [self createContentView];
    self.titleLabel = [self createTitleLabel];
    self.imageView = [self createImageView];
    self.contentStack = [self createContentStack];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.contentStack];
    self.spinner = [[UIActivityIndicatorView alloc] init];
    self.spinner.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.spinner];

    self.heightConstraint = [self.heightAnchor constraintEqualToConstant:[self heightForSize:self.size]];
    // To use when just icon
    self.widthConstraint = [self.widthAnchor constraintEqualToConstant:[self heightForSize:self.size]];
    self.stackLeadingConstraint = [self.contentStack.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:BPKSpacingBase];
    self.stackTrailingConstraint = [self.contentStack.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor
                                                                                    constant:-BPKSpacingBase];
    self.stackTopConstraint = [self.contentStack.topAnchor constraintGreaterThanOrEqualToAnchor:self.contentView.topAnchor constant:0];
    self.stackBottomConstraint = [self.contentStack.bottomAnchor constraintLessThanOrEqualToAnchor:self.contentView.bottomAnchor constant:0];

    self.imagePosition = BPKButtonImagePositionTrailing;

    self.layer.masksToBounds = YES;

    self.gradientLayer = [[BPKGradientLayer alloc] init];
    [self.layer insertSublayer:self.gradientLayer atIndex:0];

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;

    [self setupConstraints];
    [self updateLookAndFeel];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        [self.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor], self.stackLeadingConstraint, self.stackTrailingConstraint,
        self.stackTopConstraint, self.stackBottomConstraint, [self.contentStack.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
        [self.contentStack.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
        self.heightConstraint, [self.spinner.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.spinner.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
    ]];
}

- (void)addContentInOrder {
    for (UIView *subview in self.contentStack.arrangedSubviews) {
        [self.contentStack removeArrangedSubview:subview];
    }
    if (self.imagePosition == BPKButtonImagePositionLeading) {
        [self.contentStack addArrangedSubview:self.imageView];
        [self.contentStack addArrangedSubview:self.titleLabel];
    } else {
        [self.contentStack addArrangedSubview:self.titleLabel];
        [self.contentStack addArrangedSubview:self.imageView];
    }
}

- (void)updateSize {
    BPKButtonSize size = self.size;
    self.titleLabel.fontStyle = [self fontStyleForSize:size];
    self.heightConstraint.constant = [self heightForSize:size];

    self.spinner.transform = [self spinnerTransformForSize:size];
    [self updateConstraintsForType];
}

- (void)updateIconOnlyConstraints {
    [NSLayoutConstraint deactivateConstraints:@[self.stackLeadingConstraint, self.stackTrailingConstraint]];
    [NSLayoutConstraint activateConstraints:@[self.widthConstraint, self.heightConstraint]];
    self.widthConstraint.constant = [self heightForSize:self.size];
}

- (void)updateLinkConstraints {
    self.stackLeadingConstraint.constant = 0;
    self.stackTrailingConstraint.constant = 0;
    [NSLayoutConstraint deactivateConstraints:@[self.widthConstraint]];
}

- (void)updateDefaultConstraints {
    [NSLayoutConstraint deactivateConstraints:@[self.widthConstraint]];
    self.stackLeadingConstraint.constant = BPKSpacingBase;
    self.stackTrailingConstraint.constant = -BPKSpacingBase;
    [NSLayoutConstraint activateConstraints:@[self.stackLeadingConstraint, self.stackTrailingConstraint, self.heightConstraint]];
}

- (void)updateConstraintsForType {
    if (self.isIconOnly) {
        [self updateIconOnlyConstraints];
        return;
    }
    if (self.style == BPKButtonStyleLink) {
        [self updateLinkConstraints];
        return;
    }
    [self updateDefaultConstraints];
}

- (BOOL)hasTitle {
    return self.title != nil && self.title.length > 0;
}

- (BOOL)hasIcon {
    return self.imageView.image != nil;
}

- (BOOL)isIconOnly {
    return self.hasIcon && !self.hasTitle;
}

- (void)updateLookAndFeel {
    [self.imageView setHidden:!self.hasIcon];
    [self.titleLabel setHidden:!self.hasTitle];

    [self updateSize];
    [self updateAppearance];
    [self configureAccesibilityTraits];
}

- (void)updateAppearance {
    BPKButtonAppearance *appearance = self.currentAppearance;
    self.titleLabel.textColor = appearance.foregroundColor;
    self.imageView.tintColor = appearance.foregroundColor;
    self.spinner.color = appearance.foregroundColor;

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

- (BPKButtonAppearance *)currentAppearance {
    BPKButtonAppearanceSet *appearanceSet = [BPKButtonAppearanceSets appearanceFromStyle:self.style];
    if (self.isLoading)
        return appearanceSet.loadingAppearance;
    if (!self.isEnabled)
        return appearanceSet.disabledAppearance;
    if (self.highlighted)
        return [self themedAppearance:appearanceSet.highlightedAppearance highlighted:YES];
    return [self themedAppearance:appearanceSet.regularAppearance highlighted:NO];
}

#pragma mark - State setters

- (void)setSize:(BPKButtonSize)size {
    BPKAssertMainThread();
    _size = size;
    [self updateLookAndFeel];
}

- (void)setStyle:(BPKButtonStyle)style {
    BPKAssertMainThread();
    _style = style;
    [self updateLookAndFeel];
}

- (void)setImagePosition:(BPKButtonImagePosition)imagePosition {
    _imagePosition = imagePosition;
    [self addContentInOrder];
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();

    self.titleLabel.text = title;
    _title = [title copy];
    [self updateLookAndFeel];
}

- (void)setImage:(UIImage *_Nullable)image {
    BPKAssertMainThread();
    [self.imageView setImage:image];
    [self updateLookAndFeel];
}

- (void)setEnabled:(BOOL)enabled {
    BPKAssertMainThread();
    [super setEnabled:enabled];
    [self updateLookAndFeel];
}

- (void)setSelected:(BOOL)selected {
    BPKAssertMainThread();
    NSAssert(NO, @"The Backpack button does not support selected");
    [super setSelected:selected];
}

- (void)setHighlighted:(BOOL)highlighted {
    BPKAssertMainThread();
    [super setHighlighted:highlighted];
    [self updateLookAndFeel];
}

- (void)setIsLoading:(BOOL)isLoading {
    BPKAssertMainThread();
    _isLoading = isLoading;
    [self updateLoadingState];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.gradientLayer.frame = self.layer.bounds;
    self.layer.cornerRadius = [self cornerRadiusForStyle:self.style];
}

#pragma mark - Helpers

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

- (BPKFontStyle)fontStyleForSize:(BPKButtonSize)size {
    switch (size) {
    case BPKButtonSizeDefault:
        return BPKFontStyleTextLabel2;
    case BPKButtonSizeLarge:
        return BPKFontStyleTextLabel1;
    }
}

- (CGFloat)cornerRadiusForStyle:(BPKButtonStyle)style {
    if (style == BPKButtonStyleLink) {
        return 0;
    }
    return BPKCornerRadiusSm;
}

- (CGFloat)heightForSize:(BPKButtonSize)size {
    switch (size) {
    case BPKButtonSizeDefault:
        return 36.0;
    case BPKButtonSizeLarge:
        return 48.0;
    }
}

- (CGAffineTransform)spinnerTransformForSize:(BPKButtonSize)size {
    switch (size) {
    case BPKButtonSizeDefault:
        return CGAffineTransformMakeScale(.75f, .75f);
    case BPKButtonSizeLarge:
        return CGAffineTransformMakeScale(1.f, 1.f);
    }
}

- (void)updateLoadingState {
    self.enabled = !self.isLoading;
    self.spinner.hidden = !self.isLoading;

    if (self.isLoading) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }

    self.contentView.layer.opacity = self.isLoading ? 0.0 : 1.0;
}

// Note this is needed as the system does not correctly respond to the trait collection change to update the background
// color.
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self updateAppearance];
}

#pragma mark - Theming

- (UIColor *)applyHighlightToColor:(UIColor *)color highlighted:(BOOL)highlighted {
    return highlighted ? [UIColor dimColor:color] : color;
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
                themedAppearance.foregroundColor = [UIColor reduceOpacityOfColor:self.linkContentColor];
            } else {
                themedAppearance.foregroundColor = self.linkContentColor;
            }
        }
        break;
    case BPKButtonStylePrimaryOnDark:
        break; // not supporting theming for PrimaryOnDark
    case BPKButtonStylePrimaryOnLight:
        break; // not supporting theming for PimaryOnLight
    }

    return themedAppearance;
}

- (void)setFeaturedContentColor:(UIColor *_Nullable)featuredContentColor {
    _featuredContentColor = featuredContentColor;
    [self updateAppearance];
}

- (void)setFeaturedGradientStartColor:(UIColor *_Nullable)featuredGradientStartColor {
    _featuredGradientStartColor = featuredGradientStartColor;
    [self updateAppearance];
}

- (void)setFeaturedGradientEndColor:(UIColor *_Nullable)featuredGradientEndColor {
    _featuredGradientEndColor = featuredGradientEndColor;
    [self updateAppearance];
}

- (void)setPrimaryContentColor:(UIColor *_Nullable)primaryContentColor {
    _primaryContentColor = primaryContentColor;
    [self updateAppearance];
}

- (void)setPrimaryGradientStartColor:(UIColor *_Nullable)primaryGradientStartColor {
    _primaryGradientStartColor = primaryGradientStartColor;
    [self updateAppearance];
}

- (void)setPrimaryGradientEndColor:(UIColor *_Nullable)primaryGradientEndColor {
    _primaryGradientEndColor = primaryGradientEndColor;
    [self updateAppearance];
}

- (void)setSecondaryContentColor:(UIColor *_Nullable)secondaryContentColor {
    _secondaryContentColor = secondaryContentColor;
    [self updateAppearance];
}

- (void)setSecondaryBackgroundColor:(UIColor *_Nullable)secondaryBackgroundColor {
    _secondaryBackgroundColor = secondaryBackgroundColor;
    [self updateAppearance];
}

- (void)setSecondaryBorderColor:(UIColor *_Nullable)secondaryBorderColor {
    _secondaryBorderColor = secondaryBorderColor;
    [self updateAppearance];
}

- (void)setDestructiveContentColor:(UIColor *_Nullable)destructiveContentColor {
    _destructiveContentColor = destructiveContentColor;
    [self updateAppearance];
}

- (void)setDestructiveBackgroundColor:(UIColor *_Nullable)destructiveBackgroundColor {
    _destructiveBackgroundColor = destructiveBackgroundColor;
    [self updateAppearance];
}

- (void)setDestructiveBorderColor:(UIColor *_Nullable)destructiveBorderColor {
    _destructiveBorderColor = destructiveBorderColor;
    [self updateAppearance];
}

- (void)setLinkContentColor:(UIColor *_Nullable)linkContentColor {
    _linkContentColor = linkContentColor;
    [self updateAppearance];
}

@end

NS_ASSUME_NONNULL_END
