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

public struct BPKTimeLabel: View {
    private let seconds: Int
    private let allowedUnits: NSCalendar.Unit
    private let style: BPKFontStyle
    
    private var textColor = BPKColor.textPrimaryColor
    
    public init(
        hours: Int? = nil,
        minutes: Int? = nil,
        seconds: Int,
        allowedUnits: NSCalendar.Unit = [.hour, .minute],
        style: BPKFontStyle = .bodyDefault
    ) {
        var sumSeconds = seconds
            
        if let hours {
            sumSeconds += hours * 60 * 60
        }
        
        if let minutes {
            sumSeconds += minutes * 60
        }
    
        self.seconds = sumSeconds
        self.allowedUnits = allowedUnits
        self.style = style
    }
    
    public var body: some View {
        BPKText(formattedSecondsText, style: style)
            .foregroundColor(textColor)
            .accessibilityLabel(accessibilityFormattedText)
    }
    
    /// Sets the color of the text.
    ///
    /// - Parameter color: The foreground `BPKColor` to use when displaying this
    ///   view.
    ///
    /// - Returns: A BPKText that uses the foreground color you supply.
    public func foregroundColor(_ color: BPKColor) -> BPKTimeLabel {
        var view = self
        view.textColor = color
        return view
    }
}

private extension BPKTimeLabel {
    func formatSeconds(
        seconds: Int,
        unitsStyle: DateComponentsFormatter.UnitsStyle = .full
    ) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = self.allowedUnits
        formatter.unitsStyle = unitsStyle
    
        let formattedString = formatter.string(from: TimeInterval(seconds))!
        return formattedString
    }
    
    var formattedSecondsText: String {
        formatSeconds(seconds: seconds, unitsStyle: .abbreviated)
    }
    
    var accessibilityFormattedText: String {
        formatSeconds(seconds: seconds, unitsStyle: .full)
    }
}

struct BPKTimeLabel_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BPKTimeLabel(hours: 1, minutes: 10, seconds: 10)
            BPKTimeLabel(minutes: 10, seconds: 10)
            BPKTimeLabel(seconds: 101)
            
            BPKTimeLabel(minutes: 120, seconds: 0)
            BPKTimeLabel(
                seconds: 340,
                allowedUnits: [.minute, .second],
                style: .caption
            )
            .foregroundColor(.textSecondaryColor)
        }
    }
}
