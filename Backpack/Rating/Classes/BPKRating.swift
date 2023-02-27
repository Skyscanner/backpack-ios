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
import UIKit

public class BPKRating: UIView {

    // MARK: - Public properties
    public var value: Float {
        didSet { updateLookAndFeel() }
    }

    public var ratingScale: BPKRatingScale {
        didSet { updateLookAndFeel() }
    }

    public var size: BPKRatingSize {
        didSet { updateLookAndFeel() }
    }

    public var showScale: Bool {
        didSet { updateLookAndFeel() }
    }

    public var titleView: UIView {
        didSet {
            setupTitleViewConstraint()
            updateLookAndFeel()
        }
    }

    public var title: String {
        get {
            titleLabel.text ?? ""
        }
        set {
            titleLabel.text = newValue
            titleView = titleLabel
            updateLookAndFeel()
        }
    }
    public var subtitle: String? {
        get {
            subtitleLabel.text
        }
        set {
            subtitleLabel.text = newValue
            updateLookAndFeel()
        }
    }

    // MARK: - Subviews
    private let horizontalStackView: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = BPKSpacingMd
        horizontalStack.alignment = .lastBaseline
        return horizontalStack
    }()

    private let ratingValueAndScaleStackView: UIStackView = {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.alignment = .lastBaseline
        return horizontalStack
    }()

    private let titleSubtitleStackView: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .leading
        verticalStack.distribution = .fill
        return verticalStack
    }()

    private let ratingValueLabel = BPKLabel(fontStyle: .textLabel1)

    private let ratingScaleLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: .textCaption)
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()

    private let titleLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: .textLabel1)
        label.textColor = BPKColor.textPrimaryColor
        return label
    }()

    private let subtitleLabel: BPKLabel = {
        let label = BPKLabel(fontStyle: .textBodyDefault)
        label.textColor = BPKColor.textSecondaryColor
        return label
    }()

    private var titleViewBottomConstraint: NSLayoutConstraint?

    // MARK: - Init
    public init(
        accessibilityLabel: String,
        title: String,
        value: Float,
        ratingScale: BPKRatingScale = .zeroToFive,
        size: BPKRatingSize = .default,
        subtitle: String? = nil,
        showScale: Bool = true
    ) {
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.showScale = showScale
        self.titleView = titleLabel
        super.init(frame: .zero)

        self.title = title
        self.subtitle = subtitle

        self.isAccessibilityElement = true
        self.accessibilityLabel = accessibilityLabel

        setup()
        updateLookAndFeel()
    }

    public init(
        accessibilityLabel: String,
        value: Float,
        ratingScale: BPKRatingScale = .zeroToFive,
        size: BPKRatingSize = .default,
        subtitle: String? = nil,
        showScale: Bool = true,
        titleView: UIView
    ) {
        self.value = value
        self.ratingScale = ratingScale
        self.size = size
        self.showScale = showScale
        self.titleView = titleView

        super.init(frame: .zero)

        self.subtitle = subtitle
        self.isAccessibilityElement = true
        self.accessibilityLabel = accessibilityLabel

        setup()
        updateLookAndFeel()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }

    private func setup() {
        addSubview(horizontalStackView)
        
        [
            ratingValueAndScaleStackView,
            titleSubtitleStackView
        ].forEach(horizontalStackView.addArrangedSubview(_:))
        [
            ratingValueLabel,
            ratingScaleLabel
        ].forEach(ratingValueAndScaleStackView.addArrangedSubview(_:))
        [titleView, subtitleLabel].forEach(titleSubtitleStackView.addArrangedSubview(_:))

        setupConstraints()
    }

    private func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        setupTitleViewConstraint()
    }

    private func setupTitleViewConstraint() {
        titleViewBottomConstraint = titleView.bottomAnchor.constraint(
            lessThanOrEqualTo: ratingValueLabel.lastBaselineAnchor
        )
        titleViewBottomConstraint?.priority = .required
    }

    private func updateLookAndFeel() {
        ratingScaleLabel.isHidden = !showScale
        if showScale {
            ratingScaleLabel.text = ratingScale.displayedScale()
        }

        updateSize()
        ratingValueLabel.text = ratingScale.displayedValue(from: value)
        updateCustomTitleViewBottomConstraint()
    }

    private func updateSize() {
        switch size {
        case .default:
            ratingValueLabel.fontStyle = .textLabel1
            ratingScaleLabel.fontStyle = .textCaption
            titleLabel.fontStyle = .textLabel1
            subtitleLabel.fontStyle = .textCaption

            titleSubtitleStackView.axis = .horizontal
            titleSubtitleStackView.spacing = BPKSpacingMd
            titleSubtitleStackView.alignment = .lastBaseline
        case .large:
            ratingValueLabel.fontStyle = .textHero5
            ratingScaleLabel.fontStyle = .textBodyDefault
            titleLabel.fontStyle = .textHeading5
            subtitleLabel.fontStyle = .textBodyDefault

            titleSubtitleStackView.axis = .vertical
            titleSubtitleStackView.spacing = .zero
            titleSubtitleStackView.alignment = .leading
        }
    }

    // When size=large and custom subtitleLabel is hidden,
    // horizontalStackView's alignment = .lastBaseline doesn't work.
    // To avoid the customTitleView being below the ratingValueLabel's baseline,
    // an extra constraint is needed to pin the view's bottom to the ratingValueLabel's baseline
    private func updateCustomTitleViewBottomConstraint() {
        let isShowingCustomTitleView = titleView != titleLabel
        let isLargeSize = size == .large
        let isSubtitleLabelHidden = subtitleLabel.text == nil
        let isAddedToSuperView = titleView.superview != nil

        if isShowingCustomTitleView && isSubtitleLabelHidden &&
            isLargeSize && isAddedToSuperView {
            titleViewBottomConstraint?.isActive = true
        } else {
            titleViewBottomConstraint?.isActive = false
        }
    }
}
