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

#import "BPKMapAnnotationViewCalloutView.h"

#import "BPKMapAnnotationView.h"
#import "BPKMapAnnotation.h"

#import <Backpack/BorderWidth.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Label.h>
#import <Backpack/Shadow.h>
#import <Backpack/Icon.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationViewCalloutView ()
@property(nonatomic, strong) UIStackView *stackView;
@property(nonatomic, strong) BPKIconView *iconView;
@property(nonatomic, strong) BPKLabel *label;
@property(nonatomic, strong) UIColor *contentColor;
@property(nonatomic, readonly) CGFloat paddingSize;
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

- (CGFloat)flareHeight {
    // Design uses non-standard backpack spacing
    return 6;
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

-(void)updateStyle {
    if(!self.annotationView.enabled) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundView.backgroundColor = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint03];
        self.contentView.backgroundColor = BPKColor.clear;
        self.contentColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint05];
        self.contentView.layer.borderColor = BPKColor.clear.CGColor;
        [self updateIcon];
        return;
    }

    if(self.annotationView.selected) {
        self.label.fontStyle = BPKFontStyleTextBaseEmphasized;
        self.backgroundView.backgroundColor = BPKColor.skyBlue;
        self.contentView.backgroundColor = BPKColor.white;
        self.contentColor = BPKColor.skyBlue;
        self.contentView.layer.borderColor = BPKColor.skyBlue.CGColor;
        [self updateIcon];
        return;
    }

    if (self.annotationView.hasBeenSelected) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundView.backgroundColor = BPKColor.skyBlueTint03;
        self.contentView.backgroundColor = BPKColor.clear;
        self.contentColor = BPKColor.skyBlue;
        self.contentView.layer.borderColor = BPKColor.clear.CGColor;
        [self updateIcon];
        return;
    }

    self.label.fontStyle = BPKFontStyleTextSmEmphasized;
    self.backgroundView.backgroundColor = BPKColor.skyBlue;
    self.contentView.backgroundColor = BPKColor.clear;
    self.contentColor = BPKColor.white;
    self.contentView.layer.borderColor = BPKColor.clear.CGColor;

    [self updateIcon];
}

-(void)updateIcon {
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

- (void)setupAppearance {
    self.userInteractionEnabled = NO;
    self.contentView.layer.borderWidth = BPKBorderWidthLg;

    [BPKShadow.shadowSm applyToLayer:self.layer];

    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.spacing = self.paddingSize;
    stackView.alignment = UIStackViewAlignmentCenter;

    BPKIconView *iconView = [[BPKIconView alloc] initWithIconName:nil size:BPKIconSizeSmall];

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBaseEmphasized];

    // Ensures that the icon will remain visible even if the label has to shrink
    [label setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    [self.contentView addSubview:stackView];
    [stackView addArrangedSubview:iconView];
    [stackView addArrangedSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:self.paddingSize],
        [self.contentView.trailingAnchor constraintEqualToAnchor:stackView.trailingAnchor constant:self.paddingSize],
        [stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:self.paddingSize],
        [self.contentView.bottomAnchor constraintEqualToAnchor:stackView.bottomAnchor constant:self.paddingSize],
        [self.widthAnchor constraintLessThanOrEqualToConstant:self.maximumWidth]
    ]];
    self.stackView = stackView;
    self.label = label;
    self.iconView = iconView;

    self.cornerRadius = BPKSpacingSm;
    [self updateStyle];
}

- (CGSize)intrinsicContentSize {
    CGSize size = self.label.intrinsicContentSize;
    if (!self.iconView.hidden) {
        size.width += self.iconView.intrinsicContentSize.width + self.paddingSize;
    }
    size.height += self.paddingSize * 2 + self.flareHeight;
    size.width += self.paddingSize * 2;
    if (size.width > self.maximumWidth) {
        size.width = self.maximumWidth;
    }
    return size;
}

- (CGFloat)paddingSize {
    return BPKSpacingSm;
}

- (CGFloat)maximumWidth {
    return BPKSpacingXxl * 5;
}

@end
NS_ASSUME_NONNULL_END
