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
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Describes the button to show in a snackbar.
 */
@interface BPKSnackbarButton : NSObject

/**
 * The optional visible title that will be displayed.
 */
@property(nonatomic, copy, nullable, readonly) NSString *title;

/**
 * The optional icon that will be displayed
 */
@property(nonatomic, strong, nullable, readonly) UIImage *icon;

/**
 * The accessibility label that VoiceOver will read out for the button.
 */
@property(nonatomic, copy, nullable, readonly) NSString *accessibilityLabel;

/**
 * Whether the receiver will display an icon only button or not.
 */
@property(nonatomic, assign, readonly, getter=isIconOnly) BOOL iconOnly;

+ (instancetype)new __attribute__((unavailable("Use one of the factory methods")));
;
- (instancetype)init __attribute__((unavailable("Use one of the factory methods")));

/**
 * A button with only a textual title.
 *
 * @param title The title to use.
 * @return An instance that will display a text only button.
 */
+ (instancetype)buttonWithTitle:(NSString *)title;

/**
 * An icon only button with an accesssibility label for Voice Over.
 *
 * @param icon The icon to use.
 * @param accessibilityLabel The accessibiltiy label read out by VoiceOver.
 * @return An instance that will display a icon only button and be read out with VoiceOver.
 */
+ (instancetype)buttonWithIcon:(UIImage *)icon accessibilityLabel:(NSString *)accessibilityLabel;

/**
 * A button with an visible text with a specific
 * `accessibilityLabel`. Normally the `accessibilityLabel` would be
 * derived from the title but in this it's set explicitly. This is useful
 * when you want to provide different text to sighted user and VoiceOver users.
 *
 * @param title The visual title to u.se
 * @param accessibilityLabel The accessibility label read out by VoiceOver.
 * @return An instance that will display a text button with a custom
 *          label for VoiceOver.
 */
+ (instancetype)buttonWithTitle:(NSString *)title accessibilityLabel:(NSString *)accessibilityLabel;

@end
NS_ASSUME_NONNULL_END
