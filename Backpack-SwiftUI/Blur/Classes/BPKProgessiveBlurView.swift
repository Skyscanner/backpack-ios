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
public struct BPKProgessiveBlurView: View {
    @State private var image: UIImage?

    private let imageName: String
    private let blurRadius: Float
    private let width: CGFloat
    private let height: CGFloat
    private let context = CIContext()

    public init(imageName: String, blurRadius: Float, width: CGFloat,
                height: CGFloat) {
        self.imageName = imageName
        self.blurRadius = blurRadius
        self.width = width
        self.height = height
    }

    public var body: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width, height: height)
            }
        }
        .onAppear {
            processBlur()
        }
    }

    private func processBlur() {
        guard let uiImage = UIImage(named: imageName) else { return }
        guard let ciImage = CIImage(image: uiImage) else { return }

        let originalExtent = ciImage.extent
        let imageMask = getImageMask(maskHeight: originalExtent.height)
        let blurredImage = maskImageWithProgressiveBlur(ciImage: ciImage, mask: imageMask, blurRadius: self.blurRadius)

        let croppedImage = blurredImage.cropped(to: originalExtent)

        guard let cgImage = context.createCGImage(croppedImage, from: originalExtent) else { return }

        image = UIImage(cgImage: cgImage)
    }
}
