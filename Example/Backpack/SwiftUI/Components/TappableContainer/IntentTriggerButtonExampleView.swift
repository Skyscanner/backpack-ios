//
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
import Backpack_SwiftUI

@available(iOS 17.0, *)
struct IntentTriggerButtonExampleView: View {

    var body: some View {
        VStack(spacing: BPKSpacing.lg) {
            simpleRefreshExample
            widgetRefreshExample
        }
        .padding(BPKSpacing.base)
    }
    
    private var simpleRefreshExample: some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKText("Simple Refresh Button", style: .heading5)

            BPKIntentTriggerButton(
                intent: RefreshWidgetIntent(),
                label: {
                    HStack(spacing: .md) {
                        BPKIconView(.refresh, size: .small)
                            .foregroundColor(.textOnDarkColor)
                        BPKText("Refresh Data", style: .bodyDefault)
                            .foregroundColor(.textOnDarkColor)
                    }
                    .padding(.base)
                    .background(.surfaceContrastColor)
                    .clipShape(RoundedRectangle(cornerRadius: .sm))
                }
            )
        }
    }
    
    private var widgetRefreshExample: some View {
        VStack(alignment: .leading, spacing: .md) {
            BPKText("Widget-style Button", style: .heading5)

            BPKIntentTriggerButton(
                intent: RefreshWidgetIntent(),
                label: {
                    BPKIconView(.refresh, size: .small)
                        .foregroundColor(.coreAccentColor)
                }
            )
        }
    }
}

// MARK: - Example App Intent
@available(iOS 17.0, *)
struct RefreshWidgetIntent: AppIntent {
    static var title: LocalizedStringResource = "Refresh Widget"
    static var description = IntentDescription("Refreshes the widget content")
    
    func perform() async throws -> some IntentResult {
        print(" Refreshing widget...")
        // Simulate widget refresh
        try await Task.sleep(for: .seconds(0.5))
        print(" Widget refreshed successfully")
        return .result()
    }
}

// MARK: - Fallback for iOS < 17

struct IntentTriggerButtonExampleViewFallback: View {
    var body: some View {
        VStack(spacing: BPKSpacing.lg) {
            BPKText("Intent Trigger Button", style: .heading4)
                .foregroundColor(.textPrimaryColor)
            
            BPKText("This component requires iOS 17.0 or later", style: .bodyDefault)
                .foregroundColor(.textSecondaryColor)
                .multilineTextAlignment(.center)
            
            BPKText("App Intents framework is needed for intent trigger functionality", style: .caption)
                .foregroundColor(.textSecondaryColor)
                .multilineTextAlignment(.center)
        }
        .padding(BPKSpacing.base)
        .background(.surfaceContrastColor)
    }
}
