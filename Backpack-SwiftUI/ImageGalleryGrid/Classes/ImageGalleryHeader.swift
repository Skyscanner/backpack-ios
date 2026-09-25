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

struct ImageGalleryHeader: View {
    /// Apple's minimum touch target.
    private static let touchTarget: CGFloat = 44
    /// How far the 44 pt touch target reaches past the 32 pt the Close button takes in the layout, on each side.
    private static let touchTargetOutset: CGFloat = 6

    let closeAccessibilityLabel: String
    let onCloseTapped: () -> Void

    @State private var displayCornerClearance: CGFloat = 0

    var body: some View {
        HStack {
            Button(action: onCloseTapped, label: {
                BPKIconView(.close, size: .large)
                    .foregroundColor(.textPrimaryColor)
                    // A real 44 pt frame gives the button Apple's minimum touch target. A larger content
                    // shape alone doesn't reach past the view's frame.
                    .frame(width: Self.touchTarget, height: Self.touchTarget)
                    .contentShape(Rectangle())
            })
            .accessibilityLabel(closeAccessibilityLabel)
            // Keeps the 32 pt the button took in the layout, so the icon doesn't move.
            .padding(-Self.touchTargetOutset)
            Spacer()
        }
        // The gallery fills the window, so on a phone whose top edge has no safe-area inset, such as a
        // foldable's inner display with a side rail, Close moves clear of the display's rounded corners.
        .padding(.top, displayCornerClearance)
        .background(DisplayCornerClearanceReader(clearance: $displayCornerClearance))
    }
}

/// Reports how far below a phone window's top safe-area inset its corner-aware safe area starts
/// (iOS 26 corner adaptation). It's 0 when the top inset already clears the corners, as on phones
/// with a status bar, and on other devices.
struct DisplayCornerClearanceReader: UIViewRepresentable {
    @Binding var clearance: CGFloat

    func makeUIView(context: Context) -> ReaderView {
        let view = ReaderView()
        view.isUserInteractionEnabled = false
        view.onClearanceChange = { newValue in
            // Deferred, so the state doesn't change during a layout pass.
            DispatchQueue.main.async { clearance = newValue }
        }
        return view
    }

    func updateUIView(_ uiView: ReaderView, context: Context) {}

    final class ReaderView: UIView {
        var onClearanceChange: ((CGFloat) -> Void)?
        private var reportedClearance: CGFloat = 0

        override func didMoveToWindow() {
            super.didMoveToWindow()
            reportClearance()
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            reportClearance()
        }

        private func reportClearance() {
            let clearance = Self.clearance(in: window)
            guard clearance != reportedClearance else { return }
            reportedClearance = clearance
            onClearanceChange?(clearance)
        }

        static func clearance(in window: UIWindow?) -> CGFloat {
            guard #available(iOS 26.0, *),
                  let window,
                  window.traitCollection.userInterfaceIdiom == .phone else { return 0 }
            let cornerAwareTop = window.edgeInsets(for: .safeArea(cornerAdaptation: .vertical)).top
            return max(0, cornerAwareTop - window.safeAreaInsets.top)
        }
    }
}

struct ImageGalleryHeader_Previews: PreviewProvider {
    static var previews: some View {
        ImageGalleryHeader(closeAccessibilityLabel: "close", onCloseTapped: { })
    }
}
