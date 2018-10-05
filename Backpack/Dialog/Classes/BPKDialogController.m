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

#import "BPKDialogController.h"

#import "BPKDialogButtonAction.h"
#import "BPKDialogScrimAction.h"

#import <Backpack/Color.h>
#import <Backpack/Spacing.h>
#import <Backpack/Font.h>
#import <Backpack/Color.h>
#import <Backpack/Button.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKDialogController()

@property (nonatomic, strong) UIColor *headColor;
@property (nonatomic, strong) UIImage *iconImage;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, assign) BPKDialogControllerShadowStyle shadowStyle;
@property (nonatomic, assign) BPKDialogControllerStyle style;

@property (nonatomic, strong) UIView *scrimView;
@property (nonatomic, strong) BPKDialogView *dialogView;

@property (nonatomic, strong) NSMutableArray<BPKDialogButtonAction *> *buttonActions;
@property (nonatomic, strong) BPKDialogScrimAction *scrimAction;

@end

@implementation BPKDialogController

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                        style:(BPKDialogControllerStyle)style
                  shadowStyle:(BPKDialogControllerShadowStyle)shadowStyle
                    headColor:(UIColor *)headColor
                    iconImage:(UIImage *)iconImage {
    self = [super init];
    if (self) {
        self.titleText = title;
        self.messageText = message;
        self.style = style;
        self.shadowStyle = shadowStyle;
        self.headColor = headColor;
        self.iconImage = iconImage;
        
        self.buttonActions = [NSMutableArray new];
        
        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    return self;
}

+ (instancetype)dialogControllerWithTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                              shadowStyle:(BPKDialogControllerShadowStyle)shadowStyle
                                headColor:(UIColor *)headColor
                                iconImage:(UIImage *)iconImage {
    return [[self alloc] initWithTitle:title message:message style:style shadowStyle:shadowStyle headColor:headColor iconImage:iconImage];
}

- (void)setupViews {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrimTapped:)];
    
    _scrimView = [UIView new];
    _scrimView.clipsToBounds = YES;
    _scrimView.userInteractionEnabled = YES;
    _scrimView.backgroundColor = BPKColor.gray900;
    _scrimView.alpha = 0.5;
    _scrimView.translatesAutoresizingMaskIntoConstraints = NO;
    [_scrimView addGestureRecognizer:tapGesture];

    _dialogView = [[BPKDialogView alloc] initWithFrame:CGRectZero];
    _dialogView.translatesAutoresizingMaskIntoConstraints = NO;
    _dialogView.delegate = self;
    [_dialogView setTitle:self.titleText];
    [_dialogView setIcon:self.iconImage];
    _dialogView.hasShadow = self.shadowStyle == BPKDialogControllerShadowStyleShadow;
    [_dialogView setButtonActions:self.buttonActions];
    [_dialogView setDescription:self.messageText];
    [_dialogView setHeadColor:self.headColor];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [_scrimView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [_scrimView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [_scrimView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [_scrimView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              ]];

    NSLayoutConstraint *leadConstraint = [_dialogView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:BPKSpacingLg];
    leadConstraint.priority = UILayoutPriorityDefaultHigh;
    leadConstraint.active = YES;
    
    NSLayoutConstraint *trailingConstraint = [_dialogView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-BPKSpacingLg];
    trailingConstraint.priority = UILayoutPriorityDefaultHigh;
    trailingConstraint.active = YES;
    
    NSLayoutConstraint *widthConstraint = [_dialogView.widthAnchor constraintLessThanOrEqualToConstant:self.view.bounds.size.width - 2*BPKSpacingMd];
    widthConstraint.priority = UILayoutPriorityRequired;
    widthConstraint.active = YES;
    
    [_dialogView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (self.style == BPKDialogControllerStyleBottomSheet) {
        [_dialogView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:BPKSpacingBase].active = YES;
        [_dialogView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = NO;
    } else if (self.style == BPKDialogControllerStyleAlert) {
        [_dialogView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = NO;
        [_dialogView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    }
}

- (void)addViews {
    [self.view addSubview:_scrimView];
    [self.view addSubview:_dialogView];
}

- (void)removeViews {
    [self.scrimView removeFromSuperview];
    [self.dialogView removeFromSuperview];
}


- (void)scrimTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if( gestureRecognizer.state == UIGestureRecognizerStateRecognized ) {
        [self dismissDialogWithScrimTap];
    }
}

- (void)dismissDialogWithScrimTap {
    if (self.scrimAction.handler) {
        self.scrimAction.handler(self.scrimAction.shouldDismiss);
    }
    
    if (self.scrimAction.shouldDismiss) {
        // TODO: Should this be the responsibility of the presenter?
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)closeDialogWithHandler:(BPKDialogButtonActionHandler)handler {
    [self dismissViewControllerAnimated:NO completion:nil];
    handler();
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

- (UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCoverVertical;
}

#pragma mark - PUBLIC

- (void)addScrimAction:(BPKDialogScrimAction *)action {
    self.scrimAction = action;
}

- (void)addButtonAction:(BPKDialogButtonAction *)action {
    [self.buttonActions addObject:action];
    [_dialogView setButtonActions:self.buttonActions];
}

@end

NS_ASSUME_NONNULL_END
