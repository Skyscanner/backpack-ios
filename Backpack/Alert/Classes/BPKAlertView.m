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
NS_ASSUME_NONNULL_BEGIN

@interface BPKAlertView()

@end

@implementation BPKAlertView
{
    UIView *_circularView;
    UIView *_iconContainerView;
    UIImageView *_iconImageView;
    
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
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        tap.delegate = self;
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setupViews {
    _contentHolderView = [UIView new];
    _contentHolderView.backgroundColor = BPKColor.white;
    _contentHolderView.layer.cornerRadius = 4;
    
    _circularView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _circularView.layer.cornerRadius = _circularView.frame.size.width / 2;
    _circularView.backgroundColor = BPKColor.white;
    
    _iconContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _iconContainerView.layer.cornerRadius = _iconContainerView.frame.size.width / 2;
    _iconContainerView.backgroundColor = BPKColor.red500;
    
    _iconImageView = [[UIImageView alloc] init];
    
    _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextXlEmphasized];
    
    _descriptionLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextLg];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    _buttonStackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _buttonStackView.axis = UILayoutConstraintAxisVertical;
    _buttonStackView.spacing = BPKSpacingMd;
    
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
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
    [_circularView addSubview:_iconImageView];

    [_contentHolderView addSubview:_titleLabel];
    [_contentHolderView addSubview:_descriptionLabel];
    [_contentHolderView addSubview:_buttonStackView];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [_circularView.topAnchor constraintEqualToAnchor:_circularView.superview.topAnchor],
                                              [_circularView.centerXAnchor constraintEqualToAnchor:_contentHolderView.centerXAnchor],
                                              [_circularView.heightAnchor constraintEqualToConstant:70],
                                              [_circularView.widthAnchor constraintEqualToConstant:70],
                                              
                                              [_iconContainerView.centerYAnchor constraintEqualToAnchor:_circularView.centerYAnchor],
                                              [_iconContainerView.centerXAnchor constraintEqualToAnchor:_circularView.centerXAnchor],
                                              [_iconContainerView.heightAnchor constraintEqualToConstant:60],
                                              [_iconContainerView.widthAnchor constraintEqualToConstant:60],
                                              
                                              [_iconImageView.centerYAnchor constraintEqualToAnchor:_iconContainerView.centerYAnchor],
                                              [_iconImageView.centerXAnchor constraintEqualToAnchor:_iconContainerView.centerXAnchor],
                                              
                                              [_contentHolderView.topAnchor constraintEqualToAnchor:_circularView.bottomAnchor constant:-35],
                                              [_contentHolderView.bottomAnchor constraintEqualToAnchor:_contentHolderView.superview.bottomAnchor],
                                              [_contentHolderView.leadingAnchor constraintEqualToAnchor:_contentHolderView.superview.leadingAnchor],
                                              [_contentHolderView.trailingAnchor constraintEqualToAnchor:_contentHolderView.superview.trailingAnchor],
                                              
                                              [_titleLabel.topAnchor constraintEqualToAnchor:_circularView.bottomAnchor constant:BPKSpacingLg],
                                              [_titleLabel.centerXAnchor constraintEqualToAnchor:_titleLabel.superview.centerXAnchor],
                                              
                                              [_descriptionLabel.topAnchor constraintEqualToAnchor:_titleLabel.bottomAnchor constant:BPKSpacingLg],
                                              [_descriptionLabel.leadingAnchor constraintEqualToAnchor:_descriptionLabel.superview.leadingAnchor constant:BPKSpacingLg],
                                              [_descriptionLabel.trailingAnchor constraintEqualToAnchor:_descriptionLabel.superview.trailingAnchor constant:-BPKSpacingLg],
                                              
                                              [_buttonStackView.topAnchor constraintEqualToAnchor:_descriptionLabel.bottomAnchor constant:BPKSpacingLg],
                                              [_buttonStackView.leadingAnchor constraintEqualToAnchor:_buttonStackView.superview.leadingAnchor constant:BPKSpacingXl],
                                              [_buttonStackView.trailingAnchor constraintEqualToAnchor:_buttonStackView.superview.trailingAnchor constant:-BPKSpacingXl],
                                              [_buttonStackView.bottomAnchor constraintEqualToAnchor:_buttonStackView.superview.bottomAnchor constant:-BPKSpacingLg]
                                              ]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.hasShadow) {
        BPKShadow *shadowLg = [BPKShadow shadowSm];
        [shadowLg applyToLayer:self.layer];
    } else {
        [self.layer setShadowOpacity:0];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isEqual:self]) {
        return YES;
    }
    return NO;
}

- (void)tapView:(UITapGestureRecognizer *)tapGesture {
    [self.delegate dismissAlertWithFaderTap];
}

#pragma mark - PUBLIC
-(void)setHeadColor:(UIColor * _Nullable)color {
    _iconContainerView.backgroundColor = color;
}

-(void)setTitle:(NSString *)titleString {
    [_titleLabel setText:titleString];
}

-(void)setIcon:(UIImage *)iconImage {
    [_iconImageView setImage:iconImage];
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
NS_ASSUME_NONNULL_END
