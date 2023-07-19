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

/// A struct containing the values for the spacing tokens.
///
/// The spacing tokens are used to define the spacing between components.
///
/// Example usage:
///
///     BPKText("Text with BPKSpacing.md padding")
///         .padding(.md)
///
///     HStack(spacing: .md) {
///         BPKText("Text with BPKSpacing.md spacing")
///         BPKText("Text with BPKSpacing.md spacing")
///     }
///
public struct BPKSpacing {
    public let value: CGFloat
    
    init(value: CGFloat) {
        self.value = value
    }
}

public extension View {

    /// Adds a specific padding amount to each edge of this view.
    ///
    /// Use this modifier to add padding all the way around a view.
    ///
    ///     VStack {
    ///         Text("Text padded by BPKSpacing.md on each edge")
    ///             .padding(.md)
    ///         Text("Unpadded text for comparison.")
    ///     }
    ///
    /// The order in which you apply modifiers matters. The example above
    /// applies the padding before applying the border to ensure that the
    /// border encompasses the padded region:
    ///
    /// To pad a select set of edges by the same amount,
    /// use ``View/padding(_:_:)``.
    ///
    /// - Parameter length: The amount to pad this view on all edges.
    ///
    /// - Returns: A view that's padded by the spacing token you specify.
    func padding(_ spacing: BPKSpacing) -> some View {
        padding(spacing.value)
    }

    /// Adds an equal padding amount to specific edges of this view.
    ///
    /// Use this modifier to add a specified amount of padding to one or more
    /// edges of the view. Indicate the edges to pad by naming either a single
    /// value from ``Edge/Set``, or by specifying an ``OptionSet``
    /// that contains edge values:
    ///
    ///     VStack {
    ///         Text("Text padded by BPKSpacing.base on the bottom and trailing edges.")
    ///             .padding([.bottom, .trailing], .base)
    ///         Text("Unpadded text for comparison.")
    ///     }
    ///
    /// The order in which you apply modifiers matters. The example above
    /// applies the padding before applying the border to ensure that the
    /// border encompasses the padded region:
    ///
    /// - Parameters:
    ///   - edges: The set of edges to pad for this view.
    ///   - length: An amount to pad this view on the specified edges.
    ///
    /// - Returns: A view that's padded by the specified amount on the
    ///   specified edges.
    func padding(_ edge: Edge.Set, _ spacing: BPKSpacing) -> some View {
        padding(edge, spacing.value)
    }
    
    /// Positions this view within an invisible frame with the specified size.
    ///
    /// Use this method to specify a fixed size for a view's width, height, or
    /// both. If you only specify one of the dimensions, the resulting view
    /// assumes this view's sizing behavior in the other dimension.
    ///
    /// For example, the following code lays out an ellipse in a fixed `BPKSpacing.md` by
    /// `BPKSpacing.sm` frame. Because a shape always occupies the space offered to it by
    /// the layout system, the first ellipse is `.md x .sm` points. The second
    /// ellipse is laid out in a frame with only a fixed height, so it occupies
    /// that height, and whatever width the layout system offers to its parent.
    ///
    ///     VStack {
    ///         Ellipse()
    ///             .frame(width: .md, height: .sm)
    ///         Ellipse()
    ///             .frame(height: .sm)
    ///     }
    ///
    /// `The alignment` parameter specifies this view's alignment within the
    /// frame.
    ///
    ///     BPKText("Hello world!")
    ///         .frame(width: .lg, height: .md, alignment: .topLeading)
    ///         .border(.lineColor)
    ///
    /// In the example above, the text is positioned at the top, leading corner
    /// of the frame. If the text is taller than the frame, its bounds may
    /// extend beyond the bottom of the frame's bounds.
    ///
    /// - Parameters:
    ///   - width: A fixed width for the resulting view. If `width` is `nil`,
    ///     the resulting view assumes this view's sizing behavior.
    ///   - height: A fixed height for the resulting view. If `height` is `nil`,
    ///     the resulting view assumes this view's sizing behavior.
    ///   - alignment: The alignment of this view inside the resulting frame.
    ///     Note that most alignment values have no apparent effect when the
    ///     size of the frame happens to match that of this view.
    ///
    /// - Returns: A view with fixed dimensions of `width` and `height`, for the
    ///   parameters that are non-`nil`.
    func frame(width: BPKSpacing? = nil, height: BPKSpacing? = nil, alignment: Alignment = .center) -> some View {
        frame(width: width?.value, height: height?.value, alignment: alignment)
    }

