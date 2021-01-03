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

NS_ASSUME_NONNULL_BEGIN

@interface BPKTappableLinkDefinition : NSObject

@property(readonly) NSRange range;
@property(readonly, strong, nullable) NSURL *url;
@property(readonly, strong, nullable) NSDictionary *components;
@property(readonly) BOOL hasURLDefinition;
@property(readonly) BOOL hasTransitInformationDefinition;

- (instancetype)initWithURL:(NSURL *)url range:(NSRange)range;
- (instancetype)initWithTransitInformation:(NSDictionary *)components range:(NSRange)range;

@end
NS_ASSUME_NONNULL_END
