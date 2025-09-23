//
//  BPKRelativeFontDefinitionBeta.swift
//  Backpack
//
//  Created by Kynan Song on 23/09/2025.
//

import Foundation

@objcMembers
@objc(BPKRelativeFontDefinitionBeta)
public class BPKRelativeFontDefinitionBeta: NSObject, BPKFontDefinitionProtocol {
    public var heavyFontFace = "SkyscannerRelativeiOS-Black"
    public var fontFamily = "SkyscannerRelativeiOS"
    public var regularFontFace = "SkyscannerRelativeiOS-Book"
    public var semiboldFontFace = "SkyscannerRelativeiOS-Bold"
    public var blackFontFace = "SkyscannerRelativeiOS-Black"
   
    public override init() {}
}
