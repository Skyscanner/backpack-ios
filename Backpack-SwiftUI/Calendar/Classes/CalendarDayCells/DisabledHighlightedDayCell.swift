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

struct DisabledHighlightedDayCell: View {
    let calendar: Calendar
    let date: Date

    var body: some View {
        BPKText("\(calendar.component(.day, from: date))", style: .label1)
            .lineLimit(1)
            .foregroundColor(.textDisabledColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, .md)
            .overlay {
                Circle().stroke(Color(BPKColor.coreAccentColor), lineWidth: 2)
            }
            .accessibilityHidden(true)
    }
}
