/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import "BPKCalendarPriceLabelCell.h"

#import <Backpack/Spacing.h>

#import "BPKCalendarPriceLabelCellData.h"
#import "BPKCalendarPriceLabelStyle.h"

@implementation BPKCalendarPriceLabelCell

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _priceLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextSm];
    [self.contentView addSubview:self.priceLabel];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    [NSLayoutConstraint activateConstraints:@[
        [self.priceLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BPKSpacingSm / 2.0],
        [self.priceLabel.centerXAnchor constraintEqualToAnchor:self.titleLabel.centerXAnchor],
        [self.priceLabel.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor constant:-BPKSpacingMd]
    ]];
}

- (void)configureWithData:(id _Nullable)data {
    if (data == nil) {
        self.priceLabel.text = nil;
        return;
    }

    BPKCalendarPriceLabelCellData *priceLabelCellData = (BPKCalendarPriceLabelCellData *)data;
    self.priceLabel.text = priceLabelCellData.price;
    self.priceLabel.textColor = priceLabelCellData.labelStyle.color;
    self.priceLabel.fontStyle = priceLabelCellData.labelStyle.bold ? BPKFontStyleTextSmEmphasized : BPKFontStyleTextSm;
}

@end