    /// Positions this view within an invisible frame having the specified size
    /// constraints.
    ///
    /// Always specify at least one size characteristic when calling this
    /// method. Pass `nil` or leave out a characteristic to indicate that the
    /// frame should adopt this view's sizing behavior, constrained by the other
    /// non-`nil` arguments.
    ///
    /// The size proposed to this view is the size proposed to the frame,
    /// limited by any constraints specified, and with any ideal dimensions
    /// specified replacing any corresponding unspecified dimensions in the
    /// proposal.
    ///
    /// If no minimum or maximum constraint is specified in a given dimension,
    /// the frame adopts the sizing behavior of its child in that dimension. If
    /// both constraints are specified in a dimension, the frame unconditionally
    /// adopts the size proposed for it, clamped to the constraints. Otherwise,
    /// the size of the frame in either dimension is:
    ///
    /// - If a minimum constraint is specified and the size proposed for the
    ///   frame by the parent is less than the size of this view, the proposed
    ///   size, clamped to that minimum.
    /// - If a maximum constraint is specified and the size proposed for the
    ///   frame by the parent is greater than the size of this view, the
    ///   proposed size, clamped to that maximum.
    /// - Otherwise, the size of this view.
    ///
    /// - Parameters:
    ///   - minWidth: The minimum width of the resulting frame.
    ///   - idealWidth: The ideal width of the resulting frame.
    ///   - maxWidth: The maximum width of the resulting frame.
    ///   - minHeight: The minimum height of the resulting frame.
    ///   - idealHeight: The ideal height of the resulting frame.
    ///   - maxHeight: The maximum height of the resulting frame.
    ///   - alignment: The alignment of this view inside the resulting frame.
    ///     Note that most alignment values have no apparent effect when the
    ///     size of the frame happens to match that of this view.
    ///
    /// - Returns: A view with flexible dimensions given by the call's non-`nil`
    ///   parameters.
    func frame(
        minWidth: BPKSpacing? = nil,
        idealWidth: BPKSpacing? = nil,
        maxWidth: BPKSpacing? = nil,
        minHeight: BPKSpacing? = nil,
        idealHeight: BPKSpacing? = nil,
        maxHeight: BPKSpacing? = nil,
        alignment: Alignment = .center
    ) -> some View {
        frame(
            minWidth: minWidth?.value,
            idealWidth: idealWidth?.value,
            maxWidth: maxWidth?.value,
            minHeight: minHeight?.value,
            idealHeight: idealHeight?.value,
            maxHeight: maxHeight?.value,
            alignment: alignment
        )
    }
}

public extension HStack {

    /// Creates an instance that arranges its children in a horizontal line.
    ///
    /// - Parameters:
    ///   - alignment: The vertical alignment of the children within the
    ///     stack's bounds.
    ///   - spacing: The distance between the leading edge of one child and the
    ///     trailing edge of the previous child.
    ///   - content: A view builder that creates the children of this stack.
    init(alignment: VerticalAlignment = .center, spacing: BPKSpacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, content: content)
    }
}

public extension VStack {

    /// Creates an instance that arranges its children in a vertical line.
    ///
    /// - Parameters:
    ///   - alignment: The horizontal alignment of the children within the
    ///     stack's bounds.
    ///   - spacing: The distance between the top edge of one child and the
    ///     bottom edge of the previous child.
    ///   - content: A view builder that creates the children of this stack.
    init(alignment: HorizontalAlignment = .center, spacing: BPKSpacing, @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, content: content)
    }
}

public extension LazyVStack {

    /// Creates an instance that arranges its children in a vertical line.
    ///
    /// - Parameters:
    ///   - alignment: The horizontal alignment of the children within the
    ///     stack's bounds.
    ///   - spacing: The distance between the top edge of one child and the
    ///     bottom edge of the previous child.
    ///   - pinnedViews: The set of views that should remain visible when the
    ///     stack is scrolled.
    ///   - content: A view builder that creates the children of this stack.
    init(
        alignment: HorizontalAlignment = .center,
        spacing: BPKSpacing,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, pinnedViews: pinnedViews, content: content)
    }
}

public extension LazyHStack {

    /// Creates an instance that arranges its children in a horizontal line.
    ///
    /// - Parameters:
    ///   - alignment: The vertical alignment of the children within the
    ///     stack's bounds.
    ///   - spacing: The distance between the leading edge of one child and the
    ///     trailing edge of the previous child.
    ///   - pinnedViews: The set of views that should remain visible when the
    ///     stack is scrolled.
    ///   - content: A view builder that creates the children of this stack.
    init(
        alignment: VerticalAlignment = .center,
        spacing: BPKSpacing,
        pinnedViews: PinnedScrollableViews = .init(),
        @ViewBuilder content: () -> Content) {
        self.init(alignment: alignment, spacing: spacing.value, pinnedViews: pinnedViews, content: content)
    }
}

public extension Spacer {

    /// A flexible space that expands along the major axis of its containing stack
    /// layout, or on both axes if not contained in a stack.
    ///
    /// Use this initializer to create a flexible space that expands to fill any
    /// extra space in a stack layout. For example, the following code creates a
    /// horizontal stack with a fixed-width button and a flexible space:
    ///
    ///     HStack {
    ///         BPKButton("Button") { }
    ///         Spacer(.md)
    ///     }
    ///
    /// The button is fixed-width, and the space expands to fill any extra space
    /// in the horizontal stack.
    ///
    /// - Parameter minLength: The minimum length of the space.
    init(minLength: BPKSpacing) {
        self.init(minLength: minLength.value)
    }
}

public extension CGSize {
    
    /// Creates a new size with the specified width and height.
    ///
    /// - Parameters:
    ///   - width: The width of the new size.
    ///   - height: The height of the new size.
    init(width: BPKSpacing, height: BPKSpacing) {
        self.init(width: width.value, height: height.value)
    }
}
