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
#import "BPKDialogView.h"

@class BPKDialogConfiguration;
@class BPKDialogScrimAction;
@class BPKDialogButtonAction;
@class BPKDialogDoneButtonAction;
@class BPKShadow;

NS_ASSUME_NONNULL_BEGIN

typedef void (^BPKDialogActionItemHandler)(void);

typedef NS_ENUM(NSInteger, BPKDialogControllerStyle) {
    BPKDialogControllerStyleBottomSheet = 0,
    BPKDialogControllerStyleAlert
};

typedef NS_ENUM(NSInteger, BPKDialogControllerShadowStyle) {
    BPKDialogControllerShadowStyleNoShadow = 0,
    BPKDialogControllerShadowStyleShadow
};

NS_SWIFT_NAME(DialogController) @interface BPKDialogController: UIViewController<BPKDialogViewDelegate>

- (void)addButtonAction:(BPKDialogButtonAction *)action NS_SWIFT_NAME(addButtonAction(_:));
- (void)addScrimAction:(BPKDialogScrimAction *)action NS_SWIFT_NAME(addScrimAction(_:));

- (instancetype)init __attribute__((unavailable("init not available, use alertControllerWithTitle:message:style:shadow:headColor:iconImage: instead")));
+ (instancetype)dialogControllerWithTitle:(NSString *)title
                                  message:(NSString *)message
                                    style:(BPKDialogControllerStyle)style
                              shadowStyle:(BPKDialogControllerShadowStyle)shadowStyle
                                headColor:(UIColor *)headColor
                                iconImage:(UIImage *)iconImage;

@end

NS_ASSUME_NONNULL_END
