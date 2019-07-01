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

#import "BPKLabel.h"
#import "BPKTextDefinition.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>

NS_ASSUME_NONNULL_BEGIN
@interface BPKLabel ()

- (void)setupWithStyle:(BPKFontStyle)style;
@property(strong) NSMutableArray<BPKTextDefinition *> *persistedText;

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

    NSMutableAttributedString *newAttributedString = [[NSMutableAttributedString alloc]init];

    // Recreate the attributed string from the persisted definitions
    for (BPKTextDefinition *textDefinition in self.persistedText) {
        NSAttributedString *attributedString = [self getAttributedStringWithFontStyle:textDefinition.fontStyle text:textDefinition.text];
        [newAttributedString appendAttributedString:attributedString];
    }

    super.attributedText = newAttributedString;
}

- (NSAttributedString *)getAttributedStringWithFontStyle:(BPKFontStyle)fontStyle text:(NSString *)text {
    if (self.textColor) {
        return [BPKFont attributedStringWithFontStyle:fontStyle
                                              content:text
                                            textColor:self.textColor
                                          fontMapping:self.fontMapping];
    } else {
        return [BPKFont attributedStringWithFontStyle:fontStyle
                                              content:text
                                          fontMapping:self.fontMapping];
    }
}

- (void)setText:(NSString *_Nullable)text {
    BPKAssertMainThread();

    [self.persistedText removeAllObjects];
    [self.persistedText addObject:[[BPKTextDefinition alloc] initWithText:text fontStyle:self.fontStyle]];

    [super setText:text];
    [self updateTextStyle];
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    _fontStyle = fontStyle;

    self.text = self.attributedText.string;

    [self.persistedText removeAllObjects];
    [self.persistedText addObject:[[BPKTextDefinition alloc] initWithText:self.text fontStyle:fontStyle]];
}

- (void)setFontMapping:(BPKFontMapping *_Nullable)fontMapping {
    if (_fontMapping != fontMapping) {
        _fontMapping = fontMapping;

        [self updateTextStyle];
    }
}

- (void)appendText:(NSString *)text withFontStyle:(BPKFontStyle)fontStyle {
    [_persistedText addObject:[[BPKTextDefinition alloc] initWithText:text fontStyle:fontStyle]];

    NSAttributedString *currentText = self.attributedText;
    NSAttributedString *newText = [BPKFont attributedStringWithFontStyle:fontStyle content:text fontMapping:self.fontMapping];
    NSMutableAttributedString *resultingString = [[NSMutableAttributedString alloc] init];
    [resultingString appendAttributedString:currentText];
    [resultingString appendAttributedString:newText];

    [self setAttributedText:resultingString];
}

- (void)insertText:(NSString *)text atIndex:(int)index withFontStyle:(BPKFontStyle)fontStyle {
    [self insertTextDefinition:[[BPKTextDefinition alloc] initWithText:text fontStyle:fontStyle] atIndex:index];

    NSAttributedString *currentText = self.attributedText;
    NSAttributedString *newText = [BPKFont attributedStringWithFontStyle:fontStyle content:text fontMapping:self.fontMapping];
    NSMutableAttributedString *resultingString = [[NSMutableAttributedString alloc] init];
    [resultingString appendAttributedString:currentText];
    [resultingString insertAttributedString:newText atIndex:index];

    [self setAttributedText:resultingString];
}

- (void)insertTextDefinition:(BPKTextDefinition *)newTextDefinition atIndex:(int)index {
    NSMutableArray<BPKTextDefinition *> *newPersistedText = [[NSMutableArray alloc] init];

    int cumulativeLength = 0;
    Boolean inserted = NO;
    for (BPKTextDefinition *textDefinition in self.persistedText) {
        if(inserted) {
            [newPersistedText addObject:textDefinition ];
        }else if(cumulativeLength == index) {
            [newPersistedText addObject:newTextDefinition ];
            inserted = YES;
            [newPersistedText addObject:textDefinition];
        } else if (cumulativeLength + textDefinition.text.length <= index) {
            [newPersistedText addObject:textDefinition ];
        } else {
            NSArray<BPKTextDefinition *> *splitTextDefinition = [textDefinition splitAtIndex:index-cumulativeLength];
            [newPersistedText addObject:[splitTextDefinition objectAtIndex:0] ];
            [newPersistedText addObject:newTextDefinition ];
            inserted = YES;
            [newPersistedText addObject:[splitTextDefinition objectAtIndex:1] ];
        }
        cumulativeLength += textDefinition.text.length;
    }
    self.persistedText = newPersistedText;
}

#pragma mark - Private

- (void)setupWithStyle:(BPKFontStyle)style {
    self.persistedText = [[NSMutableArray alloc] init];
    self.fontStyle = style;
    self.textColor = BPKColor.gray700;
}

@end
NS_ASSUME_NONNULL_END
