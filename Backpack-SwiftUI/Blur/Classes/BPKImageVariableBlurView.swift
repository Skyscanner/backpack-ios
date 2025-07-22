//
//  BPKImageVariableBlurView.swift
//  Pods
//
//  Created by Ilkay Hamit on 22/07/2025.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

// swiftlint:disable indentation_width
public struct BPKImageVariableBlurView: View {
    @State private var image: UIImage?

    let imageName: String
    let blurRadius: Float
    let position: VariableBlurPosition
    let width: CGFloat
    let height: CGFloat
    let context = CIContext()

    public init(imageName: String, blurRadius: Float = 25.0, width: CGFloat,
                height: CGFloat, position: VariableBlurPosition = .bottom) {
        self.imageName = imageName
        self.blurRadius = blurRadius
        self.position = position
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
        .onChange(of: blurRadius) { _ in
            processBlur()
        }
    }

    private func processBlur() {
        guard let uiImage = UIImage(named: imageName) else { return }
        guard let ciImage = CIImage(image: uiImage) else { return }

        let originalExtent = ciImage.extent
        let imageMask = getImageMask(maskHeight: originalExtent.height, blurPosition: self.position)
        let blurredImage = maskImageWithVaribleBlur(ciImage: ciImage, mask: imageMask, blurRadius: self.blurRadius)

        let croppedImage = blurredImage.cropped(to: originalExtent)

        guard let cgImage = context.createCGImage(croppedImage, from: originalExtent) else { return }

        image = UIImage(cgImage: cgImage)
    }
}
