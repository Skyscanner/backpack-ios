/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
#import "BPKTextField.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKTextField ()
- (void)setupWithStyle:(BPKFontStyle)style;
@end

@implementation BPKTextField

- (instancetype)initWithFontStyle:(BPKFontStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithStyle:style];
    }

    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    BPKAssertMainThread();
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
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
        attributedString = [BPKFont attributedStringWithFontStyle:self.fontStyle
                                                          content:text
                                                        textColor:self.textColor
                                                      fontMapping:self.fontMapping];
    } else {
        attributedString = [BPKFont attributedStringWithFontStyle:self.fontStyle
                                                          content:text
                                                      fontMapping:self.fontMapping];
    }
    self.attributedText = attributedString;
}

- (void)setTextColor:(UIColor * _Nullable)textColor {
    BPKAssertMainThread();
    [super setTextColor:textColor];

    [self updateStyle];
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    _fontStyle = fontStyle;

    [self updateStyle];
}

- (void)setFontMapping:(BPKFontMapping *_Nullable)fontMapping {
    BPKAssertMainThread();
    _fontMapping = fontMapping;

    [self updateStyle];
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.fontStyle = style;
    self.textColor = [BPKColor gray700];
    self.borderStyle = UITextBorderStyleRoundedRect;
    self.backgroundColor = BPKColor.white;

    [self updateStyle];
}

- (void)updateStyle {
    NSDictionary *colorAttributes = self.textColor ? @{NSForegroundColorAttributeName: self.textColor} : @{};
    self.defaultTextAttributes = [BPKFont attributesForFontStyle:self.fontStyle
                                            withCustomAttributes:colorAttributes
                                                     fontMapping:self.fontMapping];

    [self setText:self.attributedText.string];
}

@end
NS_ASSUME_NONNULL_END
