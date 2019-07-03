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
@class BPKTappableLinkLabel;
@protocol BPKTappableLinkLabelDelegate<NSObject>

@optional

/*
 * DEPRECATED
 */
- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url;

/*
 * DEPRECATED
 */
- (void)attributedLabel:(BPKTappableLinkLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components;

/*
 * Tells the delegate that the user did select a link to a URL.
 *
 * @param label The label whose link was selected.
 * @param url The URL for the selected link.
 */
- (void)tappableLabel:(BPKTappableLinkLabel *)label didSelectLinkWithURL:(NSURL *)url;

/*
 * Tells the delegate that the user did select a link to transit information
 *
 * @param label The label whose link was selected.
 * @param components A dictionary containing the transit components. The currently supported keys are `NSTextCheckingAirlineKey` and `NSTextCheckingFlightKey`.
 */
- (void)tappableLabel:(BPKTappableLinkLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components;

@end

NS_ASSUME_NONNULL_END
