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

#import "BPKDialogView.h"

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Label.h>
#import <Backpack/Radii.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

#import "BPKDialogContentView.h"
#import "BPKDialogIconDefinition.h"
#import "BPKDialogIconView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogView ()

@property(nonatomic, strong, nullable) BPKDialogIconView *iconView;
@property(nullable, nonatomic, strong) UIView *graphicView;

@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) BPKDialogContentView *contentView;

@property(nullable, nonatomic, strong) NSLayoutConstraint *contentViewTopConstraint;
@property(nullable, nonatomic, strong) NSLayoutConstraint *backgroundViewTopConstraint;
@property(nonatomic, strong) UIColor *dialogContentViewBackgroundColor;
@end

@implementation BPKDialogView

- (instancetype)initWithTitle:(NSString *_Nullable)title
                      message:(NSString *)message
               iconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition
                  graphicView:(UIView *_Nullable)graphicView
                textAlignment:(NSTextAlignment)textAlignment {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.graphicView = graphicView;

        [self setupViews];
        [self addViews];
        [self setupConstraints];

        self.contentView.title = title;
        self.contentView.message = message;
        self.contentView.textAlignment = textAlignment;
        self.iconDefinition = iconDefinition;
        self.buttonSize = BPKButtonSizeLarge;
    }

    return self;
}

- (BOOL)hasIcon {
    return self.iconDefinition != nil;
}

- (BOOL)hasGraphicView {
    return self.graphicView != nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        self.buttonSize = BPKButtonSizeLarge;

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        self.buttonSize = BPKButtonSizeLarge;

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }

    return self;
}

- (void)setupViews {
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.backgroundView.backgroundColor = self.dialogContentViewBackgroundColor;
    self.backgroundView.layer.cornerRadius = BPKCornerRadiusMd;
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.clipsToBounds = YES;

    self.contentView = [[BPKDialogContentView alloc] initWithFrame:CGRectZero];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.clipsToBounds = NO;
    [self.contentView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
}

- (void)addViews {
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.contentView];

    if (self.hasGraphicView) {
        self.graphicView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.backgroundView addSubview:self.graphicView];
    }
}

- (void)setLayoutMargins {
    CGFloat topMargin = BPKSpacingBase;
    if (self.hasIcon) {
        CGSize iconViewSize = [[self.iconView class] viewSize];
        topMargin = iconViewSize.height / 2 + BPKSpacingBase;
    } else if (self.hasGraphicView) {
        topMargin = 0.0;
    }

    self.backgroundView.layoutMargins = UIEdgeInsetsMake(topMargin, BPKSpacingLg, BPKSpacingLg, BPKSpacingLg);
}

- (void)setupConstraints {
    [self setLayoutMargins];

    if (self.hasGraphicView) {
        [self setupGraphicViewConstraints];
    }

    if (self.hasIcon) {
        CGSize iconViewSize = [[self.iconView class] viewSize];
        self.backgroundViewTopConstraint = [self.backgroundView.topAnchor constraintEqualToAnchor:self.iconView.bottomAnchor
                                                                                         constant:-(iconViewSize.height / 2.0)];
    } else {
        self.backgroundViewTopConstraint = [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor];
    }

    if (self.hasGraphicView) {
        self.contentViewTopConstraint = [self.contentView.topAnchor constraintEqualToAnchor:self.graphicView.bottomAnchor constant:BPKSpacingBase];
    } else {
        self.contentViewTopConstraint = [self.contentView.topAnchor constraintEqualToAnchor:self.backgroundView.layoutMarginsGuide.topAnchor];
    }

    [NSLayoutConstraint activateConstraints:@[
        self.backgroundViewTopConstraint,
        [self.backgroundView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.backgroundView.trailingAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.backgroundView.bottomAnchor],

        self.contentViewTopConstraint,
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.backgroundView.layoutMarginsGuide.leadingAnchor],
        [self.backgroundView.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.backgroundView.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
    ]];
}

