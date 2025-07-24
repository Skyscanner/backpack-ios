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

/// Applies variable blur to an image using a mask to control blur intensity across different regions.
/// This creates a progressive blur effect where different parts of the image have different blur amounts.
/// - Parameters:
///   - ciImage: The source image to apply blur to
///   - mask: A grayscale mask where white areas get maximum blur, black areas remain sharp, and gray areas get proportional blur
///   - blurRadius: The maximum blur radius to apply (white areas of the mask get this full amount)
/// - Returns: The image with variable blur applied, blended with the original for natural transitions
func maskImageWithVaribleBlur(ciImage: CIImage, mask: CIImage, blurRadius: Float) -> CIImage {
    // Extend the image edges to prevent edge artifacts during blur processing
    let clampFilter = ciImage.clampedToExtent()
    
    // Create the variable blur filter that uses the mask to control blur intensity
    let blurFilter = CIFilter.maskedVariableBlur()
    blurFilter.inputImage = clampFilter // Use the edge-extended image
    blurFilter.mask = mask // The mask controls where and how much blur is applied
    blurFilter.radius = blurRadius // Maximum blur radius for white areas of the mask
    guard let blurred = blurFilter.outputImage else { return ciImage }

    // Crop the blurred result back to the original image dimensions to remove extended edges
    let croppedBlurred = blurred.cropped(to: ciImage.extent)

    // Blend the blurred image with the original using the same mask for smooth transitions
    let blendFilter = CIFilter.blendWithMask()
    blendFilter.inputImage = croppedBlurred // The blurred version
    blendFilter.backgroundImage = ciImage // The original sharp image
    blendFilter.maskImage = mask // Same mask determines blending ratio

    return blendFilter.outputImage ?? ciImage
}

/// Creates a gradient mask for progressive blur effect.
/// The mask defines which areas of the image should be blurred and by how much.
/// - Parameter maskExtent: The dimensions of the mask, typically matching the source image size
/// - Returns: A CIImage mask where white areas will receive maximum blur and black areas remain sharp
func getImageMask(maskExtent: CGRect) -> CIImage {
    // Create a smooth linear gradient from white (top) to black (bottom)
    let gradient = CIFilter.smoothLinearGradient()
    gradient.color0 = .white // Top of image gets maximum blur (white = full blur)
    gradient.color1 = .black // Bottom of image stays sharp (black = no blur)
    gradient.point0 = CGPoint(x: 0, y: 0) // Start point at top-left
    gradient.point1 = CGPoint(x: 0, y: maskExtent.height) // End point at bottom-left (vertical gradient)
    
    // Crop the infinite gradient to match the image dimensions
    let baseGradient = gradient.outputImage.unsafelyUnwrapped
        .cropped(to: maskExtent)

    // Apply gamma correction to create a more natural, non-linear transition
    let gammaFilter = CIFilter.gammaAdjust()
    gammaFilter.inputImage = baseGradient
    gammaFilter.power = 0.5 // Values < 1 create slower initial transition, then faster (softer curve)
    let softenedGradient = gammaFilter.outputImage.unsafelyUnwrapped

    return softenedGradient
}