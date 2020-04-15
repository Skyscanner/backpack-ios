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
#import "BPKSnackbarButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface BPKSnackbarButton()
@property(nonatomic, copy, nullable) NSString *title;
@property(nonatomic, strong, nullable) UIImage *icon;
@property(nonatomic, copy, nullable) NSString *accessibilityLabel;
@end

@implementation BPKSnackbarButton

- (BOOL)isIconOnly {
    return self.title.length == 0;
}

+ (instancetype)buttonWithTitle:(NSString *)title {
    BPKSnackbarButton *button = [[BPKSnackbarButton alloc] init];

    button.title = title;

    return button;
}

+ (instancetype)buttonWithIcon:(UIImage *)icon title:(NSString *)title {
    BPKSnackbarButton *button = [[BPKSnackbarButton alloc] init];

    button.title = title;
    button.icon = icon;

    return button;
}

+ (instancetype)buttonWithIcon:(UIImage *)icon accessibilityLabel:(NSString *)accessibilityLabel {
    BPKSnackbarButton *button = [[BPKSnackbarButton alloc] init];

    button.icon = icon;
    button.accessibilityLabel = accessibilityLabel;

    return button;
}

+ (instancetype)buttonWithIcon:(UIImage *)icon
                         title:(NSString *)title
            accessibilityLabel:(NSString *)accessibilityLabel {
    BPKSnackbarButton *button = [[BPKSnackbarButton alloc] init];

    button.icon = icon;
    button.title = title;
    button.accessibilityLabel = accessibilityLabel;

    return button;
}

@end

NS_ASSUME_NONNULL_END

