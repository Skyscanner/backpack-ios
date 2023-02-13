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

/**
 An Internal protocol that holds shared logic between ShareCardButton & SaveCardButton
 */
internal protocol CardButtonProtocol {
    var size: BPKCardButtonSize { get }
    var style: BPKCardButtonStyle { get }

    var containedBackgroundCircle: UIView { get }
}

extension CardButtonProtocol where Self: UIButton {

    func setup() {
        translatesAutoresizingMaskIntoConstraints = false

        // CardButton Required a larger hit area of at least 48px
        let widthHeight = BPKSpacingLg * 2
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: widthHeight),
            heightAnchor.constraint(equalToConstant: widthHeight)
        ])
    }

    func updateBackgroundCircleView() {
        containedBackgroundCircle.backgroundColor = BPKColor.textDisabledOnDarkColor
        containedBackgroundCircle.isUserInteractionEnabled = false
        containedBackgroundCircle.translatesAutoresizingMaskIntoConstraints = false

        let wasAdded = containedBackgroundCircle.superview != nil
        guard shouldAddButtonBackground(style: style) else {
            if wasAdded {
                containedBackgroundCircle.removeFromSuperview()
            }
            return
        }

        guard !wasAdded else { return }
        addSubview(containedBackgroundCircle)
        let circleSize = buttonBackgroundSize(size: size)
        containedBackgroundCircle.layer.cornerRadius = circleSize / 2

        NSLayoutConstraint.activate([
            containedBackgroundCircle.widthAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.heightAnchor.constraint(equalToConstant: circleSize),
            containedBackgroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            containedBackgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        imageView.map { bringSubviewToFront($0) }
    }

    // MARK: - Private helpers
    private func shouldAddButtonBackground(style: BPKCardButtonStyle) -> Bool {
        switch style {
        case .contained:
            return true
        default:
            return false
        }
    }

    private func buttonBackgroundSize(size: BPKCardButtonSize) -> CGFloat {
        switch size {
        case .default:
            return BPKIcon.concreteSizeForLargeIcon.width + BPKSpacingBase
        case .small:
            return BPKIcon.concreteSizeForSmallIcon.width + BPKSpacingBase
        }
    }
}
