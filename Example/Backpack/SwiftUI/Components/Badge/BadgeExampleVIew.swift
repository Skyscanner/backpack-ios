//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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

// swiftlint:disable all
struct BadgeExampleVIew: View {
    @State var value: Float = 0
    @State var changed: Bool = false
    @State var selectedRange: ClosedRange<Float> = -20...20
    
    var body: some View {
        VStack {
            BPKDoubleSliderView(
                currentValue: $selectedRange,
                sliderBounds: -50...50
            )
            BPKSliderView(
                currentValue: $selectedRange,
                sliderBounds: -50...50,
                leadingLabel: {
                    BPKText("\(selectedRange.lowerBound)")
                },
                trailingLabel: {
                    BPKText("\(selectedRange.upperBound)")
                }
            )
                .frame(width: 200)
            BPKSliderView(
                currentValue: $selectedRange,
                sliderBounds: -50...50,
                leadingLabel: {
                    BPKText("\(selectedRange.lowerBound)")
                },
                trailingLabel: {
                    BPKText("\(selectedRange.upperBound)")
                }
            )
            
            
        }.padding()
            
    }
}

struct BPKDoubleSliderView: View {
    @Binding var currentValue: ClosedRange<Float>
    let sliderBounds: ClosedRange<Float>
    
    var body: some View {
        BPKSliderView<Text, Text>(currentValue: $currentValue, sliderBounds: sliderBounds, leadingLabel: { nil }, trailingLabel: { nil })
    }
}

struct BPKSliderView<LeadingLabel: View, TrailingLabel: View>: View {
    @Binding var currentValue: ClosedRange<Float>
    let sliderBounds: ClosedRange<Float>
    let sliderHeight: CGFloat = 4
    let step: Int = 1
    let thumbSize: CGFloat = 20
    let trailingAccessibilityLabel: String = "Trailing"
    let leadingAccessibilityLabel: String = "Leading"

    @ViewBuilder let leadingLabel: LeadingLabel?
    @ViewBuilder let trailingLabel: TrailingLabel?
    
    init(
        currentValue: Binding<ClosedRange<Float>>,
        sliderBounds: ClosedRange<Float>,
        leadingLabel: () -> LeadingLabel?,
        trailingLabel: () -> TrailingLabel?
    ) {
        self._currentValue = currentValue
        self.sliderBounds = sliderBounds
        self.leadingLabel = leadingLabel()
        self.trailingLabel = trailingLabel()
    }
    
    var body: some View {
        GeometryReader { geomentry in
            sliderView(sliderSize: geomentry.size)
                
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: thumbSize)
        .padding([.leading, .trailing], thumbSize / 2)
        .onAppear(perform: clampCurrentValueToBounds)
    }

    private func clampCurrentValueToBounds() {
        if currentValue.lowerBound < sliderBounds.lowerBound {
            $currentValue.wrappedValue = sliderBounds.lowerBound...$currentValue.wrappedValue.upperBound
        }
        if currentValue.upperBound > sliderBounds.upperBound {
            $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...sliderBounds.upperBound
        }
    }

