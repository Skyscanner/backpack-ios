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

#import "BPKDialogIconView.h"

#import <Backpack/Label.h>
#import <Backpack/Spacing.h>
#import <Backpack/Shadow.h>
#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Radii.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKActionButtonPair : NSObject
@property(nonatomic, strong) BPKDialogButtonAction *action;
@property(nonatomic, weak) BPKButton *button;
@end

@implementation BPKActionButtonPair
@end


@interface BPKDialogView()

@property(nonatomic, strong) BPKDialogIconView *iconView;

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) BPKLabel *titleLabel;
@property(nonatomic, strong) BPKLabel *descriptionLabel;
@property(nonatomic, strong) UIStackView *buttonStackView;

@property(nonatomic, strong) NSMutableArray<BPKActionButtonPair *> *registeredActions;
@end

@implementation BPKDialogView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        self.registeredActions = [NSMutableArray new];

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }

    return self;
}

- (void)setupViews {
    self.contentView = [UIView new];
    self.contentView.backgroundColor = BPKColor.white;
    self.contentView.layer.cornerRadius = BPKBorderRadiusSm;

    self.iconView = [BPKDialogIconView new];

    self.titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextXlEmphasized];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    self.descriptionLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextLg];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    self.buttonStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.buttonStackView.axis = UILayoutConstraintAxisVertical;
    self.buttonStackView.spacing = BPKSpacingMd;
    
    self.buttonStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)addViews {
    [self addSubview:self.contentView];
    [self addSubview:self.iconView];

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.buttonStackView];
}

- (void)setupConstraints {
    CGSize iconViewSize = [[self.iconView class] viewSize];
    self.contentView.layoutMargins = UIEdgeInsetsMake(self.contentView.layoutMargins.top, BPKSpacingLg, self.contentView.layoutMargins.bottom, BPKSpacingLg);

    [NSLayoutConstraint activateConstraints:@[
                                              [self.iconView.topAnchor constraintEqualToAnchor:self.iconView.superview.topAnchor],
                                              [self.iconView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],

                                              [self.contentView.topAnchor constraintEqualToAnchor:self.iconView.bottomAnchor constant:-(iconViewSize.height / 2.0)],
                                              [self.contentView.superview.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
                                              [self.contentView.leadingAnchor constraintEqualToAnchor:self.contentView.superview.leadingAnchor],
                                              [self.contentView.trailingAnchor constraintEqualToAnchor:self.contentView.superview.trailingAnchor],
                                              
                                              [self.titleLabel.topAnchor constraintEqualToAnchor:self.iconView.bottomAnchor constant:BPKSpacingBase],
                                              [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.titleLabel.superview.centerXAnchor],
                                              [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.titleLabel.superview.layoutMarginsGuide.leadingAnchor],
                                              [self.titleLabel.superview.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor],
                                              
                                              [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BPKSpacingMd],
                                              [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.descriptionLabel.superview.layoutMarginsGuide.leadingAnchor],
                                              [self.descriptionLabel.superview.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.descriptionLabel.trailingAnchor],
                                              
                                              [self.buttonStackView.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor constant:BPKSpacingBase],
                                              [self.buttonStackView.leadingAnchor constraintEqualToAnchor:self.buttonStackView.superview.layoutMarginsGuide.leadingAnchor constant:(BPKSpacingXl - BPKSpacingLg)],
                                              [self.buttonStackView.superview.layoutMarginsGuide.trailingAnchor constraintEqualToAnchor:self.buttonStackView.trailingAnchor constant:(BPKSpacingXl - BPKSpacingLg)],
                                              [self.buttonStackView.superview.layoutMarginsGuide.bottomAnchor constraintEqualToAnchor:self.buttonStackView.bottomAnchor]
                                              ]];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.hasShadow) {
        [[BPKShadow shadowLg] applyToLayer:self.layer];
    } else {
        [self.layer setShadowOpacity:0];
    }
}

-(void)setHasShadow:(BOOL)hasShadow {
    _hasShadow = hasShadow;
    [self setNeedsLayout];
}

- (void)buttonTapped:(BPKButton *)button {
    BPKDialogButtonAction *action = [self actionForButton:button];
    if (action) {
        [self.delegate didInvokeButtonAction:action];
    }
}

- (BPKDialogButtonAction * _Nullable)actionForButton:(BPKButton *)button {
    for (BPKActionButtonPair *pair in self.registeredActions) {
        if (pair.button == button) {
            return pair.action;
        }
    }

    return nil;
}

#pragma mark - Public


#pragma mark - Property overrides

- (void)setIconBackgroundColor:(UIColor *_Nullable)iconBackgroundColor {
    self.iconView.iconBackgroundColor = iconBackgroundColor;
}

- (UIColor *_Nullable)iconBackgroundColor {
    return self.iconView.iconBackgroundColor;
}

- (void)setIconImage:(UIImage *_Nullable)iconImage {
    self.iconView.iconImage = iconImage;
}

- (UIImage *_Nullable)iconImage {
    return self.iconView.iconImage;
}

- (void)setTitle:(NSString *_Nullable)title {
    self.titleLabel.text = title;
}

- (NSString *_Nullable)title {
    return self.titleLabel.text;
}


- (void)setDescription:(NSString *_Nullable)description {
    self.descriptionLabel.text = description;
}

- (NSString *_Nullable)description {
    return self.descriptionLabel.text;
}

#pragma mark - Other public methods

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeLarge style:action.style];
    [button setTitle:action.title];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStackView addArrangedSubview:button];


    BPKActionButtonPair *pair = [[BPKActionButtonPair alloc] init];
    pair.button = button;
    pair.action = action;
    [self.registeredActions addObject:pair];
}

@end
NS_ASSUME_NONNULL_END
