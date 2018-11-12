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

#import "BPKChip.h"

#import <Backpack/Font.h>
#import <Backpack/Label.h>
#import <Backpack/Color.h>
#import <Backpack/Shadow.h>
#import <Backpack/Spacing.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKChip()
@property(nonatomic, getter=isInitializing) BOOL initializing;
@property(nonatomic) BPKLabel* titleLabel;

@property(nonatomic) UIColor *textColor;
@end

@implementation BPKChip

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.initializing = YES;
    
    self.titleLabel = [[BPKLabel alloc]initWithFrame:CGRectZero];
    self.titleLabel.fontStyle = BPKFontStyleTextSm;
    [self addSubview:self.titleLabel];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addTarget:self action:@selector(handleSingleTap:) forControlEvents:UIControlEventTouchDown];
    
    [self setupConstraints];
    
    BPKShadow *shadow = [BPKShadow shadowSm];
    [shadow applyToLayer:self.layer];
    
    [self updateStyle];
    self.initializing = NO;
}

#pragma mark - Layout overrides

- (void)layoutSubviews {
    self.layer.cornerRadius = self.bounds.size.height / 2;
}

- (CGSize)sizeThatFits:(CGSize)size {
    [self.titleLabel sizeToFit];
    float width = self.titleLabel.frame.size.width + 2 * BPKSpacingBase;
    float height = self.titleLabel.frame.size.height + 2 * BPKSpacingMd;
    return CGSizeMake(width, height);
}

#pragma mark - State setters

- (void)setTitle:(NSString *_Nullable)title {
    _title = [title copy];
    
    [self updateTitle];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateStyle];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateStyle];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateStyle];
}

#pragma mark - Layout

- (void)setupConstraints {
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [[self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:BPKSpacingBase] setActive:YES];
    [[self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:BPKSpacingMd] setActive:YES];
    [[self.trailingAnchor constraintEqualToAnchor:self.titleLabel.trailingAnchor constant:BPKSpacingBase] setActive:YES];
    [[self.bottomAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:BPKSpacingMd] setActive:YES];
}

#pragma mark - Updates

- (void)updateStyle {
    if(self.selected) {
        self.backgroundColor = BPKColor.blue500;
        self.textColor = BPKColor.white;
        if(self.highlighted){
            self.backgroundColor = BPKColor.gray100;
        }
    } else {
        self.backgroundColor = BPKColor.white;
        self.textColor = BPKColor.gray700;
        if(self.highlighted){
            self.backgroundColor = BPKColor.blue700;
        }
    }
    
    if(!self.enabled){
        self.backgroundColor = BPKColor.white;
        self.textColor = BPKColor.gray100;
    }
    
    [self updateTitle];
}

- (void)updateTitle {
    if(self.title == nil){
        return;
    }
    
    self.titleLabel.text = self.title;
    [self.titleLabel setTextColor:self.textColor];
}

#pragma mark - Actions

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    [self setSelected:!self.selected];
}

@end

NS_ASSUME_NONNULL_END
