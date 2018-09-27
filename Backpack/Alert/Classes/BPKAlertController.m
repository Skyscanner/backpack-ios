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

#import "BPKAlertController.h"
#import <Backpack/Color.h>
#import <Backpack/Spacing.h>
#import <Backpack/Font.h>
#import <Backpack/Color.h>
#import <Backpack/Button.h>
#import "BPKAlertConfiguration.h"
#import "BPKAlertButtonAction.h"
#import "BPKAlertDoneButtonAction.h"
#import "BPKAlertFaderAction.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKAlertController()

@property (nonatomic, readwrite) UIColor *headColor;
@property (nonatomic, readwrite) UIImage *iconImage;
@property (nonatomic, readwrite) NSString *titleText;
@property (nonatomic, readwrite) NSString *messageText;
@property (nonatomic, readwrite) BPKShadow *shadow;
@property (nonatomic, readwrite) BPKAlertControllerStyle style;

@property (nonatomic, readwrite) UIView *faderView;
@property (nonatomic, readwrite) UIButton *doneButton;
@property (nonatomic, readwrite) BPKAlertView *alertView;

@property (nonatomic, readwrite) NSMutableArray<BPKAlertButtonAction *> *buttonActions;
@property (nonatomic, readwrite) BPKAlertDoneButtonAction *doneAction;
@property (nonatomic, readwrite) BPKAlertFaderAction *faderAction;

@end

@implementation BPKAlertController

- (instancetype)initWithTitle:(nullable NSString *)title
                      message:(nullable NSString *)message
                        style:(BPKAlertControllerStyle)style
                       shadow:(BPKShadow *)shadow
                    headColor:(UIColor *)headColor
                    iconImage:(UIImage *)iconImage {
    self = [super init];
    if (self) {
        self.titleText = title;
        self.messageText = message;
        self.style = style;
        self.shadow = shadow;
        self.headColor = headColor;
        self.iconImage = iconImage;
        
        self.buttonActions = [NSMutableArray new];
        
        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    return self;
}

+(instancetype)alertControllerWithTitle:(NSString *)title
                                message:(NSString *)message
                                  style:(BPKAlertControllerStyle)style
                                 shadow:(BPKShadow *)shadow
                              headColor:(UIColor *)headColor
                              iconImage:(UIImage *)iconImage {
    return [[self alloc] initWithTitle:title message:message style:style shadow:shadow headColor:headColor iconImage:iconImage];
}

- (void)setupViews
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faderTapped:)];
    
    _faderView = [UIView new];
    _faderView.clipsToBounds = YES;
    _faderView.userInteractionEnabled = YES;
    _faderView.backgroundColor = BPKColor.gray900;
    _faderView.alpha = 0.5;
    _faderView.translatesAutoresizingMaskIntoConstraints = NO;
    [_faderView addGestureRecognizer:tapGesture];

    _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [_doneButton setTitleColor:BPKColor.white forState:UIControlStateNormal];
    [_doneButton addTarget:self action:@selector(doneTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_doneButton setHidden:YES];
    [_doneButton.titleLabel setFont:[BPKFont textBaseEmphasized]];
    _doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    _alertView = [[BPKAlertView alloc] initWithFrame:CGRectZero];
    _alertView.translatesAutoresizingMaskIntoConstraints = NO;
    _alertView.delegate = self;
    [_alertView setTitle:self.titleText];
    [_alertView setIcon:self.iconImage];
    [_alertView setBackpackShadow:self.shadow];
    [_alertView setButtonActions:self.buttonActions];
    [_alertView setDescription:self.messageText];
    [_alertView setHeadColor:self.headColor];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [_faderView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [_faderView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [_faderView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [_faderView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              
                                              [_doneButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-BPKSpacingLg]
                                              ]];
    
    // Notch and status bar
    if (@available(iOS 11.0, *)) {
        [_doneButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:BPKSpacingSm].active = YES;
    } else {
        [_doneButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:20+BPKSpacingLg].active = YES; // notch only available on iOS 11+ devices
    }
    
    NSLayoutConstraint *leadConstraint = [_alertView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:BPKSpacingLg];
    leadConstraint.priority = UILayoutPriorityDefaultHigh;
    leadConstraint.active = YES;
    
    NSLayoutConstraint *trailingConstraint = [_alertView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-BPKSpacingLg];
    trailingConstraint.priority = UILayoutPriorityDefaultHigh;
    trailingConstraint.active = YES;
    
    NSLayoutConstraint *widthConstraint = [_alertView.widthAnchor constraintLessThanOrEqualToConstant:self.view.bounds.size.width - 2*BPKSpacingMd];
    widthConstraint.priority = UILayoutPriorityRequired;
    widthConstraint.active = YES;
    
    [_alertView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    if (self.style == BPKAlertControllerStyleBottomSheet) {
        [_alertView.topAnchor constraintGreaterThanOrEqualToAnchor:_doneButton.bottomAnchor constant:BPKSpacingMd].active = YES;
        [_alertView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
        [_alertView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = NO;
    } else if (self.style == BPKAlertControllerStyleAlert) {
        [_alertView.topAnchor constraintGreaterThanOrEqualToAnchor:_doneButton.bottomAnchor constant:BPKSpacingMd].active = NO;
        [_alertView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = NO;
        [_alertView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    }

}

- (void)addViews {
    [self.view addSubview:_faderView];
    [self.view addSubview:_alertView];
    [self.view addSubview:_doneButton];
}

- (void)removeViews {
    [self.faderView removeFromSuperview];
    [self.doneButton removeFromSuperview];
    [self.alertView removeFromSuperview];
}


-(void)faderTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if( gestureRecognizer.state == UIGestureRecognizerStateRecognized ) {
        [self dismissAlertWithFaderTap];
    }
}

-(void)doneTapped:(UIButton *)button {
    if (self.doneAction.handler) {
        [self dismissViewControllerAnimated:NO completion:nil];
        self.doneAction.handler();
    }
}

-(void)dismissAlertWithFaderTap {
    if (self.faderAction.handler) {
        self.faderAction.handler(self.faderAction.shouldDismiss);
    }
    
    if (self.faderAction.shouldDismiss) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

-(void)closeAlertWithHandler:(BPKAlertButtonActionHandler)handler {
    [self dismissViewControllerAnimated:NO completion:nil];
    handler();
}

- (UIModalPresentationStyle)modalPresentationStyle {
    return UIModalPresentationOverCurrentContext;
}

-(UIModalTransitionStyle)modalTransitionStyle {
    return UIModalTransitionStyleCoverVertical;
}

#pragma mark - PUBLIC
-(void)addFaderAction:(BPKAlertFaderAction *)action {
    self.faderAction = action;
}

-(void)addButtonAction:(BPKAlertButtonAction *)action {
    [self.buttonActions addObject:action];
    [_alertView setButtonActions:self.buttonActions];
}

-(void)addDoneButtonAction:(BPKAlertDoneButtonAction *)action {
    self.doneAction = action;
    [_doneButton setTitle:self.doneAction.titleText forState:UIControlStateNormal];
    [_doneButton setHidden:!(self.doneAction.isVisible)];
}
@end

NS_ASSUME_NONNULL_END
