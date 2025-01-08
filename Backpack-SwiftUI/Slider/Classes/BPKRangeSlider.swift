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

public extension BPKRangeSlider {
    struct ThumbnailLabels {
        let lowerThumbnail: String
        let upperThumbnail: String
        
        public init(lowerThumbnail: String, upperThumbnail: String) {
            self.lowerThumbnail = lowerThumbnail
            self.upperThumbnail = upperThumbnail
        }
    }
}

/// A view that displays a horizontal slider with two thumbs.
public struct BPKRangeSlider: View {
    @Binding private var selectedRange: ClosedRange<Float>
    private let sliderBounds: ClosedRange<Float>
    private let step: Float
    private let minSpacing: Float
    private let thumbnailLabels: ThumbnailLabels?
    private let onDragEnded: (ClosedRange<Float>) -> Void

    private let sliderHeight: CGFloat = 4
    private let thumbSize: CGFloat = 20
    private let flareHeight: CGFloat = 6
    private var trailingAccessibilityLabel = ""
    private var leadingAccessibilityLabel = ""
    @State private var isDraggingLeadingThumb = false
    @State private var isDraggingTrailingThumb = false
    
    @State var height: CGFloat = .zero
    
    @Environment(\.layoutDirection) private var layoutDirection
    
    /// Creates a new instance of `BPKRangeSlider`.
    ///
    /// If the selected range is outside the bounds of the slider, it will be clamped to the bounds.
    ///
    /// - Parameters:
    ///   - selectedRange: Binding of the selected range of the slider.
    ///   - sliderBounds: The bounds of the slider.
    ///   - step: The step size of the slider. Defaults to 1.
    ///   - minSpacing: The minimum spacing between the two thumbs. Defaults to 0.
    ///   - thumbnailLabels: The minimum spacing between the two thumbs. Defaults to 0.
    ///   - onDragEnded: A closure that is called when the user stops dragging the slider.
    public init(
        selectedRange: Binding<ClosedRange<Float>>,
        sliderBounds: ClosedRange<Float>,
        step: Float = 1,
        minSpacing: Float = 0,
        thumbnailLabels: ThumbnailLabels? = nil,
        onDragEnded: @escaping (ClosedRange<Float>) -> Void = { _ in }
    ) {
        self._selectedRange = selectedRange
        self.sliderBounds = sliderBounds
        self.step = step
        self.minSpacing = minSpacing
        self.thumbnailLabels = thumbnailLabels
        self.onDragEnded = onDragEnded
    }
    
    public var body: some View {
        GeometryReader { geomentry in
            sliderView(sliderSize: geomentry.size)
                .background(GeometryReader { proxy in
                    Color.clear.onAppear {
                        height = proxy.size.height
                    }
                })
        }
        .frame(height: height)
        .padding([.leading, .trailing], thumbSize / 2)
        .onAppear(perform: clampSelectedRangeToBounds)
    }
    
    private func clampSelectedRangeToBounds() {
        if selectedRange.lowerBound < sliderBounds.lowerBound {
            $selectedRange.wrappedValue = sliderBounds.lowerBound...$selectedRange.wrappedValue.upperBound
        }
        if selectedRange.upperBound > sliderBounds.upperBound {
            $selectedRange.wrappedValue = $selectedRange.wrappedValue.lowerBound...sliderBounds.upperBound
        }
    }
    
    // swiftlint:disable closure_body_length
    // swiftlint:disable function_body_length
    @ViewBuilder private func sliderView(sliderSize: CGSize) -> some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                Capsule()
                    .fill(Color(.lineColor))
                    .frame(width: sliderSize.width, height: sliderHeight)
                    .padding(.bottom, (thumbSize / 2) - (sliderHeight / 2))
                Rectangle()
                    .fill(Color(.coreAccentColor))
                    .frame(width: fillLineWidth(sliderSize: sliderSize), height: sliderHeight)
                    .offset(x: fillLineOffset(sliderSize: sliderSize))
                    .padding(.bottom, (thumbSize / 2) - (sliderHeight / 2))
                SliderThumbView(
                    size: thumbSize,
                    offset: trailingThumbOffset(sliderSize: sliderSize),
                    onDrag: { value in
                        isDraggingTrailingThumb = true
                        handleTrailingThumbDrag(value: value, sliderSize: sliderSize)
                    },
                    onDragEnded: {
                        onDragEnded(selectedRange)
                        isDraggingTrailingThumb = false
                    }
                )
                
