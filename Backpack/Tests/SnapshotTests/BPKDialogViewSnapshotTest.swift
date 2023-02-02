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

import XCTest
import Backpack
import SnapshotTesting

class BPKDialogViewSnapshotTest: XCTestCase {
    override func setUp() {
        super.setUp()
        isRecording = false
    }
    
    /// Needed to draw the shadow
    private func wrap(_ dialog: BPKDialogView) -> UIView {
        let parent = UIView(frame: .zero)
        let margin = BPKSpacingBase
        parent.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        parent.translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(dialog)
        let marginGuide = parent.layoutMarginsGuide
        NSLayoutConstraint.activate([
            marginGuide.topAnchor.constraint(equalTo: dialog.topAnchor),
            marginGuide.leadingAnchor.constraint(equalTo: dialog.leadingAnchor),
            dialog.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            dialog.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor)
        ])
        return parent
    }
    
    private func dialog(
        title: String?,
        message: String,
        icon: BPKDialogIconDefinition?,
        graphicView: UIView? = nil,
        actions: [BPKDialogButtonAction] = [],
        cornerStyle: BPKDialogCornerStyle = .large,
        textAlignmnet: NSTextAlignment = .center
    ) -> BPKDialogView {
        let dialog = BPKDialogView(
            title: title,
            message: message,
            iconDefinition: icon,
            graphicView: graphicView,
            textAlignment: textAlignmnet
        )
        dialog.translatesAutoresizingMaskIntoConstraints = false
        dialog.widthAnchor.constraint(lessThanOrEqualToConstant: 320).isActive = true
        dialog.cornerStyle = cornerStyle
        actions.forEach(dialog.addButtonAction(_:))
        return dialog
    }
    
    private let title = "Lorem Ipsum"
    private let message = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean tempor dapibus laoreet.
    Maecenas pharetra bibendum condimentum. Nulla malesuada euismod justo, vel commodo metus \
    venenatis vitae. Cras sollicitudin porttitor semper.
    """
    
    func testDialogViewNoButtons() {
        let dialog = dialog(title: title, message: message, icon: .tick(.accent))
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithButtons() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: .lighting(.warning),
            actions: [.continue, .skip]
        )
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndFlareViewAndButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            graphicView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndFlareViewAndSmallButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            graphicView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        dialog.buttonSize = .default
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndTallFlareViewAndButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            graphicView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        flare.heightAnchor.constraint(equalToConstant: 280).isActive = true
        dialog.buttonSize = .default
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithNoIcon() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            actions: [.continue, .skip]
        )
        assertSnapshot(wrap(dialog))
    }
    
    func testDialogViewWithNoIconAndNoTitle() {
        let dialog = dialog(
            title: nil,
            message: message,
            icon: nil,
            actions: [.continue, .skip]
        )
        assertSnapshot(wrap(dialog))
    }
    
    func testChangingIconDefinitionAfterPresenting() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: .lighting(.warning),
            actions: [.continue, .skip]
        )
        let wrapper = wrap(dialog)
        dialog.iconDefinition = .key(.danger)
        assertSnapshot(wrapper)
    }
    
    func testDialogWithImageView() {
        let imageView = UIImageView()
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            graphicView: imageView,
            actions: [.continue, .skip],
            cornerStyle: .default,
            textAlignmnet: .left
        )
        imageView.backgroundColor = BPKColor.skyBlue
        imageView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        assertSnapshot(wrap(dialog))
    }
}

private extension BPKDialogButtonAction {
    static var skip: BPKDialogButtonAction {
        BPKDialogButtonAction(title: "Skipz", style: .secondary) { _ in }
    }
    
    static var `continue`: BPKDialogButtonAction {
        BPKDialogButtonAction(title: "Continue", style: .primary) { _ in }
    }
}

private extension BPKDialogIconDefinition {
    static func tick(_ color: UIColor) -> BPKDialogIconDefinition {
        large(named: .tick, color: color)
    }
    
    static func lighting(_ color: UIColor) -> BPKDialogIconDefinition {
        large(named: .lightning, color: color)
    }
    
    static func key(_ color: UIColor) -> BPKDialogIconDefinition {
        large(named: .key, color: color)
    }
    
    private static func large(named: BPKLargeIconName, color: UIColor) -> BPKDialogIconDefinition {
        BPKDialogIconDefinition(
            icon: BPKIcon.makeLargeTemplateIcon(name: named),
            iconBackgroundColor: color
        )
    }
}

private extension UIColor {
    static let accent = BPKColor.coreAccentColor
    static let warning = BPKColor.statusWarningSpotColor
    static let danger = BPKColor.statusDangerSpotColor
}
