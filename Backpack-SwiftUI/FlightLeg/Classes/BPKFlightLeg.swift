/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
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

public struct BPKFlightLeg: View {
    private let airlineLogoSize = 24.0
    
    private let departureArrivalTime: String
    private let nextDayArrival: String?
    private let flightDescription: AttributedString
    private let stopsInfo: String
    private let highlightStopsInfo: Bool
    private let duration: String
    private let operatedBy: String?
    private let warning: String?
    private let carrierLogo: Image?
    
    public init(
        departureArrivalTime: String,
        nextDayArrival: String? = nil,
        flightDescription: AttributedString,
        stopsInfo: String,
        highlightStopsInfo: Bool = false,
        duration: String,
        operatedBy: String? = nil,
        warning: String? = nil,
        carrierLogo: Image? = nil
    ) {
        self.departureArrivalTime = departureArrivalTime
        self.nextDayArrival = nextDayArrival
        self.flightDescription = flightDescription
        self.stopsInfo = stopsInfo
        self.highlightStopsInfo = highlightStopsInfo
        self.duration = duration
        self.operatedBy = operatedBy
        self.warning = warning
        self.carrierLogo = carrierLogo
    }
    
    // swiftlint:disable closure_body_length
    public var body: some View {
        HStack(alignment: .top) {
            Rectangle()
                .frame(width: airlineLogoSize, height: airlineLogoSize)
                .cornerRadius(4)
                .padding(.top, 5)
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 0) {
                    BPKText(departureArrivalTime, style: .heading5)
                    if let nextDayArrival {
                        BPKText(nextDayArrival, style: .caption)
                    }
                }
                Text(flightDescription)
                    .font(style: .caption)
                    .foregroundColor(.textSecondaryColor)
                if let operatedBy {
                    BPKText(operatedBy, style: .caption)
                        .foregroundColor(.textSecondaryColor)
                }
                
                if let warning {
                    BPKText(warning, style: .label3)
                        .foregroundColor(.textErrorColor)
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: .sm) {
                BPKText(stopsInfo, style: .label3)
                    .foregroundColor(highlightStopsInfo ? .textErrorColor : .textPrimaryColor)
                BPKText(duration, style: .caption)
                    .foregroundColor(.textSecondaryColor)
            }
        }
    }
}

#Preview {
    VStack {
        BPKFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            flightDescription: "LHR - SIN",
            stopsInfo: "Direct",
            highlightStopsInfo: false,
            duration: "7h 55m"
        )
        
        BPKFlightLeg(
            departureArrivalTime: "19:50 - 22:45",
            flightDescription: "LHR - SIN",
            stopsInfo: "2 stops",
            highlightStopsInfo: true,
            duration: "7h 55m"
        )
    }
    .padding()
}
