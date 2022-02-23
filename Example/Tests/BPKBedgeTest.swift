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
import FBSnapshotTestCase

class BPKBadgeSnapshotTest: FBSnapshotTestCase {
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    private func createViewWithTypes(andIcon icon: BPKBadge.Icon? = nil) -> UIView {
        let stackView = createStackView()
        let parentView = UIView(frame: .zero)
        parentView.backgroundColor = BPKColor.skyGrayTint06
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(stackView)
        
        let badges = [BPKBadgeType.light, .inverse, .outline, .success, .warning, .destructive]
            .map { BPKBadge(type: $0, icon: icon, message: "Backpack rocks!") }
        badges.forEach(stackView.addArrangedSubview(_:))
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            parentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            parentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        return parentView
    }
    
    func testViewSnapshotWithTypes() {
        let lightView = createViewWithTypes()
        let darkView = createViewWithTypes()
        
        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }
    
    func testViewSnapshotWithLeadingIcon() {
        let icon = BPKBadge.Icon(position: .leading, iconName: BPKSmallIconName.time)
        let lightView = createViewWithTypes(andIcon: icon)
        let darkView = createViewWithTypes(andIcon: icon)
        
        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }
    
    func testViewSnapshotWithTrailingIcon() {
        let icon = BPKBadge.Icon(position: .trailing, iconName: BPKSmallIconName.time)
        let lightView = createViewWithTypes(andIcon: icon)
        let darkView = createViewWithTypes(andIcon: icon)
        
        BPKSnapshotVerifyViewLight(lightView)
        BPKSnapshotVerifyViewDark(darkView)
    }
}
