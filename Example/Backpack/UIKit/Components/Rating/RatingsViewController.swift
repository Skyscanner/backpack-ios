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
import Backpack_Common

final class RatingsViewController: UIViewController {

    enum TitleType {
        case stringLabel
        case starRating
        case imageView
    }

    private struct RatingInputs {
        let ratingScale: BPKRatingScale
        let size: BPKRatingSize
        let subtitle: String?
        let showScale: Bool
    }

    private let titleType: TitleType

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let stack: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.alignment = .leading
        stack.spacing = BPKSpacingSm
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()

    init(titleType: TitleType) {
        self.titleType = titleType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceDefaultColor
        setupView()
    }

    private let sizes = [BPKRatingSize.default, BPKRatingSize.large]
    private let titles = ["1,532 reviews", nil]
    private let visibilityAndScalesType = [
        (true, BPKRatingScale.zeroToFive),
        (true, BPKRatingScale.zeroToTen),
        (false, BPKRatingScale.zeroToFive)
    ]

    private func setupView() {
        sizes.forEach { size in
            titles.forEach { (subtitle: String?) in
                visibilityAndScalesType.forEach { (showScale: Bool, scale: BPKRatingScale) in
                    let rating = createRating(
                        scale: scale,
                        size: size,
                        subtitle: subtitle,
                        showScale: showScale
                    )
                    stack.addArrangedSubview(rating)
                }
            }
        }

        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        setupConstraints()
    }

    private func createRating(
        value: Float = 4.5,
        scale: BPKRatingScale,
        size: BPKRatingSize,
        subtitle: String?,
        showScale: Bool
    ) -> BPKRating {
        let title = titleType == .stringLabel ? "Excellent" : nil
        let accessibilityLabel = accessibilityLabel(
            value: value,
            title: title,
            scale: scale,
            subtitle: subtitle
        )

        switch titleType {
        case .stringLabel:
            return BPKRating(
                accessibilityLabel: accessibilityLabel,
                title: title ?? "",
                value: value,
                ratingScale: scale,
                size: size,
                subtitle: subtitle,
                showScale: showScale
            )
        case .starRating:
            let starRating = BPKStarRating()
            starRating.rating = 4.5
            return BPKRating(
                accessibilityLabel: accessibilityLabel,
                value: value,
                ratingScale: scale,
                size: size,
                subtitle: subtitle,
                showScale: showScale,
                titleView: starRating
            )
        case .imageView:
            return BPKRating(
                accessibilityLabel: accessibilityLabel,
                value: value,
                ratingScale: scale,
                size: size,
                subtitle: subtitle,
                showScale: showScale,
                titleView: createLogoImageView()
            )
        }
    }

    private func createLogoImageView() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "backpack-logo-horizontal"))
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: BPKIcon.concreteSizeForLargeIcon.height),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 60/13)
        ])
        return imageView
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stack.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: BPKSpacingBase
            ),
            stack.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -BPKSpacingBase
            ),
            stack.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                constant: -BPKSpacingBase * 2
            )
        ])
    }

    private func accessibilityLabel(
        value: Float,
        title: String? = nil,
        scale: BPKRatingScale,
        subtitle: String?
    ) -> String {
        var accessibilityLabel = ""

        if let title = title {
            accessibilityLabel += "Rated \(title), "
        }

        let scaleString: String
        switch scale {
        case .zeroToTen:
            scaleString = "10"
        case .zeroToFive:
            scaleString = "5"
        }
        accessibilityLabel += "\(value) out of \(scaleString). "

        if let subtitle = subtitle {
            accessibilityLabel += "Based on \(subtitle)"
        }

        return accessibilityLabel
    }
}
