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

/**
 * The different styles of the Dialog.
 *
 */
typedef NS_ENUM(NSInteger, BPKDialogControllerStyle) {
    /**
     * A bottom sheet displayed at the bottom of the screen.
     * Suitable for confirming potential dangerous actions or
     * making choices.
     */
    BPKDialogControllerStyleBottomSheet = 0,

    /**
     * An alert style Dialog displaying its content in
     * the middle of the screen.
     */
    BPKDialogControllerStyleAlert
};

NS_ASSUME_NONNULL_END