                .accessibilityLabel(trailingAccessibilityLabel)
                .accessibility(value: Text("\(selectedRange.upperBound)"))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: incrementTrailing()
                    case .decrement: decrementTrailing()
                    @unknown default: break
                    }
                }
                
                SliderThumbView(
                    size: thumbSize,
                    offset: leadingThumbOffset(sliderSize: sliderSize),
                    onDrag: { value in
                        isDraggingLeadingThumb = true
                        handleLeadingThumbDrag(value: value, sliderSize: sliderSize)
                    },
                    onDragEnded: {
                        isDraggingLeadingThumb = false
                        onDragEnded(selectedRange)
                    }
                )
                .accessibilityLabel(leadingAccessibilityLabel)
                .accessibility(value: Text("\(selectedRange.lowerBound)"))
                .accessibilityAdjustableAction { direction in
                    switch direction {
                    case .increment: incrementLeading()
                    case .decrement: decrementLeading()
                    @unknown default: break
                    }
                }
            }
            if let thumbnailLabels = thumbnailLabels, isDraggingTrailingThumb {
                thumbLabel(thumbnailLabels.upperThumbnail)
                    .offset(x: trailingThumbOffset(sliderSize: sliderSize))
                    .accessibilityHidden(true)
            }
            if let thumbnailLabels = thumbnailLabels, isDraggingLeadingThumb {
                thumbLabel(thumbnailLabels.lowerThumbnail)
                    .offset(x: leadingThumbOffset(sliderSize: sliderSize))
                    .accessibilityHidden(true)
            }
        }
    }
    
    private func thumbLabel(_ text: String) -> some View {
        BPKText(text, style: .label2)
            .foregroundColor(.textPrimaryInverseColor)
            .padding(.vertical, .sm)
            .padding(.horizontal, .md)
            .background(.coreAccentColor)
            .padding(.bottom, flareHeight)
            .background(.coreAccentColor)
            .clipShape(LabelFlareShape(flareHeight: flareHeight))
            .frame(height: thumbSize)
            .offset(y: -(thumbSize + flareHeight + BPKSpacing.sm.value))
    }
    
    /// Sets the accessibility label for the trailing thumb.
    public func trailingAccessibility(label: String) -> BPKRangeSlider {
        var result = self
        result.trailingAccessibilityLabel = label
        return result
    }
    
    /// Sets the accessibility label for the leading thumb.
    public func leadingAccessibility(label: String) -> BPKRangeSlider {
        var result = self
        result.leadingAccessibilityLabel = label
        return result
    }
    
    private func incrementLeading() {
        let newValue = min($selectedRange.wrappedValue.lowerBound + step, selectedRange.upperBound)
        $selectedRange.wrappedValue = newValue...$selectedRange.wrappedValue.upperBound
        onDragEnded(selectedRange)
    }
    
    private func decrementLeading() {
        let newValue = max($selectedRange.wrappedValue.lowerBound - step, sliderBounds.lowerBound)
        $selectedRange.wrappedValue = newValue...$selectedRange.wrappedValue.upperBound
        onDragEnded(selectedRange)
    }
    
    private func incrementTrailing() {
        let newValue = min($selectedRange.wrappedValue.upperBound + step, sliderBounds.upperBound)
        $selectedRange.wrappedValue = $selectedRange.wrappedValue.lowerBound...newValue
        onDragEnded(selectedRange)
    }
    
    private func decrementTrailing() {
        let newValue = max($selectedRange.wrappedValue.upperBound - step, selectedRange.lowerBound)
        $selectedRange.wrappedValue = $selectedRange.wrappedValue.lowerBound...newValue
        onDragEnded(selectedRange)
    }
    
    private func handleTrailingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: value.location.x,
            sliderWidth: sliderSize.width,
            thumbSize: thumbSize,
            sliderBounds: sliderBounds,
            step: step,
            layoutDirection: layoutDirection
        )
        let isGreaterThanLeadingThumb = roundedValue >= selectedRange.lowerBound
        let isSmallerThanUpperBound = roundedValue <= sliderBounds.upperBound
        let isWithinMinSpacing = roundedValue - selectedRange.lowerBound - minSpacing >= 0
        if isGreaterThanLeadingThumb && isSmallerThanUpperBound && isWithinMinSpacing {
            $selectedRange.wrappedValue = $selectedRange.wrappedValue.lowerBound...roundedValue
        }
    }
    
    private func handleLeadingThumbDrag(value: DragGesture.Value, sliderSize: CGSize) {
        let roundedValue = BPKSliderHelpers.calculateNewValueFromDrag(
            xLocation: value.location.x,
            sliderWidth: sliderSize.width,
            thumbSize: thumbSize,
            sliderBounds: sliderBounds,
            step: step,
            layoutDirection: layoutDirection
        )
        let isSmallerThanTrailingThumb = roundedValue <= selectedRange.upperBound
        let isGreaterThanLowerBound = roundedValue >= sliderBounds.lowerBound
        let isWithinMinSpacing = selectedRange.upperBound - roundedValue - minSpacing >= 0
        if isSmallerThanTrailingThumb && isGreaterThanLowerBound && isWithinMinSpacing {
            $selectedRange.wrappedValue = roundedValue...$selectedRange.wrappedValue.upperBound
        }
    }
    
    private func leadingThumbOffset(sliderSize: CGSize) -> CGFloat {
        thumbOffset(
            forBound: selectedPercentageBounds().lower,
            sliderSize: sliderSize
        )
    }
    
    private func trailingThumbOffset(sliderSize: CGSize) -> CGFloat {
        thumbOffset(
            forBound: selectedPercentageBounds().upper,
            sliderSize: sliderSize
        )
    }
    
    private func thumbOffset(forBound bound: Float, sliderSize: CGSize) -> CGFloat {
        sliderSize.width * CGFloat(bound) - (sliderSize.width / 2)
    }
    
    private func fillLineOffset(sliderSize: CGSize) -> CGFloat {
        let (lowerBound, upperBound) = selectedPercentageBounds()
        let centerPercentagePoint = (lowerBound + upperBound) / 2
        return sliderSize.width * CGFloat(centerPercentagePoint) - (sliderSize.width / 2)
    }
    
    private func fillLineWidth(sliderSize: CGSize) -> CGFloat {
        let (lowerBound, upperBound) = selectedPercentageBounds()
        return sliderSize.width * CGFloat(upperBound - lowerBound)
    }

    private func selectedPercentageBounds() -> (lower: Float, upper: Float) {
        let selectedLowerBoundPercentage = BPKSliderHelpers.percentageOfValue(
            value: $selectedRange.wrappedValue.lowerBound,
            sliderBounds: sliderBounds
        )
        let selectedUpperBoundPercentage = BPKSliderHelpers.percentageOfValue(
            value: $selectedRange.wrappedValue.upperBound,
            sliderBounds: sliderBounds
        )
        return (selectedLowerBoundPercentage, selectedUpperBoundPercentage)
    }
}

struct BPKRangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        BPKRangeSlider(
            selectedRange: .constant(30...70),
            sliderBounds: 0...100,
            step: 1,
            minSpacing: 10
        ).previewDisplayName("Standard")
        BPKRangeSlider(
            selectedRange: .constant(30...70),
            sliderBounds: 0...100,
            step: 1,
            minSpacing: 10,
            thumbnailLabels: .init(lowerThumbnail: "£10", upperThumbnail: "£50")
        ).previewDisplayName("With Thumbnails")
    }
}
