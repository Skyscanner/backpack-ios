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

#import "BPKMapAnnotationViewCalloutView.h"

#import <Backpack/BorderWidth.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/FlareView.h>
#import <Backpack/Icon.h>
#import <Backpack/Label.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

#import "BPKMapAnnotation.h"
#import "BPKMapAnnotationView.h"
#import "BPKMapAnnotationViewCalloutFlareView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationViewCalloutView ()
@property(nonatomic, strong) UIStackView *stackView;
@property(nonatomic, strong) BPKIconView *iconView;
@property(nonatomic, strong) BPKLabel *label;
@property(nonatomic, strong) UIColor *contentColor;
@property(nonatomic, strong) BPKMapAnnotationViewCalloutFlareView *flareView;
@property(nonatomic, readonly) CGFloat verticalPaddingSize;
@property(nonatomic, readonly) CGFloat horizontalPaddingSize;
@property(nonatomic, readonly) CGFloat maximumWidth;

- (void)setupAppearance;
@end

@implementation BPKMapAnnotationViewCalloutView

- (instancetype)initWithAnnotationView:(BPKMapAnnotationView *)annotationView {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.annotationView = annotationView;
        [self setupAppearance];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        [self setupAppearance];
    }

    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupAppearance];
    }

    return self;
}

- (void)update {
    self.label.text = self.annotationView.annotation.title;

    [self updateStyle];
}

- (void)setContentColor:(UIColor *)contentColor {
    if (_contentColor != contentColor) {
        _contentColor = contentColor;

        self.label.textColor = contentColor;
        self.iconView.tintColor = contentColor;
    }
}

- (void)updateStyle {
    BPKFontStyle fontStyle = BPKFontStyleTextBodyDefault;
    UIColor *backgroundColor = nil;
    UIColor *contentBackgroundColor = nil;
    UIColor *contentColor = nil;
    UIColor *borderColor = nil;

    if (!self.annotationView.enabled) {
        fontStyle = BPKFontStyleTextLabel2;
        backgroundColor = BPKColor.surfaceDefaultColor;
        contentBackgroundColor = BPKColor.clear;
        contentColor = BPKColor.textDisabledColor;
        borderColor = BPKColor.clear;
    } else if (self.annotationView.selected) {
        fontStyle = BPKFontStyleTextHeading5;
        backgroundColor = BPKColor.coreAccentColor;
        contentBackgroundColor = BPKColor.surfaceDefaultColor;
        contentColor = BPKColor.coreAccentColor;
        borderColor = BPKColor.coreAccentColor;
    } else if (self.annotationView.hasBeenSelected) {
        fontStyle = BPKFontStyleTextLabel2;
        backgroundColor = BPKColor.coreAccentColor;
        contentBackgroundColor = BPKColor.clear;
        contentColor = [BPKColor.textPrimaryInverseColor colorWithAlphaComponent:0.8];
        borderColor = BPKColor.clear;
    } else {
        fontStyle = BPKFontStyleTextLabel2;
        backgroundColor = BPKColor.coreAccentColor;
        contentBackgroundColor = BPKColor.clear;
        contentColor = BPKColor.surfaceDefaultColor;
        borderColor = BPKColor.clear;
    }

    self.label.fontStyle = fontStyle;
    self.flareView.backgroundView.backgroundColor = backgroundColor;
    self.flareView.contentView.backgroundColor = contentBackgroundColor;
    self.contentColor = contentColor;
    self.flareView.contentView.layer.borderColor = borderColor.CGColor;

    [self updateIcon];
    [self updateShadowPath];
}

- (void)updateIcon {
    id<MKAnnotation> annotation = self.annotationView.annotation;
    if ([annotation isKindOfClass:BPKMapAnnotation.class]) {
        BPKMapAnnotation *bpkAnnotation = (BPKMapAnnotation *)annotation;
        if (bpkAnnotation.iconName != nil) {
            self.iconView.hidden = NO;
            self.iconView.iconName = bpkAnnotation.iconName;
        } else {
            self.iconView.hidden = YES;
        }
    }
}

- (void)updateShadowPath {
    UIBezierPath *shadowPath = [BPKFlarePath flareViewPathForSize:self.bounds.size
                                                      flareHeight:self.flareView.flareHeight
                                                     cornerRadius:self.flareView.cornerRadius
                                                    flarePosition:self.flareView.flarePosition];

    CGPathRef finalPath = shadowPath.CGPath;
    self.layer.shadowPath = finalPath;
}

- (void)setupAppearance {
    self.userInteractionEnabled = NO;
    [[BPKShadow shadowSm] applyToLayer:self.layer];

    BPKMapAnnotationViewCalloutFlareView *flareView = [BPKMapAnnotationViewCalloutFlareView new];
    flareView.translatesAutoresizingMaskIntoConstraints = NO;
    flareView.contentView.layer.borderWidth = BPKBorderWidthLg;

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.spacing = BPKSpacingIconText;
    stackView.alignment = UIStackViewAlignmentCenter;

    BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:nil size:BPKIconSizeSmall];

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextHeading5];

    // Ensures that the icon will remain visible even if the label has to shrink
    [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    [self addSubview:flareView];
    [flareView.contentView addSubview:stackView];
    [stackView addArrangedSubview:iconView];
    [stackView addArrangedSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [flareView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor], [flareView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [flareView.widthAnchor constraintEqualToAnchor:self.widthAnchor], [flareView.heightAnchor constraintEqualToAnchor:self.heightAnchor],
        [stackView.leadingAnchor constraintEqualToAnchor:flareView.contentView.leadingAnchor constant:self.horizontalPaddingSize],
        [flareView.contentView.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor constant:self.horizontalPaddingSize],
        [stackView.topAnchor constraintEqualToAnchor:flareView.contentView.topAnchor constant:self.verticalPaddingSize],
        [flareView.contentView.bottomAnchor constraintEqualToAnchor:stackView.bottomAnchor constant:self.verticalPaddingSize],
        [self.widthAnchor constraintLessThanOrEqualToConstant:self.maximumWidth]
    ]];
    self.flareView = flareView;
    self.stackView = stackView;
    self.label = label;
    self.iconView = iconView;

    flareView.cornerRadius = BPKSpacingSm;
    [self updateStyle];
}

- (CGFloat)horizontalPaddingSize {
    return BPKSpacingMd;
}

- (CGFloat)verticalPaddingSize {
    return BPKSpacingSm;
}

- (CGFloat)maximumWidth {
    return BPKSpacingXxl * 5;
}

@end
NS_ASSUME_NONNULL_END