- (void)updateIconView {
    if (self.hasIcon && self.iconView == nil) {
        self.iconView = [[BPKDialogIconView alloc] initWithIconDefinition:self.iconDefinition];
        self.iconView.backgroundColor = self.dialogContentViewBackgroundColor;
        [self addSubview:self.iconView];

        // Remove previous top constraint
        self.backgroundViewTopConstraint.active = NO;
        self.backgroundViewTopConstraint = nil;

        CGSize iconViewSize = [[self.iconView class] viewSize];
        self.backgroundViewTopConstraint = [self.backgroundView.topAnchor constraintEqualToAnchor:self.iconView.bottomAnchor
                                                                                         constant:-(iconViewSize.height / 2.0)];
        [NSLayoutConstraint activateConstraints:@[
            [self.iconView.topAnchor constraintEqualToAnchor:self.iconView.superview.topAnchor],
            [self.iconView.centerXAnchor constraintEqualToAnchor:self.backgroundView.centerXAnchor],
            self.backgroundViewTopConstraint,
        ]];

        [self setLayoutMargins];
    } else if (!self.hasIcon && self.iconView != nil) {
        [self.iconView removeFromSuperview];
        _iconView = nil;
        self.backgroundViewTopConstraint.active = NO;
        self.backgroundViewTopConstraint = [self.backgroundView.topAnchor constraintEqualToAnchor:self.topAnchor];
        self.backgroundViewTopConstraint.active = YES;
    }

    if (self.iconDefinition && self.iconView != nil) {
        self.iconView.iconDefinition = self.iconDefinition;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // Calculated path including circular icon view
    CGRect layerRect = self.contentView.layer.frame;
    CGMutablePathRef shadowPath = CGPathCreateMutable();
    CGPathAddRoundedRect(shadowPath, nil, layerRect, self.contentView.layer.cornerRadius, self.contentView.layer.cornerRadius);
    if (self.hasIcon) {
        CGRect iconViewRect = self.iconView.layer.frame;
        CGPathAddRoundedRect(shadowPath, nil, iconViewRect, iconViewRect.size.width / 2.0, iconViewRect.size.height / 2.0);
    }

    [[BPKShadow shadowLg] applyToLayer:self.layer];
    CGPathRef finalPath = CGPathCreateCopy(shadowPath);
    self.layer.shadowPath = finalPath;

    CGPathRelease(finalPath);
    CGPathRelease(shadowPath);
}

#pragma mark - Public

#pragma mark - Property overrides

- (void)setDelegate:(_Nullable id<BPKDialogViewDelegate>)delegate {
    self.contentView.delegate = delegate;
}

- (nullable id<BPKDialogViewDelegate>)delegate {
    return self.contentView.delegate;
}

- (void)setButtonSize:(BPKButtonSize)buttonSize {
    self.contentView.buttonSize = buttonSize;
}

- (void)setCornerStyle:(BPKDialogCornerStyle)cornerStyle {
    if (_cornerStyle != cornerStyle) {
        _cornerStyle = cornerStyle;

        self.backgroundView.layer.cornerRadius = cornerStyle == BPKDialogCornerStyleLarge ? BPKCornerRadiusLg : BPKCornerRadiusMd;
    }
}

- (void)setIconDefinition:(BPKDialogIconDefinition *_Nullable)iconDefinition {
    BPKAssertMainThread();
    if (iconDefinition != _iconDefinition) {
        // Can't show an icon and a flare view:
        _iconDefinition = self.graphicView == nil ? iconDefinition : nil;
        [self updateIconView];
        [self setLayoutMargins];
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    self.contentView.title = title;
}

- (NSString *_Nullable)title {
    return self.contentView.title;
}

- (void)setMessage:(NSString *_Nullable)description {
    BPKAssertMainThread();
    self.contentView.message = description;
}

- (NSString *_Nullable)message {
    return self.contentView.description;
}

#pragma mark - Other public methods

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    BPKAssertMainThread();
    [self.contentView addButtonAction:action];
    [self setLayoutMargins];
}

#pragma mark - Private methods

- (void)setupGraphicViewConstraints {
    NSLayoutConstraint *graphicViewDesiredHeight = [self.graphicView.heightAnchor constraintEqualToConstant:300];
    // Shrink height of flare before shrinking content
    graphicViewDesiredHeight.priority = UILayoutPriorityDefaultLow - 1;

    [NSLayoutConstraint activateConstraints:@[
        [self.graphicView.topAnchor constraintEqualToAnchor:self.backgroundView.topAnchor],
        [self.graphicView.trailingAnchor constraintEqualToAnchor:self.backgroundView.trailingAnchor],
        [self.graphicView.leadingAnchor constraintEqualToAnchor:self.backgroundView.leadingAnchor],
        [self.graphicView.heightAnchor constraintGreaterThanOrEqualToConstant:150.0],
        [self.graphicView.heightAnchor constraintLessThanOrEqualToConstant:300.0],
        graphicViewDesiredHeight,
    ]];
}

#pragma mark - Dynamic colors
- (UIColor *)dialogContentViewBackgroundColor {
    return [BPKColor surfaceDefaultColor];
}

@end
NS_ASSUME_NONNULL_END
