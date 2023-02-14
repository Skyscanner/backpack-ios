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

    var backgroundCircle: UIView { get }
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
        backgroundCircle.backgroundColor = BPKColor.textDisabledOnDarkColor
        backgroundCircle.isUserInteractionEnabled = false
        backgroundCircle.translatesAutoresizingMaskIntoConstraints = false

        let wasAdded = backgroundCircle.superview != nil
        guard style.hasBackgroundCircle() else {
            if wasAdded {
                backgroundCircle.removeFromSuperview()
            }
            return
        }

        guard !wasAdded else { return }
        addSubview(backgroundCircle)
        let circleSize = size.backgroundCircleSize
        backgroundCircle.layer.cornerRadius = circleSize / 2

        NSLayoutConstraint.activate([
            backgroundCircle.widthAnchor.constraint(equalToConstant: circleSize),
            backgroundCircle.heightAnchor.constraint(equalToConstant: circleSize),
            backgroundCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundCircle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        imageView.map { bringSubviewToFront($0) }
    }

}
