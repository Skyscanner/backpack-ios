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
#import <Backpack/Button.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPKAlertButtonActionHandler)(void);

NS_SWIFT_NAME(AlertButtonConfiguration) @interface BPKAlertButtonConfiguration : NSObject <NSCopying>

@property (nonatomic, readonly) BPKButtonStyle style;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) BPKAlertButtonActionHandler handler;

+ (instancetype _Nonnull)configurationWithStyle:(BPKButtonStyle)style title:(NSString *)title actionHandler:(BPKAlertButtonActionHandler)handler;

@end
NS_ASSUME_NONNULL_END
