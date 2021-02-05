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
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKMapAnnotationViewCalloutView ()
@property(nonatomic, strong) BPKLabel *label;
@property(nonatomic, strong) CAShapeLayer *borderLayer;

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

- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateBorderPath];
}

-(void)updateStyle {
    if(!self.annotationView.enabled) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundColor = [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.blackTint03];
        self.label.textColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint04 darkVariant:BPKColor.blackTint05];
        self.borderLayer.strokeColor = BPKColor.clear.CGColor;
        return;
    }

    if(self.annotationView.selected) {
        self.label.fontStyle = BPKFontStyleTextBaseEmphasized;
        self.backgroundColor = BPKColor.white;
        self.label.textColor = BPKColor.skyBlue;
        self.borderLayer.strokeColor = BPKColor.skyBlue.CGColor;
        return;
    }

    if (self.annotationView.hasBeenSelected) {
        self.label.fontStyle = BPKFontStyleTextSmEmphasized;
        self.backgroundColor = BPKColor.skyBlueTint03;
        self.label.textColor = BPKColor.skyBlue;
        self.borderLayer.strokeColor = BPKColor.clear.CGColor;
        return;
    }

    self.label.fontStyle = BPKFontStyleTextSmEmphasized;
    self.backgroundColor = BPKColor.skyBlue;
    self.label.textColor = BPKColor.white;
    self.borderLayer.strokeColor = BPKColor.clear.CGColor;
}

-(void)updateBorderPath {
    UIBezierPath *linePath = [BPKFlarePath flareViewPathForSize:self.frame.size flareHeight:self.flareHeight cornerRadius:BPKSpacingSm flarePosition:BPKFlarePositionBottom];
    self.borderLayer.lineWidth = BPKBorderWidthLg;
    self.borderLayer.path = linePath.CGPath;
    self.borderLayer.fillColor = BPKColor.clear.CGColor;
}

- (void)setupAppearance {
    self.borderLayer = [CAShapeLayer layer];
    [self.backgroundView.layer addSublayer:self.borderLayer];

    BPKLabel *label = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBaseEmphasized];
    [self.contentView addSubview:label];
    label.translatesAutoresizingMaskIntoConstraints = NO;

    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:BPKSpacingMd],
        [self.contentView.trailingAnchor constraintEqualToAnchor:label.trailingAnchor constant:BPKSpacingMd],
        [label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:BPKSpacingSm],
        [self.contentView.bottomAnchor constraintEqualToAnchor:label.bottomAnchor constant:BPKSpacingSm]
    ]];
    self.label = label;

    self.cornerRadius = BPKSpacingSm;
    [self updateStyle];
}

@end
NS_ASSUME_NONNULL_END
