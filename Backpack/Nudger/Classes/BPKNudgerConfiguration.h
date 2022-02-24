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

NS_ASSUME_NONNULL_BEGIN

typedef NSString *_Nonnull (^BPKNudgerValueFormatter)(double value);

@interface BPKNudgerConfiguration : NSObject

/**
 * The label describing the value controlled by the nudger.
 */
@property(nonatomic, strong, readonly) NSString *label;

/**
 * The formatter used for the visible label.
 */
@property(nonatomic, strong, readonly) BPKNudgerValueFormatter valueFormatter;

/**
 * Create a `BPKNudgerConfiguration` with the given formatters.
 *
 * @param label The label describing the value controlled by the nudger.
 * @param valueFormatter The formatter used for the visible label.
 */
- (instancetype)initWithLabel:(NSString *)label valueFormatter:(BPKNudgerValueFormatter)valueFormatter;

/// :nodoc:
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
