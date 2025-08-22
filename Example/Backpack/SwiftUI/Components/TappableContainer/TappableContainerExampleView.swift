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
import Backpack_SwiftUI

struct TappableContainerExampleView: View {

    var body: some View {
        VStack(spacing: BPKSpacing.lg) {
            simpleTextExample
            flightCardExample
            hotelCardExample
        }
        .padding(BPKSpacing.base)
        .background(.surfaceContrastColor)
    }
    
    private var simpleTextExample: some View {
        BPKTappableContainer(
            accessibilityLabel: "Tap to see simple text example",
            action: { print("Simple text tapped") },
            content: {
                BPKText("Simple Text", style: .bodyDefault)
                    .foregroundColor(.textPrimaryColor)
                    .padding()
                    .background(.surfaceDefaultColor)
                    .clipShape(RoundedRectangle(cornerRadius: .sm))
            }
        )
    }
    
    private var flightCardExample: some View {
        BPKTappableContainer(
            accessibilityLabel: "Tap to see flight card",
            action: { print("Flight card tapped") },
            buttonStyleType: .noTapAnimation,
            content: {
                flightCardContent
            }
        )
    }
    
    private var flightCardContent: some View {
        HStack(spacing: .md) {
            BPKIconView(.aircraft, size: .large)
                .foregroundColor(.coreAccentColor)

            VStack(alignment: .leading, spacing: .sm) {
                BPKText("Flight Details", style: .heading5)
                BPKText("London to Paris", style: .caption)
                    .foregroundColor(.textSecondaryColor)
            }

            Spacer()

            BPKIconView(.chevronRight, size: .small)
                .foregroundColor(.textSecondaryColor)
        }
        .padding(.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .lg))
        .overlay(
            RoundedRectangle(cornerRadius: .lg)
                .stroke(style: .init(lineWidth: 1))
        )
    }
    
    private var hotelCardExample: some View {
        BPKTappableContainer(
            accessibilityLabel: "Tap to see hotel booking details",
            action: { print("Hotel card tapped") },
            content: {
                hotelCardContent
            }
        )
    }
    
    private var hotelCardContent: some View {
        VStack(spacing: .md) {
            availabilityIndicator
            hotelDetails
            starRating
        }
        .padding(.base)
        .background(.surfaceDefaultColor)
        .clipShape(RoundedRectangle(cornerRadius: .lg))
        .overlay(
            RoundedRectangle(cornerRadius: .lg)
                .stroke(style: .init(lineWidth: 1))
        )
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private var availabilityIndicator: some View {
        HStack {
            HStack(spacing: .sm) {
                Circle()
                    .fill()
                    .frame(width: 8, height: 8)
                BPKText("Available", style: .caption)
                    .foregroundColor(.statusSuccessSpotColor)
            }
            Spacer()
        }
    }
    
    private var hotelDetails: some View {
        HStack {
            VStack(alignment: .leading, spacing: .sm) {
                BPKText("Hotel Room", style: .heading4)
                BPKText("Deluxe Suite with City View", style: .bodyDefault)
                    .foregroundColor(.textSecondaryColor)
            }
            Spacer()
            VStack(alignment: .trailing) {
                BPKText("£120", style: .heading4)
                BPKText("/night", style: .caption)
                    .foregroundColor(.textSecondaryColor)
            }
        }
    }
    
    private var starRating: some View {
        HStack(spacing: BPKSpacing.sm) {
            ForEach(0..<4, id: \.self) { _ in
                BPKIconView(.star, size: .small)
                    .foregroundColor(.statusWarningSpotColor)
            }
            BPKIconView(.starHalf, size: .small)
                .foregroundColor(.statusWarningSpotColor)
            BPKText("4.5", style: .caption)
                .foregroundColor(.textSecondaryColor)
            Spacer()
        }
    }
}
