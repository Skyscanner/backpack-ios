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

#import "BPKButton.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 * `BPKLegacyLinkButton` is a subclass of `UIButton`. It's Deprecated and it should not be used. Please refer to `BPKButton` instead.
 */
IB_DESIGNABLE @interface BPKLegacyLinkButton : UIButton
/**
 * @deprecated use `BPKButton` instead
 * @see BPKButtonSize
 */
- (instancetype _Nonnull)initWithSize:(BPKButtonSize)size __deprecated_msg("Use BPKButton instead.");

@property(nonatomic, copy, nullable) NSString *title;

@property(nonatomic) BPKButtonSize size;

@property(nonatomic) BPKButtonImagePosition imagePosition;

@property(nonatomic) BOOL isLoading;

@property(nullable, nonatomic, strong) UIColor *linkContentColor UI_APPEARANCE_SELECTOR;

- (void)setImage:(UIImage *_Nullable)image;

@end
