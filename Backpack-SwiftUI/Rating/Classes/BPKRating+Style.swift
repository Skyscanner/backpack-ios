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
import Backpack_Common

extension BPKRating {

    struct FontStyles {
        let ratingValueLabelFontStyle: BPKFontStyle
        let ratingScaleLabelFontStyle: BPKFontStyle
        let titleLabelFontStyle: BPKFontStyle
        let subtitleLabelFontStyle: BPKFontStyle
    }

    public enum Size {
        case `default`
        case large

        var fontStyle: FontStyles {
            switch self {
            case .default:
                return FontStyles(
                    ratingValueLabelFontStyle: .label1,
                    ratingScaleLabelFontStyle: .caption,
                    titleLabelFontStyle: .label1,
                    subtitleLabelFontStyle: .caption
                )
            case .large:
                return FontStyles(
                    ratingValueLabelFontStyle: .hero5,
                    ratingScaleLabelFontStyle: .bodyDefault,
                    titleLabelFontStyle: .heading5,
                    subtitleLabelFontStyle: .bodyDefault
                )
            }
        }
    }

    // A local enum wrapper to avoid the need for importing Backpack_Common when using BPKRating
    public enum Scale {
        case zeroToFive
        case zeroToTen

        private var commonScale: BPKCommonRatingScale {
            switch self {
            case .zeroToTen:
                return .zeroToTen
            case .zeroToFive:
                return .zeroToFive
            }
        }

        public func displayedValue(from value: Float) -> String {
            return commonScale.displayedValue(from: value)
        }

        public func displayedScale() -> String {
            return commonScale.displayedScale()
        }
    }
}
