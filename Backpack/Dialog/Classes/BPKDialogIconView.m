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
#import "BPKDialogIconView.h"

#import <Backpack/Color.h>
#import <Backpack/Radii.h>
#import <Backpack/Spacing.h>


NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogIconView ()
@property(nonatomic, strong) UIView *iconContainerView;
@property(nonatomic, strong) UIImageView *iconImageView;

- (void)setupViews;

+ (CGSize)iconContainerSize;
@end

@implementation BPKDialogIconView

- (instancetype)init {
    CGSize size = [[self class] viewSize];
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];

    if (self) {
        [self setupViews];
    }

    return self;
}

- (CGSize)intrinsicContentSize {
    return [[self class] viewSize];
}

- (void)setIconBackgroundColor:(UIColor *_Nullable)iconBackgroundColor {
    self.iconContainerView.backgroundColor = iconBackgroundColor;
}

- (UIColor *_Nullable)iconBackgroundColor {
    return self.iconContainerView.backgroundColor;
}

- (void)setIconImage:(UIImage *_Nullable)iconImage {
    self.iconImageView.image = iconImage;
}

- (UIImage *_Nullable)iconImage {
    return self.iconImageView.image;
}

#pragma mark - Private

- (void)setupViews {
    CGSize viewSize = [[self class] viewSize];

    self.layer.cornerRadius = viewSize.height / 2.0;
    self.backgroundColor = BPKColor.white;

    CGSize iconContainerSize = [[self class] iconContainerSize];
    self.iconContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, iconContainerSize.width, iconContainerSize.height)];
    self.iconContainerView.layer.cornerRadius = iconContainerSize.width / 2.0;
    self.iconContainerView.backgroundColor = BPKColor.gray300;

    self.iconImageView = [[UIImageView alloc] init];
    self.iconImageView.tintColor = BPKColor.white;

    [self addSubview:self.iconContainerView];
    [self.iconContainerView addSubview:self.iconImageView];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
                                              // Icon Container
                                              [self.iconContainerView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor],
                                              [self.iconContainerView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor],
                                              [self.iconContainerView.widthAnchor constraintEqualToConstant:iconContainerSize.width],
                                              [self.iconContainerView.heightAnchor constraintEqualToConstant:iconContainerSize.height],

                                              // Icon
                                              [self.iconImageView.centerXAnchor constraintEqualToAnchor:self.iconContainerView.centerXAnchor],
                                              [self.iconImageView.centerYAnchor constraintEqualToAnchor:self.iconContainerView.centerYAnchor],
                                              ]];
}

+ (CGSize)viewSize {
    return CGSizeMake(BPKSpacingSm * 18, BPKSpacingSm * 18);
}

+ (CGSize)iconContainerSize {
    CGSize outerSize = [self viewSize];
    CGFloat padding = 2 * BPKSpacingSm;

    return CGSizeMake(outerSize.width - padding, outerSize.height - padding);
}

@end
NS_ASSUME_NONNULL_END
