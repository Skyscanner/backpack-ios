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
import Combine

public enum CornerStyle {
    case large, small
}

public enum Padding {
    case none, small
}

public struct BPKCardSwiftUIWrapper: View {
    let contentView: UIView

    let elevation: BPKCardElevation
    let padding: Padding
    let cornerStyle: CornerStyle
    let tapAction: () -> Void

    public var body: some View {
        BPKCard(
            padding: padding == .small ? .small : .none,
            cornerStyle: cornerStyle == .small ? .small : .large,
            elevation: elevation
        ) {
          HostedView(view: contentView)
        }
        .onTapGesture(perform: tapAction)
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
            hostedView?.setNeedsLayout()
            hostedView?.layoutIfNeeded()
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

        hostedConstraints = [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        NSLayoutConstraint.activate(hostedConstraints)

        view.setNeedsLayout()
        view.layoutIfNeeded()
        invalidateIntrinsicContentSize()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hostedView?.layoutIfNeeded()
    }

    override var intrinsicContentSize: CGSize {
        guard let hostedView else {
            return .zero
        }

        return hostedView.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize,
            withHorizontalFittingPriority: .fittingSizeLevel,
            verticalFittingPriority: .fittingSizeLevel
        )
    }

    private func configureView() {
        backgroundColor = .clear
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
