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

#import "BPKRatingTextWrapper.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKRatingTextWrapper ()
@property(nonatomic) BPKLabel *titleLabel;
@property(nonatomic) BPKLabel *subtitleLabel;
@property(nonatomic) NSArray<NSLayoutConstraint *> *horizontalLayoutConstraints;
@property(nonatomic) NSArray<NSLayoutConstraint *> *horizontalPillLayoutConstraints;
@property(nonatomic) NSArray<NSLayoutConstraint *> *verticalLayoutConstraints;
@end

@implementation BPKRatingTextWrapper

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setUp];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setUp];
    }

    return self;
}

- (void)setUp {
    self.titleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.fontStyle = BPKFontStyleTextHeading5;
    [self addSubview:self.titleLabel];
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];

    self.subtitleLabel = [[BPKLabel alloc] initWithFrame:CGRectZero];
    self.subtitleLabel.fontStyle = BPKFontStyleTextBodyDefault;
    self.subtitleLabel.textColor = [BPKColor dynamicColorWithLightVariant:BPKColor.skyGrayTint01 darkVariant:BPKColor.textSecondaryLightColor];
    [self.subtitleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.subtitleLabel];

    [self setUpConstraints];
    [self updateFontSizes];
}

#pragma mark - State setters

- (void)setTitle:(NSString *)title {
    BPKAssertMainThread();
    _title = [title copy];

    self.titleLabel.text = self.title;
}

- (void)setSubtitle:(NSString *_Nullable)subtitle {
    BPKAssertMainThread();
    _subtitle = [subtitle copy];

    self.subtitleLabel.text = self.subtitle;
}

- (void)setSize:(BPKRatingSize)size {
    BPKAssertMainThread();
    if (_size != size) {
        _size = size;

        [self updateFontSizes];
    }
}

- (void)setLayout:(BPKRatingLayout)layout {
    BPKAssertMainThread();
    if (_layout != layout) {
        _layout = layout;

        [self updateFontSizes];
        [self setNeedsUpdateConstraints];
    }
}

- (void)updateFontSizes {
    CGFloat newTitleFontStyle = BPKFontStyleTextBodyDefault;
    CGFloat newSubtitleFontStyle = BPKFontStyleTextBodyDefault;
    CGFloat newPillSubtitleFontStyle = BPKFontStyleTextBodyDefault;

    switch (self.size) {
    case BPKRatingSizeLarge:
        newTitleFontStyle = BPKFontStyleTextHeading4;
        newPillSubtitleFontStyle = BPKFontStyleTextBodyLongform;
        newSubtitleFontStyle = BPKFontStyleTextBodyDefault;
        break;
    case BPKRatingSizeBase:
        newTitleFontStyle = BPKFontStyleTextHeading5;
        newPillSubtitleFontStyle = BPKFontStyleTextBodyDefault;
        newSubtitleFontStyle = BPKFontStyleTextFootnote;
        break;
    case BPKRatingSizeSmall:
        newTitleFontStyle = BPKFontStyleTextLabel2;
        newPillSubtitleFontStyle = BPKFontStyleTextFootnote;
        newSubtitleFontStyle = BPKFontStyleTextCaption;
        break;
    case BPKRatingSizeExtraSmall:
        newTitleFontStyle = BPKFontStyleTextCaption;
        newPillSubtitleFontStyle = BPKFontStyleTextCaption;
        newSubtitleFontStyle = BPKFontStyleTextCaption;
        break;
    }

    if (self.layout == BPKRatingLayoutHorizontalPill) {
        // Use the same font style otherwise text on the same line will be a different size
        newSubtitleFontStyle = newPillSubtitleFontStyle;
    }

    self.titleLabel.fontStyle = newTitleFontStyle;
    self.subtitleLabel.fontStyle = newSubtitleFontStyle;
}

- (void)updateConstraints {
    [super updateConstraints];

    switch (self.layout) {
    case BPKRatingLayoutHorizontal:
        [NSLayoutConstraint deactivateConstraints:self.horizontalPillLayoutConstraints];
        [NSLayoutConstraint deactivateConstraints:self.verticalLayoutConstraints];
        [NSLayoutConstraint activateConstraints:self.horizontalLayoutConstraints];
        break;
    case BPKRatingLayoutHorizontalPill:
        [NSLayoutConstraint deactivateConstraints:self.verticalLayoutConstraints];
        [NSLayoutConstraint deactivateConstraints:self.horizontalLayoutConstraints];
        [NSLayoutConstraint activateConstraints:self.horizontalPillLayoutConstraints];
        break;
    case BPKRatingLayoutVertical:
        [NSLayoutConstraint deactivateConstraints:self.horizontalLayoutConstraints];
        [NSLayoutConstraint deactivateConstraints:self.horizontalPillLayoutConstraints];
        [NSLayoutConstraint activateConstraints:self.verticalLayoutConstraints];
        break;
    }
}

#pragma mark - Layout

- (void)setUpConstraints {

    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;

    self.horizontalLayoutConstraints = @[
        [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.subtitleLabel.topAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor]
    ];

    self.horizontalPillLayoutConstraints = @[
        [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.subtitleLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:BPKSpacingSm]
    ];

    self.verticalLayoutConstraints = @[
        [self.subtitleLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.subtitleLabel.topAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
        [self.subtitleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ];

    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.trailingAnchor],
        [self.trailingAnchor constraintGreaterThanOrEqualToAnchor:self.subtitleLabel.trailingAnchor],
        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.titleLabel.bottomAnchor],
        [self.bottomAnchor constraintGreaterThanOrEqualToAnchor:self.subtitleLabel.bottomAnchor],
    ]];

    [self setNeedsUpdateConstraints];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
    [super systemLayoutSizeFittingSize:targetSize];
    CGSize titleLabelSize = [self.titleLabel systemLayoutSizeFittingSize:targetSize];
    CGSize subtitleLabelSize = [self.subtitleLabel systemLayoutSizeFittingSize:targetSize];

    CGFloat height = MIN(titleLabelSize.height + subtitleLabelSize.height, targetSize.height);
    CGFloat width = MIN(MAX(titleLabelSize.width, subtitleLabelSize.width), targetSize.width);

    return CGSizeMake(width, height);
}

@end

NS_ASSUME_NONNULL_END
