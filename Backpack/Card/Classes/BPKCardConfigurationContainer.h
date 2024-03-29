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

#import "BPKCardConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * `BPKCardConfigurationContainer` is the default interaction style. Assistive technology will not see the outer container, just the individual items
 * inside The action caused by pressing the button should be made available to AT by a child element.
 */
@interface BPKCardConfigurationContainer : BPKCardConfiguration

@end

NS_ASSUME_NONNULL_END
