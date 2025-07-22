//
//  BPKVariableBlur.swift
//  Pods
//
//  Created by Ilkay Hamit on 22/07/2025.
//

import CoreImage.CIFilterBuiltins

public enum VariableBlurPosition {
    case top, bottom

    var colors: [CIColor] {
        switch self {
        case .top:
            return [.black, .white]
        case .bottom:
            return [.white, .black]
        }
    }
}

public func maskImageWithVaribleBlur(ciImage: CIImage, mask: CIImage, blurRadius: Float) -> CIImage {
    let filter = CIFilter.maskedVariableBlur()

    filter.inputImage = ciImage
    filter.mask = mask
    filter.radius = blurRadius

    return filter.outputImage!
}

func getImageMask(maskHeight: Double, blurPosition: VariableBlurPosition) -> CIImage {
    // Create a mask that goes from white to black vertically.
    let mask = CIFilter.smoothLinearGradient()
    mask.color0 = blurPosition.colors[0]
    mask.color1 = blurPosition.colors[1]
    mask.point0 = CGPoint(x: 0, y: 0)
    mask.point1 = CGPoint(x: 0, y: maskHeight)

    return mask.outputImage.unsafelyUnwrapped
}
