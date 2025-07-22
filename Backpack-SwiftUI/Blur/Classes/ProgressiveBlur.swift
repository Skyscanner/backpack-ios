/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2025 Skyscanner Ltd
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

import CoreImage.CIFilterBuiltins

public func maskImageWithProgressiveBlur(ciImage: CIImage, mask: CIImage, blurRadius: Float) -> CIImage {
    let filter = CIFilter.maskedVariableBlur()

    filter.inputImage = ciImage
    filter.mask = mask
    filter.radius = blurRadius

    return filter.outputImage!
}

func getImageMask(maskHeight: Double) -> CIImage {
    // Create a mask that goes from white to black vertically.
    let mask = CIFilter.smoothLinearGradient()
    mask.color0 = .white
    mask.color1 = .black
    mask.point0 = CGPoint(x: 0, y: 0)
    mask.point1 = CGPoint(x: 0, y: maskHeight)

    return mask.outputImage.unsafelyUnwrapped
}
