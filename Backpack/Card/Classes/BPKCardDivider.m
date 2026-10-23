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

#import "BPKCardDivider.h"

#import <Backpack/Color.h>
#import <Backpack/DarkMode.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKCardDivider ()
@property(strong, nonatomic) CAShapeLayer *dottedLine;
@end

@implementation BPKCardDivider

- (instancetype)initWithOrientation:(UILayoutConstraintAxis)orientation {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.orientation = orientation;
        self.lineStyle = BPKCardDividerDefaultLineStyle;
        [self setupViews];
    }

    return self;
}

- (instancetype)initWithOrientation:(UILayoutConstraintAxis)orientation lineStyle:(BPKCardDividerLineStyle)lineStyle {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.orientation = orientation;
        self.lineStyle = lineStyle;
        [self setupViews];
    }

    return self;
}

- (void)setLineStyle:(BPKCardDividerLineStyle)lineStyle {
    _lineStyle = lineStyle;
    self.dottedLine.lineDashPattern = lineStyle == BPKCardDividerLineDotted ? @[@5, @3] : nil;
}

- (void)setupViews {
    self.dottedLine = [[CAShapeLayer alloc] initWithLayer:self];
    self.dottedLine.lineWidth = 1;
    self.dottedLine.fillColor = nil;

    if (_lineStyle == BPKCardDividerLineDotted) {
        self.dottedLine.lineDashPattern = @[@5, @3];
    }
    [self.layer addSublayer:self.dottedLine];
    [self updateLineColor];
}

#pragma mark - Private

- (void)updateLineColor {
    self.dottedLine.strokeColor = BPKColor.lineColor.CGColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    double lineSize = self.orientation == UILayoutConstraintAxisVertical ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    CGPathAddLineToPoint(path, NULL, self.orientation == UILayoutConstraintAxisVertical ? lineSize : 0,
                         self.orientation == UILayoutConstraintAxisVertical ? 0 : lineSize);

    [self.dottedLine setPath:path];
    CGPathRelease(path);
}

// Note this is needed to correctly update the `CGColor` used for the line .
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
#if __BPK_DARK_MODE_SUPPORTED
    if (self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
        [self updateLineColor];
    }
#endif
}

@end
NS_ASSUME_NONNULL_END
