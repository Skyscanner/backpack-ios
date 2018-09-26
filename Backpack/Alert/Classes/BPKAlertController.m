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
#import "BPKAlertView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKAlertController()

@property (nonatomic, strong) UIView *faderView;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) BPKAlertView *alertView;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation BPKAlertController
{
    BPKAlertConfiguration *_configuration;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _window = [[UIApplication sharedApplication] keyWindow];
        
        _faderView = [UIView new];
        _faderView.clipsToBounds = YES;
        _faderView.userInteractionEnabled = YES;
        _faderView.backgroundColor = BPKColor.gray900;
        _faderView.alpha = 0.5;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(faderTapped:)];
        [_faderView addGestureRecognizer:tapGesture];

        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_doneButton setTitleColor:BPKColor.white forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_doneButton setHidden:YES];
        [_doneButton.titleLabel setFont:[BPKFont textBaseEmphasized]];

        _alertView = [[BPKAlertView alloc] initWithFrame:CGRectZero];
        _alertView.translatesAutoresizingMaskIntoConstraints = NO;
        _alertView.delegate = self;
    }
    return self;
}

- (void)alertWithConfiguration:(BPKAlertConfiguration * _Nonnull)configuration
                        onView:(UIView * _Nonnull)baseView {
    _configuration = configuration;
    
    _faderView.frame = baseView.bounds;
    [baseView addSubview:_faderView];
    
    [_doneButton setTitle:configuration.doneButtonText forState:UIControlStateNormal];
    _doneButton.frame = CGRectMake(baseView.frame.size.width - BPKSpacingBase - _doneButton.intrinsicContentSize.width, BPKSpacingLg, _doneButton.intrinsicContentSize.width, _doneButton.intrinsicContentSize.height);
    [baseView addSubview:_doneButton];
    [_doneButton setHidden:!(configuration.hasDoneButton)];
    
    // create alert view && show alert
    [_alertView setTitle:configuration.titleText];
    [_alertView setHasShadow:configuration.hasShadow];
    [_alertView setButtonConfigurations:configuration.buttonConfigurations];
    [_alertView setDescription:configuration.descriptionText];
    [_alertView setHeadColor:configuration.circleColor];
    [baseView addSubview:_alertView];
    [_alertView.centerXAnchor constraintEqualToAnchor:baseView.centerXAnchor].active = YES;
    [_alertView.centerYAnchor constraintEqualToAnchor:baseView.centerYAnchor].active = YES;
    [_alertView.leadingAnchor constraintEqualToAnchor:baseView.leadingAnchor constant:BPKSpacingLg].active = YES;
    [_alertView.trailingAnchor constraintEqualToAnchor:baseView.trailingAnchor constant:-BPKSpacingLg].active = YES;
}

- (void)removeViews {
    [self.faderView removeFromSuperview];
    [self.doneButton removeFromSuperview];
    [self.alertView removeFromSuperview];
}


-(void)faderTapped:(UITapGestureRecognizer *)gestureRecognizer {
    if( gestureRecognizer.state == UIGestureRecognizerStateRecognized && _configuration.faderIsDismissAction) {
        [self removeViews];
    }
}

-(void)doneTapped:(UIButton *)button {
    [self removeViews];
}

-(void)closeAlertWithHandler:(BPKAlertButtonActionHandler)handler {
    [self removeViews];
    handler();
}

@end

NS_ASSUME_NONNULL_END
