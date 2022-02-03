/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

#import "BPKLabel.h"

#import <Backpack/Color.h>
#import <Backpack/Common.h>

#import "BPKTextDefinition.h"

NS_ASSUME_NONNULL_BEGIN
@interface BPKLabel ()

- (void)setupWithStyle:(BPKFontStyle)style;
@property(strong, nonatomic) NSMutableArray<BPKTextDefinition *> *persistentStyleRanges;

@end

@implementation BPKLabel

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

- (void)updateTextStyle {
    if (self.text == nil) {
        self.attributedText = nil;
        return;
    }

    NSMutableAttributedString *newAttributedString = [[BPKFont attributedStringWithFontStyle:self.fontStyle andColor:self.textColor onAttributedString:self.attributedText] mutableCopy];

    // Recreate the attributed string from the persisted definitions
    for (BPKTextDefinition *styleRange in self.persistentStyleRanges) {
        NSDictionary<NSAttributedStringKey, id> *newAttributes = [self getAttributesWithFontStyle:styleRange.fontStyle];
        [newAttributedString setAttributes:newAttributes range:styleRange.range];
    }

    super.attributedText = newAttributedString;
}

- (NSDictionary<NSAttributedStringKey, id> *)getAttributesWithFontStyle:(BPKFontStyle)fontStyle {
    if (self.textColor) {
        NSDictionary<NSAttributedStringKey, id> *customAttributes = @{NSForegroundColorAttributeName: self.textColor};
        return [BPKFont attributesForFontStyle:fontStyle withCustomAttributes:customAttributes];
    } else {
        return [BPKFont attributesForFontStyle:fontStyle];
    }
}

- (void)setText:(NSString *_Nullable)text {
    BPKAssertMainThread();

    [self.persistentStyleRanges removeAllObjects];

    [super setText:text];
    [self updateTextStyle];
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    _fontStyle = fontStyle;

    self.text = self.attributedText.string;
}

- (void)setFontStyle:(BPKFontStyle)fontStyle range:(NSRange)range {
    [_persistentStyleRanges addObject:[[BPKTextDefinition alloc] initWithFontStyle:fontStyle range:range]];

    NSMutableAttributedString *resultingString = [self.attributedText mutableCopy];
    NSDictionary<NSAttributedStringKey, id> *newAttributes = [self getAttributesWithFontStyle:fontStyle];
    [resultingString setAttributes:newAttributes range:range];

    [self setAttributedText:resultingString];
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.persistentStyleRanges = [[NSMutableArray alloc] init];
    self.fontStyle = style;
    self.textColor = BPKColor.textPrimaryColor;
}

@end
NS_ASSUME_NONNULL_END
