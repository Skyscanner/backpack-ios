/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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
 
import SwiftUI

struct BPKSliderHelpers {
    static func calculateNewValueFromDrag(
        value: DragGesture.Value,
        sliderSize: CGSize,
        thumbSize: CGFloat,
        sliderBounds: ClosedRange<Float>,
        step: Float
    ) -> Float {
        let sliderWidth = sliderSize.width
        let adjustedThumbPosition = value.location.x - (thumbSize / 2 + sliderWidth / 2)
        let percentageForPosition = adjustedThumbPosition / sliderWidth
        let newValue = Self.valueForPercentage(Float(percentageForPosition), sliderBounds: sliderBounds)
        return round(newValue / step) * step
    }

    static func percentageOfValue(value: Float, sliderBounds: ClosedRange<Float>) -> Float {
        let lowerBound = sliderBounds.lowerBound
        let upperBound = sliderBounds.upperBound
        return (value - lowerBound) / (upperBound - lowerBound)
    }

    static func valueForPercentage(_ percentage: Float, sliderBounds: ClosedRange<Float>) -> Float {
        let lowerBound = sliderBounds.lowerBound
        let upperBound = sliderBounds.upperBound
        return lowerBound + (upperBound - lowerBound) * percentage
    }
}
