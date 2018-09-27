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
#import "BPKAlertView.h"

@class BPKAlertConfiguration;
@class BPKAlertFaderAction;
@class BPKAlertButtonAction;
@class BPKAlertDoneButtonAction;
@class BPKShadow;

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPKAlertActionItemHandler)(void);

typedef NS_ENUM(NSInteger, BPKAlertControllerStyle) {
    BPKAlertControllerStyleBottomSheet = 0,
    BPKAlertControllerStyleAlert
};

typedef NS_ENUM(NSInteger, BPKAlertControllerShadowStyle) {
    BPKAlertControllerShadowStyleNoShadow = 0,
    BPKAlertControllerShadowStyleShadow
};

NS_SWIFT_NAME(AlertController) @interface BPKAlertController: UIViewController<BPKAlertViewDelegate>

- (void)addButtonAction:(BPKAlertButtonAction *)action;
- (void)addFaderAction:(BPKAlertFaderAction *)action;
- (void)addDoneButtonAction:(BPKAlertDoneButtonAction *)action;

- (instancetype)init __attribute__((unavailable("init not available, use alertControllerWithTitle:message:style:shadow:headColor:iconImage: instead")));
+ (instancetype)alertControllerWithTitle:(NSString *)title
                                 message:(NSString *)message
                                   style:(BPKAlertControllerStyle)style
                             shadowStyle:(BPKAlertControllerShadowStyle)shadowStyle
                               headColor:(UIColor *)headColor
                               iconImage:(UIImage *)iconImage;

@end

NS_ASSUME_NONNULL_END
