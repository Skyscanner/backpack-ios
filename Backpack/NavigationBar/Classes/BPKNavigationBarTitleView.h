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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const CGFloat BPKNavigationBarTitleHeight;

NS_ASSUME_NONNULL_BEGIN
@class BPKLabel;
@interface BPKNavigationBarTitleView : UIView
@property(nonatomic, strong, readonly) BPKLabel *titleLabel;

@property(nonatomic, assign) BOOL showsContent;

- (instancetype)init __attribute__((unavailable("use initWithFrame: instead")));
- (instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("use initWithFrame: instead")));

- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
