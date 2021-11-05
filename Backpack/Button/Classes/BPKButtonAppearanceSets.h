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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BPKButtonAppearanceSet;

/**
 * `BPKButtonAppearanceSets` is a subclass of `NSObject` containing multiple instances of `BPKButtonAppearanceSet` - one for each button style.
 */
IB_DESIGNABLE @interface BPKButtonAppearanceSets : UIButton

/*
 * Appearance set for the primary button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *primary;

/*
 * Appearance set for the secondary button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *secondary;

/*
 * Appearance set for the destructive button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *destructive;

/*
 * Appearance set for the featured button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *featured;

/*
 * Appearance set for the link button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *link;

/*
 * Appearance set for the outline button style.
 */
@property(class, readonly) BPKButtonAppearanceSet *outline;

@end

NS_ASSUME_NONNULL_END
