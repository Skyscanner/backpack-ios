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

/*
 * Note that in some places we are having to resolve the correct UIColors from dynamic values ourselves to ensure
 * that we support overriding UIViewController interface styles. if we allow UIKit to resolve them for us,
 * it may do so wrongly.
 * This is because UIKit only sets the UIView's trait collection on a handful of lifecycle methods, and we
 * are using dynamic colours outside of these. If we do not manually resolve colours using self.traitCollection,
 * then UIKit will fall back to using [UITraitCollection currentTraitCollection] which does not reflect the override.
 */

#import "BPKTabBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKTabBarContoller : UITabBarController

@end

@implementation BPKTabBarContoller

@end

NS_ASSUME_NONNULL_END
