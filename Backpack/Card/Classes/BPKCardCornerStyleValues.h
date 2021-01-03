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

/**
 * Enum values for specifying corner style
 */
typedef NS_ENUM(NSUInteger, BPKCardCornerStyle) {
    /**
     * Small corner radius style.
     */
    BPKCardCornerStyleSmall = 0,

    /**
     * Large corner radius style.
     */
    BPKCardCornerStyleLarge = 1,
};

/**
 * The default corner-style that is applied to the card when none is specified.
 */
FOUNDATION_EXPORT BPKCardCornerStyle const BPKCardDefaultCornerStyle;
