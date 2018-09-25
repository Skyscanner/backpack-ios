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

#import "BPKAlertView.h"
#import <Backpack/Label.h>
#import <Backpack/Spacing.h>
#import <Backpack/Shadow.h>


@interface BPKAlertView()

@end

@implementation BPKAlertView
{
    UIView *_circularView;
    UIView *_iconContainerView;

    UIView *_contentHolderView;
    BPKLabel *_titleLabel;
    BPKLabel *_descriptionLabel;
    BPKButton *_primaryButton;
    BPKButton *_secondaryButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews {
    _contentHolderView = [UIView new];
    _contentHolderView.backgroundColor = BPKColor.white;
    _contentHolderView.layer.cornerRadius = 4;
    
    _circularView = [[UIView alloc] initWithFrame:CGRectZero];
    _circularView.layer.cornerRadius = 35;
    _circularView.backgroundColor = BPKColor.white;
    
    _iconContainerView = [[UIView alloc] initWithFrame:CGRectZero];
    _iconContainerView.layer.cornerRadius = 30;
    _iconContainerView.backgroundColor = BPKColor.red500;
    
    _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextLgEmphasized];
    
    _descriptionLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextSm];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _primaryButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    [_primaryButton addTarget:self action:@selector(primaryActionTapped) forControlEvents:UIControlEventTouchUpInside];
    _secondaryButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary];
    [_secondaryButton addTarget:self action:@selector(secondaryActionTapped) forControlEvents:UIControlEventTouchUpInside];
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _primaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    _circularView.translatesAutoresizingMaskIntoConstraints = NO;
    _iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;

    _secondaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    _contentHolderView.translatesAutoresizingMaskIntoConstraints = NO;    
}

- (void)addViews {
    [self addSubview:_contentHolderView];
    [self addSubview:_circularView];
    [_circularView addSubview:_iconContainerView];
    
    [_contentHolderView addSubview:_titleLabel];
    [_contentHolderView addSubview:_descriptionLabel];
    [_contentHolderView addSubview:_primaryButton];
    [_contentHolderView addSubview:_secondaryButton];
}

- (void)setupConstraints {
    [_circularView.topAnchor constraintEqualToAnchor:_circularView.superview.topAnchor].active = YES;
    [_circularView.centerXAnchor constraintEqualToAnchor:_contentHolderView.centerXAnchor].active = YES;
    [_circularView.heightAnchor constraintEqualToConstant:70].active = YES;
    [_circularView.widthAnchor constraintEqualToConstant:70].active = YES;
  
    [_iconContainerView.centerYAnchor constraintEqualToAnchor:_circularView.centerYAnchor].active = YES;
    [_iconContainerView.centerXAnchor constraintEqualToAnchor:_circularView.centerXAnchor].active = YES;
    [_iconContainerView.heightAnchor constraintEqualToConstant:60].active = YES;
    [_iconContainerView.widthAnchor constraintEqualToConstant:60].active = YES;
    
    [_contentHolderView.topAnchor constraintEqualToAnchor:_circularView.bottomAnchor constant:-35].active = YES;
    [_contentHolderView.bottomAnchor constraintEqualToAnchor:_contentHolderView.superview.bottomAnchor].active = YES;
    [_contentHolderView.leadingAnchor constraintEqualToAnchor:_contentHolderView.superview.leadingAnchor].active = YES;
    [_contentHolderView.trailingAnchor constraintEqualToAnchor:_contentHolderView.superview.trailingAnchor].active = YES;
    
    [_titleLabel.topAnchor constraintEqualToAnchor:_circularView.bottomAnchor constant:BPKSpacingLg].active = YES;
    [_titleLabel.centerXAnchor constraintEqualToAnchor:_titleLabel.superview.centerXAnchor].active = YES;
    
    [_descriptionLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:BPKSpacingLg].active = YES;
    [_descriptionLabel.leadingAnchor constraintEqualToAnchor:_descriptionLabel.superview.leadingAnchor constant:BPKSpacingLg].active = YES;
    [_descriptionLabel.trailingAnchor constraintEqualToAnchor:_descriptionLabel.superview.trailingAnchor constant:-BPKSpacingLg].active = YES;
    
    [_primaryButton.topAnchor constraintEqualToAnchor:_descriptionLabel.bottomAnchor constant:BPKSpacingLg].active = YES;
    [_primaryButton.centerXAnchor constraintEqualToAnchor:_primaryButton.superview.centerXAnchor].active = YES;
  
    [_secondaryButton.topAnchor constraintEqualToAnchor:_primaryButton.bottomAnchor constant:BPKSpacingMd].active = YES;
    [_secondaryButton.centerXAnchor constraintEqualToAnchor:_secondaryButton.superview.centerXAnchor].active = YES;
    [_secondaryButton.bottomAnchor constraintEqualToAnchor:_secondaryButton.superview.bottomAnchor constant:-BPKSpacingLg].active = YES;
}

- (void)setupShadowOnView:(UIView *)view {
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.layer.cornerRadius];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor colorWithRed:0.145 green:0.125 blue:0.200 alpha:1].CGColor;
    view.layer.shadowOffset = CGSizeMake(0, -8);
    view.layer.shadowOpacity = 0.13;
    view.layer.shadowPath = shadowPath.CGPath;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.hasShadow) {
        BPKShadow *shadowSm = [BPKShadow shadowLg];
        [shadowSm applyToLayer:_contentHolderView.layer];
        [self setupShadowOnView:_circularView];
    } else {
        [_circularView.layer setShadowOpacity:0];
        [_contentHolderView.layer setShadowOpacity:0];
    }
}

-(void)setHasShadow:(BOOL)hasShadow {
    _hasShadow = hasShadow;
    [self setNeedsLayout];
}

- (void)primaryActionTapped {
    [self.delegate primaryActionTapped];
}

- (void)secondaryActionTapped {
    [self.delegate secondaryActionTapped];
}

#pragma mark - PUBLIC
-(void)setHeadColor:(BPKColor * _Nullable)color {
    _iconContainerView.backgroundColor = (UIColor *)color;
}

-(void)setTitle:(NSString *)titleString {
    [_titleLabel setText:titleString];
}

-(void)setDescription:(NSString *)descriptionString {
    [_descriptionLabel setText:descriptionString];
}

-(void)setPrimaryButtonStyle:(BPKButtonStyle)style {
    [_primaryButton setStyle:style];
}

-(void)setPrimaryButtonTitle:(NSString *)buttonTitle {
    [_primaryButton setTitle:buttonTitle forState:UIControlStateNormal];
}

-(void)setSecondaryButtonStyle:(BPKButtonStyle)style {
    [_secondaryButton setStyle:style];
}

-(void)setSecondaryButtonTitle:(NSString *)buttonTitle {
    [_secondaryButton setTitle:buttonTitle forState:UIControlStateNormal];
}

@end
