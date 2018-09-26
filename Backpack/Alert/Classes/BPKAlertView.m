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
    NSArray<BPKButton *> *_buttons;
    UIStackView *_buttonStackView;
    
    NSDictionary<BPKAlertButtonConfiguration *, BPKButton *> *_buttonConfigurationMap;
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
    
    _buttonStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _buttonStackView.axis = UILayoutConstraintAxisVertical;
    _buttonStackView.spacing = BPKSpacingMd;
    
    _buttonStackView.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _circularView.translatesAutoresizingMaskIntoConstraints = NO;
    _iconContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    _contentHolderView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)addViews {
    [self addSubview:_contentHolderView];
    [self addSubview:_circularView];
    [_circularView addSubview:_iconContainerView];
    
    [_contentHolderView addSubview:_titleLabel];
    [_contentHolderView addSubview:_descriptionLabel];
    [_contentHolderView addSubview:_buttonStackView];
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
    
    [_buttonStackView.topAnchor constraintEqualToAnchor:_descriptionLabel.bottomAnchor constant:BPKSpacingLg].active = YES;
    [_buttonStackView.leadingAnchor constraintEqualToAnchor:_buttonStackView.superview.leadingAnchor constant:BPKSpacingXl].active = YES;
    [_buttonStackView.trailingAnchor constraintEqualToAnchor:_buttonStackView.superview.trailingAnchor constant:-BPKSpacingXl].active = YES;
    [_buttonStackView.bottomAnchor constraintEqualToAnchor:_buttonStackView.superview.bottomAnchor constant:-BPKSpacingLg].active = YES;
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

- (void)buttonTapped:(BPKButton *)button {
    BPKAlertButtonConfiguration *config = [self configForButton:button];
    if (config) {
        [self.delegate closeAlertWithHandler:config.handler];
    }
}

- (BPKAlertButtonConfiguration *)configForButton:(BPKButton *)button {
    for (NSInteger i = 0; i < [_buttonConfigurationMap allValues].count; i++) {
        BPKButton *btn = [_buttonConfigurationMap allValues][i];
        if ([btn isEqual:button]) {
            return [_buttonConfigurationMap allKeys][i];
        }
    }
    
    return nil;
}

#pragma mark - PUBLIC
-(void)setHeadColor:(UIColor * _Nullable)color {
    _iconContainerView.backgroundColor = color;
}

-(void)setTitle:(NSString *)titleString {
    [_titleLabel setText:titleString];
}

-(void)setDescription:(NSString *)descriptionString {
    [_descriptionLabel setText:descriptionString];
}

-(void)setButtonConfigurations:(NSArray<BPKAlertButtonConfiguration *> *)buttonConfigurations {
    NSMutableDictionary<BPKAlertButtonConfiguration *, BPKButton *> *btnConfigMap = [NSMutableDictionary new];
    [self resetStackViewContent];
    
    for (NSInteger i = 0; i < buttonConfigurations.count; i++) {
        BPKAlertButtonConfiguration *buttonConfig = buttonConfigurations[i];
        BPKButton *button = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:buttonConfig.style];
        [button setTitle:buttonConfig.title];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        btnConfigMap[buttonConfig] = button;
        
        [_buttonStackView addArrangedSubview:button];
    }
    
    _buttonConfigurationMap = [btnConfigMap copy];
    
    [self setNeedsUpdateConstraints];
}
- (void)resetStackViewContent {
    [[_buttonStackView arrangedSubviews] enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view removeFromSuperview];
    }];
}

@end
