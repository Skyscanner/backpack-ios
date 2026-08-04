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

// Based on Variable Blur Shader from Variablur
// Source: https://github.com/daprice/Variablur
// License: MIT License (https://github.com/daprice/Variablur/blob/main/LICENSE)
// Copyright (c) 2023 Daniel Price

/*
 * Variable Blur Metal Shader
 *
 * Implements a two-pass Gaussian blur with variable radius controlled by a mask texture.
 * The mask's alpha values determine blur intensity at each pixel (0 = no blur, 1 = full blur).
 * Performance scales linearly rather than exponentially due to the two-pass approach.
 */

#include <metal_stdlib>
using namespace metal;

#include <SwiftUI/SwiftUI_Metal.h>

/// Gaussian function for blur weight calculation
inline half gaussian(half distance, half sigma) {
    const half gaussianExponent = -(distance * distance) / (2.0h * sigma * sigma);
    return (1.0h / (2.0h * M_PI_H * sigma * sigma)) * exp(gaussianExponent);
}

/// Performs 1D Gaussian blur along specified axis using weighted sampling
half4 gaussianBlur1D(float2 position, SwiftUI::Layer layer, half radius, half2 axisMultiplier, half maxSamples) {
    const half interval = max(1.0h, radius / maxSamples);
    
    const half weight = gaussian(0.0h, radius / 2.0h);
    half4 weightedColorSum = layer.sample(position) * weight;
    half totalWeight = weight;
    
    if(interval <= radius) {
        for (half distance = interval; distance <= radius; distance += interval) {
            const half2 offsetDistance = axisMultiplier * distance;
            const half weight = gaussian(distance, radius / 2.0h);
            
            totalWeight += weight * 2.0h;
            weightedColorSum += layer.sample(float2(half2(position) + offsetDistance)) * weight;
            weightedColorSum += layer.sample(float2(half2(position) - offsetDistance)) * weight;
        }
    }
    
    return weightedColorSum / totalWeight;
}

/// Main variable blur shader function - requires two passes (horizontal and vertical)
[[ stitchable ]] half4 variableBlur(float2 pos, SwiftUI::Layer layer, float4 boundingRect, float radius, float maxSamples, texture2d<half> mask, float vertical) {
    const float2 uv = float2(pos.x / boundingRect[2], pos.y / boundingRect[3]);
    const half maskAlpha = mask.sample(metal::sampler(metal::filter::linear), uv).a;
    const half pixelRadius = maskAlpha * half(radius);
    
    if(pixelRadius >= 1) {
        const half2 axisMultiplier = vertical == 0.0 ? half2(1, 0) : half2(0, 1);
        return gaussianBlur1D(pos, layer, pixelRadius, axisMultiplier, maxSamples);
    } else {
        return layer.sample(pos);
    }
}
