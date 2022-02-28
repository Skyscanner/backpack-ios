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

import FBSnapshotTestCase

class BPKDialogViewSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = true
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
        flareView: BPKFlareView? = nil,
        actions: [BPKDialogButtonAction] = [],
        cornerStyle: BPKDialogCornerStyle = .large
    ) -> BPKDialogView {
        let dialog = BPKDialogView(title: title, message: message, iconDefinition: icon, flareView: flareView)
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
        let dialog = dialog(title: title, message: message, icon: .tick(.monteverde))
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithButtons() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: .lighting(.kolkata),
            actions: [.continue, .skip]
        )
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndFlareViewAndButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            flareView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndFlareViewAndSmallButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            flareView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        dialog.buttonSize = .default
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithLargeCornerStyleAndTallFlareViewAndButtons() {
        let flare = BPKFlareView(frame: .zero)
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            flareView: flare,
            actions: [.continue, .skip],
            cornerStyle: .large
        )
        flare.backgroundView.backgroundColor = BPKColor.skyBlue
        flare.heightAnchor.constraint(equalToConstant: 280).isActive = true
        dialog.buttonSize = .default
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithNoIcon() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: nil,
            actions: [.continue, .skip]
        )
        dialog.style = .alert
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testDialogViewWithNoIconAndNoTitle() {
        let dialog = dialog(
            title: nil,
            message: message,
            icon: nil,
            actions: [.continue, .skip]
        )
        dialog.style = .alert
        BPKSnapshotVerifyViewLight(wrap(dialog))
    }
    
    func testChangingIconDefinitionAfterPresenting() {
        let dialog = dialog(
            title: title,
            message: message,
            icon: .lighting(.kolkata),
            actions: [.continue, .skip]
        )
        let wrapper = wrap(dialog)
        dialog.iconDefinition = .key(.panjin)
        BPKSnapshotVerifyViewLight(wrapper)
    }
}

private extension BPKDialogButtonAction {
    static var skip: BPKDialogButtonAction {
        BPKDialogButtonAction(title: "Skipz", style: .link) { _ in }
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
    static let monteverde = BPKColor.monteverde
    static let kolkata = BPKColor.kolkata
    static let panjin = BPKColor.panjin
}
