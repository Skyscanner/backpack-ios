/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2025 Skyscanner Ltd
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

// swiftlint:disable indentation_width
import SwiftUI

public enum CornerStyle {
    case large, small
}

public struct BPKCardSwiftUIWrapper: View {
    var contentView: UIView

    var elevation: BPKCardElevation
    var padded: Bool
    var cornerStyle: CornerStyle
    var tapAction: (() -> Void)?

    public init(contentView: UIView, elevation: BPKCardElevation = .default, padded: Bool = true, cornerStyle: CornerStyle = .small, tapAction: (() -> Void)? = nil) {
        self.contentView = contentView
        self.elevation = elevation
        self.padded = padded
        self.cornerStyle = cornerStyle
        self.tapAction = tapAction
    }

    public var body: some View {
        BPKCard(
            padding: padded ? .small : .none,
            cornerStyle: cornerStyle == .small ? .small : .large,
            elevation: elevation
        ) {
          HostedView(view: contentView)
        }
        .if(tapAction != nil) { view in
            view.onTapGesture(perform: tapAction!)
        }
    }
}

private struct HostedView: UIViewRepresentable {
    let view: UIView

    func makeUIView(context: Context) -> HostedUIViewContainer {
        let container = HostedUIViewContainer()
        container.host(view)
        return container
    }

    func updateUIView(_ uiView: HostedUIViewContainer, context: Context) {
        uiView.host(view)
    }

    func sizeThatFits(_ proposal: ProposedViewSize, uiView: HostedUIViewContainer, context: Context) -> CGSize? {
        guard let width = proposal.width else {
            return nil
        }

        let height = proposal.height ?? .infinity
        let size = uiView.sizeThatFits(CGSize(width: width, height: height))
        return size
    }
}

private final class HostedUIViewContainer: UIView {
    private weak var hostedView: UIView?
    private var hostedConstraints: [NSLayoutConstraint] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    func host(_ view: UIView) {
        guard hostedView !== view else {
            invalidateIntrinsicContentSize()
            return
        }

        hostedView?.removeFromSuperview()
        NSLayoutConstraint.deactivate(hostedConstraints)
        hostedConstraints.removeAll()

        hostedView = view
        view.removeFromSuperview()
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        // Pin all edges to ensure the view fills this container
        hostedConstraints = [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(hostedConstraints)

        invalidateIntrinsicContentSize()
    }

    override var bounds: CGRect {
        didSet {
            // Only trigger layout if bounds actually changed significantly
            // This prevents infinite loops from temporary bounds changes in sizeThatFits
            guard abs(oldValue.width - bounds.width) > 0.5 ||
                  abs(oldValue.height - bounds.height) > 0.5 else {
                return
            }
            hostedView?.setNeedsLayout()
            invalidateIntrinsicContentSize()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hostedView?.layoutIfNeeded()
    }

    override var intrinsicContentSize: CGSize {
        guard let hostedView else {
            return .zero
        }

        // Try to use bounds width if available, otherwise fall back to frame width
        var width = bounds.width
        if width <= 0 {
            width = frame.width
        }

        // If still no width, return a size that indicates we need width constraint
        guard width > 0 else {
            return CGSize(width: UIView.noIntrinsicMetric, height: UIView.noIntrinsicMetric)
        }

        let size = hostedView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        return size
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let hostedView else {
            return .zero
        }

        let width = size.width > 0 ? size.width : bounds.width

        let fittingSize = hostedView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        return fittingSize
    }

    private func configureView() {
        backgroundColor = .clear
        clipsToBounds = true
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
