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
#import "BPKTextView.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKTextView ()
- (void)setupWithStyle:(BPKFontStyle)style;
@end

@implementation BPKTextView

- (instancetype)initWithFontStyle:(BPKFontStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero textContainer:nil];

    if (self) {
        [self setupWithStyle:style];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBodyDefault];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(nullable NSTextContainer *)textContainer {
    BPKAssertMainThread();
    self = [super initWithFrame:frame textContainer:textContainer];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBodyDefault];
    }

    return self;
}

- (void)setText:(NSString *_Nullable)text {
    BPKAssertMainThread();
    if (text == nil) {
        self.attributedText = nil;
        return;
    }

    NSAttributedString *attributedString = nil;
    if (self.textColor) {
        attributedString = [BPKFont attributedStringWithFontStyle:self.fontStyle content:text textColor:self.textColor];
    } else {
        attributedString = [BPKFont attributedStringWithFontStyle:self.fontStyle content:text];
    }
    self.attributedText = attributedString;
}

- (void)setTextColor:(UIColor *_Nullable)textColor {
    BPKAssertMainThread();
    [super setTextColor:textColor];

    [self updateStyle];
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    _fontStyle = fontStyle;

    [self updateStyle];
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.fontStyle = style;
    self.textColor = BPKColor.textPrimaryColor;

    [self updateStyle];
}

- (void)updateStyle {
    NSDictionary *colorAttributes = self.textColor ? @{NSForegroundColorAttributeName: self.textColor} : @{};
    self.typingAttributes = [BPKFont attributesForFontStyle:self.fontStyle withCustomAttributes:colorAttributes];

    [self setText:self.attributedText.string];
}

- (void)traitCollectionDidChange:(UITraitCollection * __nullable)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self updateStyle];
}

@end
NS_ASSUME_NONNULL_END
