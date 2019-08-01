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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BPKHorizontalNavigation;
@protocol BPKHorizontalNavigationDelegate <NSObject>

@optional

/*
 * DEPRECATED
 */
- (void)horizontalNavigation:(BPKHorizontalNavigation *)horizontalNavigation didSelectItem:(NSInteger)index;

/*
 * Tells the delegate that the user has selected one of the horizontal navigation options.
 *
 * @param horizontalNavigation The `BPKHorizontalNavigation` which has been interacted with.
 * @param index The index of the option selected by the user.
 * @param tag The tag of the option selected by the user.
 */
- (void)horizontalNavigation:(BPKHorizontalNavigation *)horizontalNavigation
               didSelectItem:(NSInteger)index
                     withTag:(NSInteger)tag;

@end
NS_ASSUME_NONNULL_END
