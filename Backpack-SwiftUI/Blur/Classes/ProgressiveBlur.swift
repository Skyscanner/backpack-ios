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

func maskImageWithVaribleBlur(ciImage: CIImage, mask: CIImage, blurRadius: Float) -> CIImage {
    let clampFilter = ciImage.clampedToExtent()
    let blurFilter = CIFilter.maskedVariableBlur()
    blurFilter.inputImage = clampFilter
    blurFilter.mask = mask
    blurFilter.radius = blurRadius
    guard let blurred = blurFilter.outputImage else { return ciImage }

    let croppedBlurred = blurred.cropped(to: ciImage.extent)

    let blendFilter = CIFilter.blendWithMask()
    blendFilter.inputImage = croppedBlurred
    blendFilter.backgroundImage = ciImage
    blendFilter.maskImage = mask

    return blendFilter.outputImage ?? ciImage
}

func getImageMask(maskExtent: CGRect) -> CIImage {
    // Start with a smooth linear gradient
    let gradient = CIFilter.smoothLinearGradient()
    gradient.color0 = .white
    gradient.color1 = .black
    gradient.point0 = CGPoint(x: 0, y: 0)
    gradient.point1 = CGPoint(x: 0, y: maskExtent.height)
    let baseGradient = gradient.outputImage.unsafelyUnwrapped
        .cropped(to: maskExtent)

    // Apply a gamma curve to soften the transition (non-linear)
    let gammaFilter = CIFilter.gammaAdjust()
    gammaFilter.inputImage = baseGradient
    gammaFilter.power = 2.2  // Values > 1 = slower start, more gradual
    let softenedGradient = gammaFilter.outputImage.unsafelyUnwrapped

    return softenedGradient
}
