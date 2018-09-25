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
#import "BPKCard.h"

#import <Backpack/Spacing.h>
#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>

NS_ASSUME_NONNULL_BEGIN
const BOOL BPKCardDefaultPaddedValue = YES;

@interface BPKCard()

- (void)setupWithPadded:(BOOL)padded;
@end


@implementation BPKCard

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setupWithPadded:BPKCardDefaultPaddedValue];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupWithPadded:BPKCardDefaultPaddedValue];
    }
    
    return self;
}

- (instancetype)initWithPadded:(BOOL)padded {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self setupWithPadded:padded];
    }
    
    return self;
}

- (void)setPadded:(BOOL)padded {
    if (padded) {
        self.layoutMargins = UIEdgeInsetsMake(BPKSpacingBase, BPKSpacingBase, BPKSpacingBase, BPKSpacingBase);
    } else {
        self.layoutMargins = UIEdgeInsetsZero;
    }
    
    _padded = padded;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    BPKShadow *shadow = selected ? [BPKShadow shadowLg] : [BPKShadow shadowSm];
    [shadow applyToLayer:self.layer];
}

- (CGSize)intrinsicContentSize {
    if(self.subviews.count < 1) {
        return CGSizeMake(BPKSpacingXxl, BPKSpacingXxl);
    }
    return CGSizeMake(UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric);
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    self.backgroundColor = highlighted ? BPKColor.gray100 : BPKColor.white;
}

- (void)addSubview:(UIView *)view {
    NSAssert(self.subviews.count == 0, @"BPKCard can only have a single subview");
    if (self.subviews.count > 0) {
        return;
    }
    [super addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [view.leadingAnchor constraintEqualToAnchor:self.layoutMarginsGuide.leadingAnchor],
                                              [view.topAnchor constraintEqualToAnchor:self.layoutMarginsGuide.topAnchor],
                                              [self.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:view.trailingAnchor],
                                              [self.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:view.bottomAnchor]
                                              ]];
}

#pragma mark - Private

- (void)setupWithPadded:(BOOL)padded {
    self.padded = padded;
    self.backgroundColor = [BPKColor white];
    self.layer.cornerRadius = BPKBorderRadiusSm;
    self.layer.masksToBounds = NO;
    [[BPKShadow shadowSm] applyToLayer:self.layer];
}

@end
NS_ASSUME_NONNULL_END
