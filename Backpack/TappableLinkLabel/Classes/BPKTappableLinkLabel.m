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
#import "BPKTappableLinkLabel.h"
#import "BPKTappableLinkDefinition.h"
#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPKTappableLinkLabel () <TTTAttributedLabelDelegate>

@property(readonly, strong) NSMutableArray<BPKTappableLinkDefinition *> *persistedLinks;
@property(readonly, strong) TTTAttributedLabel *contentView;

@end

@implementation BPKTappableLinkLabel

- (instancetype)initWithFontStyle:(BPKFontStyle)style {
    BPKAssertMainThread();
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupWithStyle:style];
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

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    BPKAssertMainThread();
    self = [super initWithCoder:aDecoder];

    if (self) {
        [self setupWithStyle:BPKFontStyleTextBase];
    }

    return self;
}

- (void)setupWithStyle:(BPKFontStyle)style {
    _persistedLinks = [[NSMutableArray alloc] init];
    _fontStyle = style;
    _contentView = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    _linkColor = BPKColor.blue500;
    _style = BPKTappableLinkLabelStyleDefault;
    self.contentView.delegate = self;

    [self addSubview:self.contentView];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
        [self.contentView.topAnchor constraintEqualToAnchor:self.topAnchor],
        [self.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor]
    ]];

    // This initial call to set up colours is needed in case there is no theme initially applied
    [self updateTextColors];
}

- (void)resetLinks {
    [self.persistedLinks removeAllObjects];
}

- (BPKFontStyle)getEmphasizedFontStyleFor:(BPKFontStyle)fontStyle {
    switch (fontStyle) {
    case BPKFontStyleTextCaps:
        return BPKFontStyleTextCapsEmphasized;
    case BPKFontStyleTextXs:
        return BPKFontStyleTextXsEmphasized;
    case BPKFontStyleTextSm:
        return BPKFontStyleTextSmEmphasized;
    case BPKFontStyleTextBase:
        return BPKFontStyleTextBaseEmphasized;
    case BPKFontStyleTextLg:
        return BPKFontStyleTextLgEmphasized;
    case BPKFontStyleTextXl:
        return BPKFontStyleTextXlEmphasized;
    case BPKFontStyleTextXxl:
        return BPKFontStyleTextXxlEmphasized;
    case BPKFontStyleTextXxxl:
        return BPKFontStyleTextXxxlEmphasized;
    case BPKFontStyleTextXlEmphasized:
        return BPKFontStyleTextXlHeavy;
    case BPKFontStyleTextXxlEmphasized:
        return BPKFontStyleTextXxlHeavy;
    case BPKFontStyleTextXxxlEmphasized:
        return BPKFontStyleTextXxxlHeavy;
    default:
        NSAssert(
            NO, @"Alternate style BPKTappableLinkLabels must have a more emphasized alternative to the fontStyle set.");
    }
    return fontStyle;
}

- (void)updateTextColors {
    UIColor *linkColor = self.style == BPKTappableLinkLabelStyleAlternate ? BPKColor.white : self.linkColor;
    BPKFontStyle fontStyle = self.style == BPKTappableLinkLabelStyleAlternate
                                 ? [self getEmphasizedFontStyleFor:self.fontStyle]
                                 : self.fontStyle;

    NSDictionary *linkCustomAttributes =
        @{NSForegroundColorAttributeName: linkColor, NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)};
    self.contentView.linkAttributes = [BPKFont attributesForFontStyle:fontStyle
                                                 withCustomAttributes:linkCustomAttributes
                                                          fontMapping:self.fontMapping];

    NSDictionary *activeLinkCustomAttributes = @{
        NSForegroundColorAttributeName: [linkColor colorWithAlphaComponent:0.2],
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)
    };
    self.contentView.activeLinkAttributes = [BPKFont attributesForFontStyle:fontStyle
                                                       withCustomAttributes:activeLinkCustomAttributes
                                                                fontMapping:self.fontMapping];

    [self updateTextDisplay];
}

- (void)updateTextDisplay {
    if (self.text == nil) {
        self.contentView.text = nil;
        return;
    }

    NSDictionary *customAttributes =
        self.style == BPKTappableLinkLabelStyleAlternate ? @{NSForegroundColorAttributeName: BPKColor.white} : @{};
    NSDictionary<NSAttributedStringKey, id> *defaultAttributes = [BPKFont attributesForFontStyle:self.fontStyle
                                                                            withCustomAttributes:customAttributes
                                                                                     fontMapping:self.fontMapping];

    NSAttributedString *newString = [[NSAttributedString alloc] initWithString:self.text attributes:defaultAttributes];
    self.contentView.text = newString;

    // Re-apply the links
    for (BPKTappableLinkDefinition *linkDefinition in _persistedLinks) {
        [self.contentView addLinkToURL:linkDefinition.url withRange:linkDefinition.range];
    }
}

- (instancetype)addLinkToURL:(NSURL *)url withRange:(NSRange)range {
    [_persistedLinks addObject:[[BPKTappableLinkDefinition alloc] initWithURL:url range:range]];

    [self.contentView addLinkToURL:url withRange:range];
    return self;
}

- (void)setText:(NSString *_Nullable)text {
    BPKAssertMainThread();
    if (_text != text) {
        [self resetLinks];
        _text = [text copy];

        [self updateTextDisplay];
    }
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    if (_fontStyle != fontStyle) {
        _fontStyle = fontStyle;

        [self updateTextDisplay];
    }
}

- (void)setFontMapping:(BPKFontMapping *_Nullable)fontMapping {
    if (_fontMapping != fontMapping) {
        _fontMapping = fontMapping;

        [self updateTextDisplay];
    }
}

- (void)setLinkColor:(UIColor *)linkColor {
    if (_linkColor != linkColor) {
        _linkColor = linkColor;

        [self updateTextColors];
    }
}

- (void)setStyle:(BPKTappableLinkLabelStyle)style {
    if (_style != style) {
        _style = style;

        [self updateTextColors];
    }
}

- (CGSize)size {
    return _contentView.attributedText.size;
}

#pragma BPKTappableLinkLabelDelegate

- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if (self.delegate != nil) {
        [self.delegate attributedLabel:label didSelectLinkWithURL:url];
    }
}

@end

NS_ASSUME_NONNULL_END
