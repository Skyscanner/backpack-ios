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

#import "BPKDividedCard.h"

#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

#import "BPKCardDivider.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKDividedCard ()
@property(strong, nonatomic) UIStackView *contentView;
@property(strong, nonatomic) BPKCardDivider *lineView;
@end

@implementation BPKDividedCard

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupViewsWithPadded:NO];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setupViewsWithPadded:NO];
    }

    return self;
}

- (instancetype)initWithPadded:(BOOL)padded {
    return [self initWithPrimarySubview:nil secondarySubview:nil padded:padded];
}

- (instancetype)initWithPadded:(BOOL)padded cornerStyle:(BPKCardCornerStyle)cornerStyle {
    return [self initWithPrimarySubview:nil secondarySubview:nil padded:padded cornerStyle:cornerStyle];
}

- (instancetype)initWithPrimarySubview:(UIView *_Nullable)primarySubview secondarySubview:(UIView *_Nullable)secondarySubview padded:(BOOL)padded {
    return [self initWithPrimarySubview:primarySubview
                       secondarySubview:secondarySubview
                                 padded:padded
                            cornerStyle:BPKCardDefaultCornerStyle
                              lineStyle:BPKCardDividerDefaultLineStyle];
}

- (instancetype)initWithPrimarySubview:(UIView *_Nullable)primarySubview
                      secondarySubview:(UIView *_Nullable)secondarySubview
                                padded:(BOOL)padded
                           cornerStyle:(BPKCardCornerStyle)cornerStyle {
    return [self initWithPrimarySubview:primarySubview
                       secondarySubview:secondarySubview
                                 padded:padded
                            cornerStyle:BPKCardDefaultCornerStyle
                              lineStyle:BPKCardDividerDefaultLineStyle];
}

- (instancetype)initWithPrimarySubview:(UIView *_Nullable)primarySubview
                      secondarySubview:(UIView *_Nullable)secondarySubview
                                padded:(BOOL)padded
                           cornerStyle:(BPKCardCornerStyle)cornerStyle
                             lineStyle:(BPKCardDividerLineStyle)lineStyle {
    self = [super initWithPadded:padded cornerStyle:cornerStyle];

    if (self) {
        self.primarySubview = primarySubview;
        self.secondarySubview = secondarySubview;
        self.lineStyle = lineStyle;
        [self setupViewsWithPadded:padded];
    }

    return self;
}

- (void)setPadded:(BOOL)padded {
    [super setPadded:padded];
    self.contentView.spacing = padded ? BPKSpacingBase : 0;
}

- (void)setOrientation:(UILayoutConstraintAxis)orientation {
    _orientation = orientation;
    self.lineView.orientation = orientation;
    self.contentView.axis = orientation;
}

- (void)setPrimarySubview:(UIView *)primarySubview secondarySubview:(UIView *)secondarySubview {
    if (self.primarySubview != nil) {
        [self.contentView removeArrangedSubview:self.primarySubview];
    }
    if (self.secondarySubview != nil) {
        [self.contentView removeArrangedSubview:self.secondarySubview];
    }

    self.primarySubview = primarySubview;
    self.secondarySubview = secondarySubview;

    [self.contentView insertArrangedSubview:self.primarySubview atIndex:0];
    [self.contentView insertArrangedSubview:self.secondarySubview atIndex:2];
}

- (void)setLineStyle:(BPKCardDividerLineStyle)lineStyle {
    _lineStyle = lineStyle;
    self.lineView.lineStyle = lineStyle;
}

#pragma mark - Private

- (void)setupViewsWithPadded:(BOOL)padded {
    self.contentView = [[UIStackView alloc] initWithFrame:CGRectZero];
    [self.contentView setUserInteractionEnabled:false];
    self.contentView.distribution = UIStackViewDistributionFillProportionally;
    self.contentView.alignment = UIStackViewAlignmentFill;
    self.padded = padded;

    self.lineView = [[BPKCardDivider alloc] initWithOrientation:self.orientation lineStyle:self.lineStyle];

    if (self.primarySubview != nil) {
        [self.contentView addArrangedSubview:self.primarySubview];
    }
    [self.contentView addArrangedSubview:self.lineView];
    if (self.secondarySubview != nil) {
        [self.contentView addArrangedSubview:self.secondarySubview];
    }

    [super setSubview:(self.contentView)];
}

@end
NS_ASSUME_NONNULL_END
