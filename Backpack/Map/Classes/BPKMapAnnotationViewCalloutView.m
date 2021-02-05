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

#import <Backpack/BorderWidth.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Label.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationViewCalloutView ()
@property(nonatomic, strong) BPKLabel *label;

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

-(void)updateStyle {
    if(!self.annotationView.enabled) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundView.backgroundColor = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint03];
        self.contentView.backgroundColor = BPKColor.clear;
        self.label.textColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint05];
        self.contentView.layer.borderColor = BPKColor.clear.CGColor;
        return;
    }

    if(self.annotationView.selected) {
        self.label.fontStyle = BPKFontStyleTextBaseEmphasized;
        self.backgroundView.backgroundColor = BPKColor.skyBlue;
        self.contentView.backgroundColor = BPKColor.white;
        self.label.textColor = BPKColor.skyBlue;
        self.contentView.layer.borderColor = BPKColor.skyBlue.CGColor;
        return;
    }

    if (self.annotationView.hasBeenSelected) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundView.backgroundColor = BPKColor.skyBlueTint03;
        self.contentView.backgroundColor = BPKColor.clear;
        self.label.textColor = BPKColor.skyBlue;
        self.contentView.layer.borderColor = BPKColor.clear.CGColor;
        return;
    }

    self.label.fontStyle = BPKFontStyleTextSmEmphasized;
    self.backgroundView.backgroundColor = BPKColor.skyBlue;
    self.contentView.backgroundColor = BPKColor.clear;
    self.label.textColor = BPKColor.white;
    self.contentView.layer.borderColor = BPKColor.clear.CGColor;
}

- (void)setupAppearance {
    self.contentView.layer.borderWidth = BPKBorderWidthLg;
    self.layer.masksToBounds = NO;
    [BPKShadow.shadowSm applyToLayer:self.layer];

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBaseEmphasized];
    label.numberOfLines = 0;
    [self.contentView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:BPKSpacingMd],
        [self.contentView.trailingAnchor constraintEqualToAnchor:label.trailingAnchor constant:BPKSpacingMd],
        [label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:BPKSpacingSm],
        [self.contentView.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:BPKSpacingSm],
        [self.widthAnchor constraintLessThanOrEqualToConstant:BPKSpacingXxl * 5]
    ]];
    self.label = label;

    self.cornerRadius = BPKSpacingSm;
    [self updateStyle];
}

@end
NS_ASSUME_NONNULL_END
