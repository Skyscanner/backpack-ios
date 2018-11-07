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
#import <Backpack/UIView+BPKRTL.h>

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
    [self.titleLabel setFontStyle:BPKFontStyleTextSm];
    [self addSubview:self.titleLabel];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:singleFingerTap];
    
    [self updateStyle];
    self.initializing = NO;
}

#pragma mark - Style setters

- (void)setTitle:(NSString *_Nullable)title {
    _title = [title copy];
    
    [self updateTitle];
}

#pragma mark - State setters

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateStyle];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateStyle];
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setConstraints];
    self.layer.cornerRadius = self.bounds.size.height / 2;
    
    BPKShadow *shadow = [BPKShadow shadowSm];
    [shadow applyToLayer:self.layer];
}

- (void)setConstraints {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [[self.titleLabel.centerXAnchor constraintEqualToAnchor:self.centerXAnchor] setActive:YES];
        [[self.titleLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor] setActive:YES];
}

- (CGSize)intrinsicContentSize {
    CGSize labelSize = self.titleLabel.bounds.size;
    return CGSizeMake(labelSize.width + 2*BPKSpacingBase, labelSize.height + 2*BPKSpacingMd);
}

#pragma mark - Updates

- (void)updateStyle {
    if(self.selected) {
        self.backgroundColor = [BPKColor blue500];
        self.textColor = [BPKColor white];
    } else {
        self.backgroundColor = [BPKColor white];
        self.textColor = [BPKColor gray800];
    }
    
    if(!self.enabled){
        self.backgroundColor = [BPKColor white];
        self.textColor = [BPKColor gray100];
    }
    
    [self updateTitle];
    [self setNeedsDisplay];
}

- (void)updateTitle {
    if(self.title == nil){
        return;
    }
    
    self.titleLabel.text = self.title;
    [self.titleLabel sizeToFit];
    [self.titleLabel setTextColor:self.textColor];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    [self setSelected:!self.selected];
}

@end

NS_ASSUME_NONNULL_END
