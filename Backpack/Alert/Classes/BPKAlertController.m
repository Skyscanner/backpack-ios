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
#import "BPKAlertButtonConfiguration.h"
#import "BPKAlertDoneButtonConfiguration.h"
#import "BPKAlertFaderConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKAlertController()

@property (nonatomic, strong) UIView *faderView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) BPKAlertView *alertView;
@property (nonatomic, strong) BPKAlertConfiguration *configuration;

@end

@implementation BPKAlertController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _faderView = [UIView new];
        _faderView.clipsToBounds = YES;
        _faderView.userInteractionEnabled = YES;
        _faderView.backgroundColor = BPKColor.gray900;
        _faderView.alpha = 0.5;
        _faderView.translatesAutoresizingMaskIntoConstraints = NO;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faderTapped:)];
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
    }
    return self;
}

- (void)alertWithConfiguration:(BPKAlertConfiguration * _Nonnull)configuration
                        onView:(UIView * _Nonnull)baseView {
    _configuration = configuration;
    

    [baseView addSubview:_faderView];
    [_faderView.leadingAnchor constraintEqualToAnchor:baseView.leadingAnchor].active = YES;
    [_faderView.trailingAnchor constraintEqualToAnchor:baseView.trailingAnchor].active = YES;
    [_faderView.topAnchor constraintEqualToAnchor:baseView.topAnchor].active = YES;
    [_faderView.bottomAnchor constraintEqualToAnchor:baseView.bottomAnchor].active = YES;
    
    [_doneButton setTitle:configuration.doneButtonConfiguration.titleText forState:UIControlStateNormal];
    [baseView addSubview:_doneButton];
    
    [_doneButton.trailingAnchor constraintEqualToAnchor:baseView.trailingAnchor constant:-BPKSpacingLg].active = YES;
    if (@available(iOS 11.0, *)) {
        CGFloat topInset = baseView.safeAreaInsets.top;
        CGFloat offsetConstant = topInset == 0 ? 20+BPKSpacingMd : BPKSpacingMd;
        [_doneButton.topAnchor constraintEqualToAnchor:baseView.safeAreaLayoutGuide.topAnchor constant:offsetConstant].active = YES;
    } else {
        [_doneButton.topAnchor constraintEqualToAnchor:baseView.topAnchor constant:20+BPKSpacingLg].active = YES; // notch only available on iOS 11+ devices
    }
    [_doneButton setHidden:!(configuration.doneButtonConfiguration.isVisible)];
    
    // create alert view && show alert
    [_alertView setTitle:configuration.titleText];
    [_alertView setIcon:configuration.iconImage];
    [_alertView setHasShadow:configuration.hasShadow];
    [_alertView setButtonConfigurations:configuration.buttonConfigurations];
    [_alertView setDescription:configuration.descriptionText];
    [_alertView setHeadColor:configuration.circleColor];
    [baseView addSubview:_alertView];
    
    [_alertView.centerXAnchor constraintEqualToAnchor:baseView.centerXAnchor].active = YES;
    
    NSLayoutConstraint *leadConstraint = [_alertView.leadingAnchor constraintEqualToAnchor:baseView.leadingAnchor constant:BPKSpacingLg];
    leadConstraint.priority = UILayoutPriorityDefaultHigh;
    leadConstraint.active = YES;

    NSLayoutConstraint *trailingConstraint = [_alertView.trailingAnchor constraintEqualToAnchor:baseView.trailingAnchor constant:-BPKSpacingLg];
    trailingConstraint.priority = UILayoutPriorityDefaultHigh;
    trailingConstraint.active = YES;
    
    NSLayoutConstraint *widthConstraint = [_alertView.widthAnchor constraintLessThanOrEqualToConstant:baseView.bounds.size.width - 2*BPKSpacingMd];
    widthConstraint.priority = UILayoutPriorityRequired;
    widthConstraint.active = YES;
    
    if (configuration.isFullScreen) {
        [_alertView.topAnchor constraintGreaterThanOrEqualToAnchor:_doneButton.bottomAnchor constant:BPKSpacingMd].active = YES;
        [_alertView.bottomAnchor constraintEqualToAnchor:baseView.bottomAnchor].active = YES;
        [_alertView.centerYAnchor constraintEqualToAnchor:baseView.centerYAnchor].active = NO;

    } else {
        [_alertView.topAnchor constraintGreaterThanOrEqualToAnchor:_doneButton.bottomAnchor constant:BPKSpacingMd].active = NO;
        [_alertView.bottomAnchor constraintEqualToAnchor:baseView.bottomAnchor].active = NO;
        [_alertView.centerYAnchor constraintEqualToAnchor:baseView.centerYAnchor].active = YES;
    }
    
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
    if (_configuration.doneButtonConfiguration.handler) {
        [self removeViews];
        _configuration.doneButtonConfiguration.handler();
    }
}

-(void)dismissAlertWithFaderTap {
    if (_configuration.faderConfiguration.handler) {
        _configuration.faderConfiguration.handler(_configuration.faderConfiguration.shouldDismiss);
    }
    
    if (_configuration.faderConfiguration.shouldDismiss) {
        [self removeViews];
    }
}

-(void)closeAlertWithHandler:(BPKAlertButtonActionHandler)handler {
    [self removeViews];
    handler();
}

@end

NS_ASSUME_NONNULL_END