    @State var debugValue: Float = 0
       
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        ZStack {
            ZStack {
                leadingLabel
                    .offset(x: leadingThumbOffset(sliderSize: sliderSize))
                    .padding(.bottom, thumbSize * 2)
                trailingLabel
                    .offset(x: trailingThumbOffset(sliderSize: sliderSize))
                    .padding(.bottom, thumbSize * 2)
            }
            
            Capsule()
                .fill(Color(.lineColor))
                .frame(width: sliderSize.width, height: sliderHeight)
            ZStack {
                Rectangle()
                    .fill(Color(.coreAccentColor))
                    .frame(width: fillLineWidth(sliderSize: sliderSize), height: sliderHeight)
                    .offset(x: fillLineOffset(sliderSize: sliderSize))
                Circle()
                    .fill(Color(.coreAccentColor))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: trailingThumbOffset(sliderSize: sliderSize))
                    .shadow(.sm)
                    .highPriorityGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                handleTrailingThumbDrag(value: value, sliderSize: sliderSize)
                            }
                    )
                    .accessibilityLabel(trailingAccessibilityLabel)
                    .accessibility(value: Text("\(currentValue.upperBound)"))
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment: incrementTrailing()
                        case .decrement: decrementTrailing()
                        @unknown default: break
                        }
                    }
                Circle()
                    .fill(Color(.coreAccentColor))
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: leadingThumbOffset(sliderSize: sliderSize))
                    .shadow(.sm)
                    .highPriorityGesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                handleLeadingThumbDrag(value: value, sliderSize: sliderSize)
                            }
                    )
                    .accessibilityLabel(leadingAccessibilityLabel)
                    .accessibility(value: Text("\(currentValue.lowerBound)"))
                    .accessibilityAdjustableAction { direction in
                        switch direction {
                        case .increment: incrementLeading()
                        case .decrement: decrementLeading()
                        @unknown default: break
                        }
                    }
            }
        }
        
    }

    private func incrementLeading() {
        let newValue = min($currentValue.wrappedValue.lowerBound + Float(step), currentValue.upperBound)
        $currentValue.wrappedValue = newValue...$currentValue.wrappedValue.upperBound
    }

    private func decrementLeading() {
        let newValue = max($currentValue.wrappedValue.lowerBound - Float(step), sliderBounds.lowerBound)
        $currentValue.wrappedValue = newValue...$currentValue.wrappedValue.upperBound
    }

    private func incrementTrailing() {
        let newValue = min($currentValue.wrappedValue.upperBound + Float(step), sliderBounds.upperBound)
        $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...newValue
    }

    private func decrementTrailing() {
        let newValue = max($currentValue.wrappedValue.upperBound - Float(step), currentValue.lowerBound)
        $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...newValue
    }

    private func handleTrailingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let adjustedThumbPosition = Float(value.location.x - thumbSize / 2 + sliderSize.width / 2)
        let percentageForPosition = adjustedThumbPosition / Float(sliderSize.width)
        let newValue = valueForPercentage(percentageForPosition)
        let roundedValue = Float(Int(newValue / Float(step)) * step)
        debugValue = roundedValue
        if roundedValue >= currentValue.lowerBound && roundedValue <= sliderBounds.upperBound {
            $currentValue.wrappedValue = $currentValue.wrappedValue.lowerBound...roundedValue
        }
    }

    private func handleLeadingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let adjustedThumbPosition = Float(value.location.x - thumbSize / 2 + sliderSize.width / 2)
        let percentageForPosition = adjustedThumbPosition / Float(sliderSize.width)
        let newValue = valueForPercentage(percentageForPosition)
        let roundedValue = Float(Int(newValue / Float(step)) * step)
        debugValue = roundedValue
        if roundedValue <= currentValue.upperBound && roundedValue >= sliderBounds.lowerBound {
            $currentValue.wrappedValue = roundedValue...$currentValue.wrappedValue.upperBound
        }
    }

    private func leadingThumbOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let offset = (sliderSize.width * CGFloat(currentValueLowerBoundPercentage)) - (sliderSize.width / 2)
        return offset
    }

    private func trailingThumbOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let offset = (sliderSize.width * CGFloat(currentValueUpperBoundPercentage)) - (sliderSize.width / 2)
        return offset
    }

    private func fillLineOffset(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let centerPercentagePoint = (currentValueLowerBoundPercentage + currentValueUpperBoundPercentage) / 2
        let offset = (sliderSize.width * CGFloat(centerPercentagePoint)) - (sliderSize.width / 2)
        return offset
    }
    
    private func valueForPercentage(_ percentage: Float) -> Float {
        let value = Float(sliderBounds.lowerBound) + (percentage * (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound)))
        return value
    }

    private func percentageOfValue(value: Float) -> Float {
        let percentage = (value - Float(sliderBounds.lowerBound)) / (Float(sliderBounds.upperBound) - Float(sliderBounds.lowerBound))
        return percentage
    }
    
    private func fillLineWidth(sliderSize: CGSize) -> CGFloat {
        let currentValueLowerBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.lowerBound))
        let currentValueUpperBoundPercentage = percentageOfValue(value: Float($currentValue.wrappedValue.upperBound))
        let width = sliderSize.width * CGFloat(currentValueUpperBoundPercentage - currentValueLowerBoundPercentage)
        return width
    }
}
//BPKFlareView(size: .small) {
//    VStack {
//        BPKText("\(value)", style: .label2)
//            .foregroundColor(.textPrimaryInverseColor)
//    }
//    .padding([.leading, .trailing], 3)
//    .padding(.bottom, 7)
//    .background(.coreEcoColor)
//}
//.offset(y: -22)
    
struct BadgeExampleVIew_Previews: PreviewProvider {
    static var previews: some View {
        BadgeExampleVIew()
    }
}
