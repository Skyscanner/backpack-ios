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

@class BPKSnackbar;

/**
 *  Cause for a snackbar being dismissed.
 */
typedef NS_ENUM(NSInteger, BPKSnackbarDismissCause) {
    /**
     * The snackbar was dismissed using `dismiss` method on the snackbar.
     */
    BPKSnackbarDismissCauseNone,

    /**
     * The user tapped the action button in the snackbar.
     */
    BPKSnackbarDismissCauseActionButton,

    /**
     * The snackbar was displayed for the full duration and then dismissed automatically.
     */
    BPKSnackbarDismissCauseDuration
};

/**
 * Methods for being notified when the display of a snackbar changes
 * for example when it is dimissed.
 */
@protocol BPKSnackbarDelegate

/**
 * Called when the snackbar is dismissed for any reason.
 *
 * @param snackbar The snackbar that is being dismissed
 * @param cause The reason snackbar is being dismissed.
 */
- (void)snackbar:(BPKSnackbar *)snackbar dismissedWithCause:(BPKSnackbarDismissCause)cause;

@end
