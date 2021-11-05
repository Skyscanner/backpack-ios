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

#import "BPKDialogContentView.h"

#import <Backpack/Button.h>
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKActionButtonPair : NSObject
@property(nonatomic, strong) BPKDialogButtonAction *action;
@property(nonatomic, weak) BPKButton *button;
@property(readonly, nonatomic) BOOL hasIcon;
@property(readonly, nonatomic) BOOL hasFlareView;
@end

@implementation BPKActionButtonPair
@end

@interface BPKDialogContentView ()

@property(nonatomic, strong, nullable) BPKLabel *titleLabel;
@property(nonatomic, strong) BPKLabel *descriptionLabel;
@property(nonatomic, strong) UIStackView *buttonStackView;

@property(nonatomic, strong) NSMutableArray<BPKActionButtonPair *> *registeredActions;
@property(nonatomic, strong) NSLayoutConstraint *descriptionLabelTopConstraint;
@property(nonatomic, strong) NSLayoutConstraint *titleLabelTopConstraint;
@property(nullable, nonatomic, strong) NSLayoutConstraint *contentViewTopConstraint;
@property(nonatomic, strong) UIColor *dialogContentViewBackgroundColor;
@end

@implementation BPKDialogContentView

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];

    if (self) {
        self.registeredActions = [NSMutableArray new];
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
        self.registeredActions = [NSMutableArray new];
        self.buttonSize = BPKButtonSizeLarge;

        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }

    return self;
}

- (void)setupViews {
    self.backgroundColor = self.dialogContentViewBackgroundColor;

    self.titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextXlEmphasized];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.textColor = BPKColor.textPrimaryColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.accessibilityTraits = UIAccessibilityTraitHeader;

    self.descriptionLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBase];
    self.descriptionLabel.numberOfLines = 0;
    self.descriptionLabel.minimumScaleFactor = 0.7;
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.adjustsFontSizeToFitWidth = YES;
    [self.descriptionLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];

    self.buttonStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    self.buttonStackView.axis = UILayoutConstraintAxisVertical;
    self.buttonStackView.spacing = BPKSpacingMd;

    self.buttonStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)addViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.descriptionLabel];
    [self addSubview:self.buttonStackView];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],

        [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BPKSpacingBase],
        [self.descriptionLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.descriptionLabel.trailingAnchor],

        [self.buttonStackView.topAnchor constraintEqualToAnchor:self.descriptionLabel.bottomAnchor constant:BPKSpacingLg],
        [self.buttonStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingMd],
        [self.trailingAnchor constraintEqualToAnchor:self.buttonStackView.trailingAnchor constant:BPKSpacingMd],
        [self.bottomAnchor constraintEqualToAnchor:self.buttonStackView.bottomAnchor]
    ]];
}

- (void)buttonTapped:(BPKButton *)button {
    BPKDialogButtonAction *action = [self actionForButton:button];
    if (action) {
        [self.delegate didInvokeButtonAction:action];
    }
}

- (BPKDialogButtonAction *_Nullable)actionForButton:(BPKButton *)button {
    for (BPKActionButtonPair *pair in self.registeredActions) {
        if (pair.button == button) {
            return pair.action;
        }
    }

    return nil;
}

#pragma mark - Public

#pragma mark - Property overrides

- (void)setButtonSize:(BPKButtonSize)buttonSize {
    if (_buttonSize != buttonSize) {
        _buttonSize = buttonSize;

        for (BPKActionButtonPair *buttonActionPair in self.registeredActions) {
            buttonActionPair.button.size = buttonSize;
        }
    }
}

- (void)setTitle:(NSString *_Nullable)title {
    BPKAssertMainThread();
    self.titleLabel.text = title;
}

- (NSString *_Nullable)title {
    return self.titleLabel.text;
}

- (void)setMessage:(NSString *_Nullable)description {
    BPKAssertMainThread();
    self.descriptionLabel.text = description;
}

- (NSString *_Nullable)message {
    return self.descriptionLabel.text;
}

- (BOOL)hasButtonActions {
    return self.registeredActions.count > 0;
}

#pragma mark - Other public methods

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    BPKAssertMainThread();
    BPKButton *button = [[BPKButton alloc] initWithSize:self.buttonSize style:action.style];
    [button setTitle:action.title];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonStackView addArrangedSubview:button];

    BPKActionButtonPair *pair = [[BPKActionButtonPair alloc] init];
    pair.button = button;
    pair.action = action;
    [self.registeredActions addObject:pair];
}

#pragma mark - Private methods

- (BOOL)hasTitle {
    return (self.titleLabel.text != nil && ![self.titleLabel.text isEqualToString:@""]);
}

#pragma mark - Dynamic colors
- (UIColor *)dialogContentViewBackgroundColor {
    return [BPKColor dynamicColorWithLightVariant:BPKColor.white darkVariant:BPKColor.backgroundSecondaryDarkColor];
}

@end
NS_ASSUME_NONNULL_END
