/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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

#import <TTTAttributedLabel/TTTAttributedLabel.h>

#import <Backpack/Color.h>
#import <Backpack/Common.h>
#import <Backpack/Font.h>

#import "BPKTappableLinkDefinition.h"

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

- (BPKFontStyle)linkFontStyle {
    return self.style == BPKTappableLinkLabelStyleAlternate ? [self getEmphasizedFontStyleFor:self.fontStyle]
                                                            : self.fontStyle;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self updateTextColors];
}

- (NSDictionary *)customFontAttributes {
    if (self.style == BPKTappableLinkLabelStyleAlternate) {
        return @{NSForegroundColorAttributeName: BPKColor.white};
    } else if (_textColor) {
        return @{NSForegroundColorAttributeName: _textColor};
    }
    return @{};
}

- (UIColor *)linkDisplayColor {
    if (self.style == BPKTappableLinkLabelStyleAlternate) {
        return BPKColor.white;
    }

    return _linkColor != nil ? _linkColor : BPKColor.primaryColor;
}

- (void)updateTextColors {
    NSDictionary *linkCustomAttributes = @{
        NSForegroundColorAttributeName: self.linkDisplayColor,
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)
    };
    self.contentView.linkAttributes = [BPKFont attributesForFontStyle:self.linkFontStyle
                                                 withCustomAttributes:linkCustomAttributes];

    NSDictionary *activeLinkCustomAttributes = @{
        NSForegroundColorAttributeName: [self.linkDisplayColor colorWithAlphaComponent:0.2],
        NSUnderlineStyleAttributeName: @(NSUnderlineStyleNone)
    };
    self.contentView.activeLinkAttributes = [BPKFont attributesForFontStyle:self.linkFontStyle
                                                       withCustomAttributes:activeLinkCustomAttributes];

    [self updateTextDisplay];
}

- (void)updateTextDisplay {
    if (self.text == nil) {
        self.contentView.text = nil;
        return;
    }

    NSDictionary<NSAttributedStringKey, id> *newStringAttributes =
        [BPKFont attributesForFontStyle:self.fontStyle withCustomAttributes:self.customFontAttributes];

    NSAttributedString *newString = [[NSAttributedString alloc] initWithString:self.text
                                                                    attributes:newStringAttributes];
    self.contentView.text = newString;

    // Note: we have to set the font on our TTTAttributedLabel as this is what will be used in calculating its size.
    self.contentView.font = newStringAttributes[NSFontAttributeName];

    // Re-apply the links
    for (BPKTappableLinkDefinition *linkDefinition in _persistedLinks) {
        if (linkDefinition.hasURLDefinition) {
            [self.contentView addLinkToURL:linkDefinition.url withRange:linkDefinition.range];
        } else if (linkDefinition.hasTransitInformationDefinition) {
            [self.contentView addLinkToTransitInformation:linkDefinition.components withRange:linkDefinition.range];
        } else {
            NSAssert(NO, @"A Tappable Link definition must either have a URL or have transit information.");
        }
    }
}

- (instancetype)addLinkToURL:(NSURL *)url withRange:(NSRange)range {
    [_persistedLinks addObject:[[BPKTappableLinkDefinition alloc] initWithURL:url range:range]];

    [self.contentView addLinkToURL:url withRange:range];
    return self;
}

- (instancetype)addLinkToTransitInformation:(NSDictionary *)components withRange:(NSRange)range {
    [_persistedLinks addObject:[[BPKTappableLinkDefinition alloc] initWithTransitInformation:components range:range]];

    [self.contentView addLinkToTransitInformation:components withRange:range];
    return self;
}

- (void)setText:(NSString *_Nullable)text {
    BPKAssertMainThread();
    if (_text != text) {
        [self.persistedLinks removeAllObjects];
        _text = [text copy];

        [self updateTextDisplay];
    }
}

- (void)setFontStyle:(BPKFontStyle)fontStyle {
    BPKAssertMainThread();
    if (_fontStyle != fontStyle) {
        _fontStyle = fontStyle;

        [self updateTextColors];
    }
}

- (void)setLinkColor:(UIColor *_Nullable)linkColor {
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

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    if (self.contentView.numberOfLines != numberOfLines) {
        self.contentView.numberOfLines = numberOfLines;
    }
}

- (NSInteger)numberOfLines {
    return self.contentView.numberOfLines;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (self.contentView.textAlignment != textAlignment) {
        self.contentView.textAlignment = textAlignment;
    }
}

- (NSTextAlignment)textAlignment {
    return self.contentView.textAlignment;
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (self.contentView.lineBreakMode != lineBreakMode) {
        self.contentView.lineBreakMode = lineBreakMode;
    }
}

- (NSLineBreakMode)lineBreakMode {
    return self.contentView.lineBreakMode;
}

#pragma BPKTappableLinkLabelDelegate

- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url {
    if ([self.delegate respondsToSelector:@selector(tappableLabel:didSelectLinkWithURL:)]) {
        [self.delegate tappableLabel:label didSelectLinkWithURL:url];
    } else if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithURL:)]) {
        [self.delegate attributedLabel:label didSelectLinkWithURL:url];
    }
}

- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if ([self.delegate respondsToSelector:@selector(tappableLabel:didSelectLinkWithTransitInformation:)]) {
        [self.delegate tappableLabel:label didSelectLinkWithTransitInformation:components];
    } else if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithTransitInformation:)]) {
        [self.delegate attributedLabel:label didSelectLinkWithTransitInformation:components];
    }
}

@end

NS_ASSUME_NONNULL_END
