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
#import <Backpack/Color.h>
#import <Backpack/Button.h>
#import <Backpack/Spacing.h>

@interface BPKAlertView()

@end

@implementation BPKAlertView
{
    UIView *_circularView;
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
        [self localize];
    }
    return self;
}

- (void)setupViews {
    _contentHolderView = [UIView new];
    _contentHolderView.backgroundColor = BPKColor.white;
    _contentHolderView.layer.cornerRadius = 4;
    
    _circularView = [[UIView alloc] initWithFrame:CGRectZero];
    _circularView.layer.cornerRadius = 50;
    _circularView.backgroundColor = BPKColor.white;
    
    _titleLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextBaseEmphasized];
    
    _descriptionLabel = [[BPKLabel alloc] initWithFontStyle:BPKFontStyleTextSm];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.textAlignment = NSTextAlignmentCenter;
    _primaryButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStylePrimary];
    _secondaryButton = [[BPKButton alloc] initWithSize:BPKButtonSizeDefault style:BPKButtonStyleSecondary];
    
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _primaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    _circularView.translatesAutoresizingMaskIntoConstraints = NO;
    _secondaryButton.translatesAutoresizingMaskIntoConstraints = NO;
    _contentHolderView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.clipsToBounds = YES;
}

- (void)addViews {
    [self addSubview:_circularView];
    [self addSubview:_contentHolderView];
    [_contentHolderView addSubview:_titleLabel];
    [_contentHolderView addSubview:_descriptionLabel];
    [_contentHolderView addSubview:_primaryButton];
    [_contentHolderView addSubview:_secondaryButton];
}

- (void)setupConstraints {
    [_circularView.topAnchor constraintEqualToAnchor:_circularView.superview.topAnchor].active = YES;
    [_circularView.centerXAnchor constraintEqualToAnchor:_contentHolderView.centerXAnchor].active = YES;
    [_circularView.heightAnchor constraintEqualToConstant:100].active = YES;
    [_circularView.widthAnchor constraintEqualToConstant:100].active = YES;
    
    [_contentHolderView.topAnchor constraintEqualToAnchor:_circularView.bottomAnchor constant:-50].active = YES;
    [_contentHolderView.bottomAnchor constraintEqualToAnchor:_contentHolderView.superview.bottomAnchor].active = YES;
    [_contentHolderView.leadingAnchor constraintEqualToAnchor:_contentHolderView.superview.leadingAnchor].active = YES;
    [_contentHolderView.trailingAnchor constraintEqualToAnchor:_contentHolderView.superview.trailingAnchor].active = YES;
    
    [_titleLabel.topAnchor constraintEqualToAnchor:_titleLabel.superview.topAnchor constant:BPKSpacingLg].active = YES;
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

- (void)localize {
    [_titleLabel setText:@"Discard your review"];
    [_descriptionLabel setText:@"Are you sure you want to discard your review? Any changes won't be saved. Are you sure you want to discard your review? Any changes won't be saved Are you sure you want to discard your review? Any changes won't be saved Are you sure you want to discard your review? Any changes won't be saved"];
    [_primaryButton setTitle:@"Discard" forState:UIControlStateNormal];
    [_secondaryButton setTitle:@"Cancel" forState:UIControlStateNormal];
}

@end
