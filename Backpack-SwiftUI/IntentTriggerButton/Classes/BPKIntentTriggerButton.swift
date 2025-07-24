/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd. All rights reserved.
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
import AppIntents
import Backpack_Common

/// A button component that triggers App Intents when tapped.
///
/// `BPKIntentTriggerButton` is a SwiftUI button component that allows you to trigger
/// App Intents while providing custom visual content. This is useful for integrating
/// with iOS system features like Siri, Shortcuts, and App Shortcuts.
///
/// Example usage:
/// ```swift
/// if #available(iOS 17.0, *) {
///     BPKIntentTriggerButton(
///         intent: RefreshWidgetIntent(),
///         label: {
///             Image(viewState.refreshIcon, bundle: viewState.bundle)
///                 .resizable()
///                 .scaledToFit()
///                 .frame(height: 16)
///         }
///     )
/// }
/// ```
///
/// - Note: This component is only available on iOS 17.0+ due to App Intents framework requirements.
@available(iOS 17.0, *)
public struct BPKIntentTriggerButton<Content: View, Intent: AppIntent>: View {
    
    /// The App Intent to trigger when the button is tapped
    private let intent: Intent
    
    /// The visual content of the button
    private let label: Content
    
    /// Creates a new intent trigger button.
    ///
    /// - Parameters:
    ///   - intent: The App Intent to trigger when tapped
    ///   - label: A view builder that creates the button's visual content
    public init(intent: Intent, @ViewBuilder label: () -> Content) {
        self.intent = intent
        self.label = label()
    }
    
    public var body: some View {
        Button(intent: intent, label: {
            label
        })
        .buttonStyle(.plain)
    }
}

#if DEBUG
@available(iOS 17.0, *)
struct BPKIntentTriggerButton_Previews: PreviewProvider {
    
    struct PreviewIntent: AppIntent {
        static var title: LocalizedStringResource = "Preview Intent"
        
        func perform() async throws -> some IntentResult {
            print("Preview intent triggered")
            return .result()
        }
    }
    
    static var previews: some View {
        VStack(spacing: 16) {
            BPKIntentTriggerButton(
                intent: PreviewIntent(),
                label: {
                    Image(systemName: "star.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundColor(.yellow)
                }
            )
        }
        .padding()
    }
}
#endif
