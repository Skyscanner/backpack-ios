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

NS_ASSUME_NONNULL_BEGIN

@class BPKButtonAppearance;

/**
 * `BPKButtonAppearanceSet` is a subclass of `NSObject` that contains instances of `BPKButtonAppearance` for each state of the button.
 */
@interface BPKButtonAppearanceSet : NSObject

/**
 * The appearance of the button in it's default state.
 */
@property(nullable, nonatomic, strong) BPKButtonAppearance *regularAppearance;

/**
 * The appearance of the button in it's loading state.
 */
@property(nullable, nonatomic, strong) BPKButtonAppearance *loadingAppearance;

/**
 * The appearance of the button in it's disabled state.
 */
@property(nullable, nonatomic, strong) BPKButtonAppearance *disabledAppearance;

/**
 * The appearance of the button in it's highlighted state.
 */
@property(nullable, nonatomic, strong) BPKButtonAppearance *highlightedAppearance;

/*
 * Creates an instance of `BPKButtonAppearanceSet` with the values provided.
 */
- (instancetype)initWithRegularAppearance:(BPKButtonAppearance *)regularAppearance
                        loadingAppearance:(BPKButtonAppearance *)loadingAppearance
                       disabledAppearance:(BPKButtonAppearance *)disabledAppearance
                    highlightedAppearance:(BPKButtonAppearance *)highlightedAppearance;

/*
 * Creates an new instance of `BPKButtonAppearanceSet` with cloned appearances that match the current instance.
 */
- (instancetype)clone;

@end

NS_ASSUME_NONNULL_END
