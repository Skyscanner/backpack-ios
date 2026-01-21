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

import Foundation

@objc public protocol BPKFontDefinitionProtocol: NSObjectProtocol {
    var fontFamily: NSString { get }
    var regularFontFace: NSString { get }
    var semiboldFontFace: NSString { get }
    var blackFontFace: NSString { get }
    var heavyFontFace: NSString { get }
    
}

public class BPKRelativeFontDefinition: NSObject, BPKFontDefinitionProtocol {
    public let fontFamily: NSString = "SkyscannerRelativeiOS"
    public let regularFontFace: NSString = "SkyscannerRelativeiOS-Book"
    public let semiboldFontFace: NSString = "SkyscannerRelativeiOS-Bold"
    public let blackFontFace: NSString = "SkyscannerRelativeiOS-Black"
    public var heavyFontFace: NSString = "SkyscannerRelativeiOS-Black"

    public override init() {}
}

public class BPKRelativeFontDefinitionBeta: NSObject, BPKFontDefinitionProtocol {
    public var fontFamily: NSString  = "SkyscannerRelativeiOS"
    public var regularFontFace: NSString  = "SkyscannerRelativeiOS-Book"
    public var semiboldFontFace: NSString  = "SkyscannerRelativeiOS-Bold"
    public var blackFontFace: NSString  = "SkyscannerRelativeiOS-Black"
    public var heavyFontFace: NSString = "SkyscannerRelativeiOS-Black"
       
    public override init() {}
}

public class FallbackFontDefinition: NSObject, BPKFontDefinitionProtocol {
    public var fontFamily: NSString  = "Helvetica Neue"
    public var regularFontFace: NSString  = "HelveticaNeue"
    public var semiboldFontFace: NSString  = "HelveticaNeue-Medium"
    public var blackFontFace: NSString  = "HelveticaNeue-Bold"
    public var heavyFontFace: NSString = "SkyscannerRelativeiOS-Black"
    
    public override init() {}
}
