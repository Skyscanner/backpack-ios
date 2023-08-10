/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

// swiftlint:disable line_length

// Created by MMP0
// https://gist.github.com/MMP0/2c1b581ad071c4279806ed5ad995a18a
public extension View {
    /// Sets the Dynamic Type size within the view to the given value.
    /// (Polyfill for previous versions)
    ///
    /// - SeeAlso:
    ///   - [dynamicTypeSize(_:)](https://developer.apple.com/documentation/swiftui/view/dynamictypesize%28_%3A%29-1m2tf)
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(macOS, introduced: 10.15, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    func sizeCategory(_ size: ContentSizeCategory) -> some View {
        environment(\.sizeCategory, size)
    }
    
    /// Limits the Dynamic Type size within the view to the given range.
    /// (Polyfill for previous versions)
    ///
    /// - SeeAlso:
    ///   - [dynamicTypeSize(_:)](https://developer.apple.com/documentation/swiftui/view/dynamictypesize%28_%3A%29-26aj0)
    @available(iOS, introduced: 13.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(macOS, introduced: 10.15, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(tvOS, introduced: 13.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    @available(watchOS, introduced: 6.0, deprecated: 100000.0, renamed: "dynamicTypeSize(_:)")
    func sizeCategory<T: RangeExpression>(_ range: T) -> some View where T.Bound == ContentSizeCategory {
        modifier(SizeCategoryModifier(range: range))
    }
}

private struct SizeCategoryModifier: ViewModifier {
    @Environment(\.sizeCategory) private var sizeCategory
    
    private let range: ClosedRange<ContentSizeCategory>
    
    init<T: RangeExpression>(range: T) where T.Bound == ContentSizeCategory {
        self.range = range as? ClosedRange ?? {
            // Convert the range to ClosedRange
            let allCases = ContentSizeCategory.allCases.sorted()
            let min = allCases.first(where: range.contains(_:)) ?? allCases.first!
            let max = allCases.last(where: range.contains(_:)) ?? allCases.last!
            return min...max
        }()
    }
    
    func body(content: Content) -> some View {
        content
            .environment(\.sizeCategory, sizeCategory.clamp(to: range))
    }
}

// The comparison operator functions are implemented by default, but somehow it doesn’t conform to Comparable.
extension ContentSizeCategory: Comparable {}

private extension Comparable {
    @inline(__always)
    func clamp(to range: ClosedRange<Self>) -> Self { min(max(range.lowerBound, self), range.upperBound) }
}
