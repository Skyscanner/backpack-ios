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
import SwiftUI

// swiftlint:disable indentation_width
/// A SwiftUI view that displays an image with progressive blur effect.
/// Progressive blur creates a variable blur effect across the image, typically used
/// for creating depth or focus effects where parts of the image are more blurred than others.
public struct BPKProgessiveBlurView: View {
    /// The processed image with progressive blur applied. Initially nil until processing completes.
    @State private var image: UIImage?

    /// The name of the image to load from the app bundle
    private let imageName: String
    
    /// The blur radius value used for the progressive blur effect (24 points)
    private let blurRadius: Float = 24
    
    /// The desired width for the displayed image
    private let width: CGFloat
    
    /// The desired height for the displayed image
    private let height: CGFloat
    
    /// Core Image context used for image processing operations
    private let context = CIContext()

    /// Initializes a new progressive blur view
    /// - Parameters:
    ///   - imageName: The name of the image file in the app bundle
    ///   - width: The width to display the image at
    ///   - height: The height to display the image at
    public init(imageName: String, width: CGFloat,
                height: CGFloat) {
        self.imageName = imageName
        self.width = width
        self.height = height
    }

    public var body: some View {
        VStack {
            // Display the processed image if available
            if let image = image {
                Image(uiImage: image)
                    .resizable() // Allow the image to be resized
                    .scaledToFit() // Maintain aspect ratio while fitting in frame
                    .cornerRadius(12) // Apply rounded corners with 12pt radius
                    .frame(width: width, height: height) // Set the display dimensions
            }
        }
        .onAppear {
            // Process the blur effect when the view first appears
            processBlur()
        }
    }

    /// Processes the image to apply progressive blur effect
    /// This method loads the source image, creates a mask for variable blur intensity,
    /// and applies the progressive blur effect using Core Image filters.
    private func processBlur() {
        // Load the source image from the app bundle
        guard let uiImage = UIImage(named: imageName) else { return }
        
        // Convert UIImage to CIImage for Core Image processing
        guard let ciImage = CIImage(image: uiImage) else { return }

        // Create a mask that defines the blur intensity across different areas of the image
        // NOTE: This method is missing from the current implementation
        let imageMask = getImageMask(maskExtent: ciImage.extent)
        
        // Apply variable blur using the mask - areas with different mask values get different blur amounts
        // NOTE: This method is missing from the current implementation  
        let blurredImage = maskImageWithVaribleBlur(ciImage: ciImage, mask: imageMask, blurRadius: self.blurRadius)
        
        // Convert the processed CIImage back to CGImage
        guard let cgImage = context.createCGImage(blurredImage, from: blurredImage.extent) else { return }
        
        // Update the UI with the processed image
        image = UIImage(cgImage: cgImage)
    }
}
