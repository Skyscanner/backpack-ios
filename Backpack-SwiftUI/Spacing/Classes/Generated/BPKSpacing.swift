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

public extension BPKSpacing {
    
    /// The Skyscanner none spacing (0pt).
    static var none: BPKSpacing { BPKSpacing(value: 0) }

    /// The Skyscanner small spacing (4pt).
    static var sm: BPKSpacing { BPKSpacing(value: 4) }

    /// The Skyscanner medium spacing (8pt).
    static var md: BPKSpacing { BPKSpacing(value: 8) }

    /// The Skyscanner icon text spacing (8pt).
    static var iconText: BPKSpacing { BPKSpacing(value: 8) }

    /// The Skyscanner base spacing (16pt).
    static var base: BPKSpacing { BPKSpacing(value: 16) }

    /// The Skyscanner large spacing (24pt).
    static var lg: BPKSpacing { BPKSpacing(value: 24) }

    /// The Skyscanner extra large spacing (32pt).
    static var xl: BPKSpacing { BPKSpacing(value: 32) }

    /// The Skyscanner extra extra large spacing (40pt).
    static var xxl: BPKSpacing { BPKSpacing(value: 40) }

    /// The Skyscanner extra extra extra large spacing (64pt).
    static var xxxl: BPKSpacing { BPKSpacing(value: 64) }

    /// The Skyscanner extra extra extra extra large spacing (96pt).
    static var xxxxl: BPKSpacing { BPKSpacing(value: 96) }
}
