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

import SwiftUI

// The fold APIs ship with the iOS 27.1 SDK (Swift 6.4). Older toolchains, such as the Xcode used on CI,
// compile the fallback, which never moves content.
#if compiler(>=6.4)
@available(iOS 27.1, *)
public extension GeometryProxy {
    /// The fold of a partially folded foldable, such as an iPhone Duo in book pose, in this proxy's space.
    /// `nil` when the device is closed, fully open, or not a foldable.
    var bpkActiveFoldFrame: CGRect? {
        reservedRegions(kind: .division).first(where: \.isActive)?.frame
    }
}
#endif

/// Where content goes when a foldable is partially folded.
public enum BPKFoldSide {
    /// The half before the fold: the leading half of a vertical fold, or the top half of a horizontal one.
    case leading
    /// The half after the fold: the trailing half of a vertical fold, or the bottom half of a horizontal one.
    case trailing
}

public extension View {
    /// Keeps the view clear of the fold when a foldable, such as the iPhone Duo, is partially folded, by
    /// moving it into one half. When the device is closed, fully open, or not a foldable, nothing changes.
    ///
    /// Apply it to a full-screen container, such as the layer that shows a dialog, so content doesn't
    /// straddle the fold.
    ///
    /// - Parameter side: The half that holds the content. Defaults to `.leading`.
    func bpkKeepClearOfFold(on side: BPKFoldSide = .leading) -> some View {
        modifier(KeepClearOfFoldModifier(side: side))
    }
}

private struct KeepClearOfFoldModifier: ViewModifier {
    let side: BPKFoldSide

    func body(content: Content) -> some View {
        #if compiler(>=6.4)
        if #available(iOS 27.1, *) {
            GeometryReader { proxy in
                content
                    .padding(FoldAvoidance.insets(avoiding: proxy.bpkActiveFoldFrame, in: proxy.size, side: side))
            }
        } else {
            content
        }
        #else
        content
        #endif
    }
}

enum FoldAvoidance {
    /// Padding that leaves only the chosen half of a window to its content, so nothing straddles the fold.
    ///
    /// - Parameters:
    ///   - fold: The fold's frame in the window's space, or `nil` when there is no active fold.
    ///   - size: The window's size.
    ///   - side: The half that keeps the content.
    static func insets(avoiding fold: CGRect?, in size: CGSize, side: BPKFoldSide) -> EdgeInsets {
        guard let fold else { return EdgeInsets() }
        let isVerticalFold = fold.height > fold.width
        switch (isVerticalFold, side) {
        case (true, .leading):
            return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: max(0, size.width - fold.minX))
        case (true, .trailing):
            return EdgeInsets(top: 0, leading: max(0, fold.maxX), bottom: 0, trailing: 0)
        case (false, .leading):
            return EdgeInsets(top: 0, leading: 0, bottom: max(0, size.height - fold.minY), trailing: 0)
        case (false, .trailing):
            return EdgeInsets(top: max(0, fold.maxY), leading: 0, bottom: 0, trailing: 0)
        }
    }
}
