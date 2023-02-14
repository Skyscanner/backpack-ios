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

internal class CardButtonBackgroundView: UIView {

    init() {
        super.init(frame: .zero)

        backgroundColor = BPKColor.textDisabledOnDarkColor
        isUserInteractionEnabled = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateLookAndFeel(
        size: BPKCardButtonSize,
        style: BPKCardButtonStyle,
        parentButton: UIButton
    ) {
        let wasAdded = superview != nil
        guard style.hasBackgroundCircle() else {
            if wasAdded {
                removeFromSuperview()
            }
            return
        }
        guard !wasAdded else { return }

        parentButton.addSubview(self)
        updateSizeAndPositionConstraints(size, parentButton: parentButton)

        parentButton.imageView.map { bringSubviewToFront($0) }
        parentButton.sendSubviewToBack(self)

        print("parentButton.subviews: \(parentButton.subviews)")
    }

    private func updateSizeAndPositionConstraints(
        _ size: BPKCardButtonSize,
        parentButton: UIButton
    ) {
        let circleSize = size.backgroundCircleSize
        layer.cornerRadius = circleSize / 2

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: circleSize),
            heightAnchor.constraint(equalToConstant: circleSize),
            centerXAnchor.constraint(equalTo: parentButton.centerXAnchor),
            centerYAnchor.constraint(equalTo: parentButton.centerYAnchor)
        ])
    }
}
