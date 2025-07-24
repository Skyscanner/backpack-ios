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

import SwiftUI

@available(iOS 17, macOS 14, macCatalyst 17, tvOS 17, visionOS 1, *)
struct BackpackShaderLibrary {
    private static var shaderLibrary: ShaderLibrary {
        // Get the bundle for this framework
        let bundle = Bundle(for: BundleToken.self)
        
        // Look for the resource bundle created by CocoaPods
        if let resourceBundleURL = bundle.url(
            forResource: "Backpack-SwiftUI", withExtension: "bundle"
        ), let resourceBundle = Bundle(url: resourceBundleURL) {
            return ShaderLibrary.bundle(resourceBundle)
        }

        // Fallback to the framework bundle itself
        return ShaderLibrary.bundle(bundle)
    }
    
    static func variableBlur(
        _ boundingRect: Shader.Argument,
        _ radius: Shader.Argument,
        _ maxSampleCount: Shader.Argument,
        _ mask: Shader.Argument,
        _ vertical: Shader.Argument
    ) -> Shader {
        return shaderLibrary.variableBlur(boundingRect, radius, maxSampleCount, mask, vertical)
    }
}

// Helper class to get the correct bundle
private class BundleToken {

}
