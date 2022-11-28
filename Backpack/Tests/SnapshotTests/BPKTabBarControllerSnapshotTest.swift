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

class BPKTabBarControllerSnapshotTest: XCTestCase {
    
    let darkTrait = UITraitCollection(userInterfaceStyle: .dark)
    let lightTrait = UITraitCollection(userInterfaceStyle: .light)
    let rtlTrait = UITraitCollection(layoutDirection: .rightToLeft)
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    func testTabBarController() {
        // Given
        let sut = BPKTabBarController()
        
        sut.tabBar.unselectedItemTintColor = BPKColor.textSecondaryColor
        sut.tabBar.tintColor = BPKColor.coreAccentColor
        
        let tabOne = UIViewController()
        tabOne.tabBarItem = UITabBarItem(title: "Tab 1", image: nil, tag: 1)
        
        let tabTwo = UIViewController()
        tabTwo.tabBarItem = UITabBarItem(title: "Tab 2", image: nil, tag: 2)
        
        // When
        sut.viewControllers = [tabOne, tabTwo]
        
        // Then
        assertSnapshot(matching: sut, as: .image(traits: lightTrait))
        assertSnapshot(matching: sut, as: .image(traits: darkTrait))
        assertSnapshot(matching: sut, as: .image(traits: rtlTrait))
    }
    
    func testTabBarControllerWithIcons() {
        // Given
        let sut = BPKTabBarController()
        
        sut.tabBar.unselectedItemTintColor = BPKColor.textSecondaryColor
        sut.tabBar.tintColor = BPKColor.coreAccentColor
        
        // Tab 1
        let tabOne = UIViewController()
        tabOne.tabBarItem = UITabBarItem(title: "Tab 1", image: BPKIcon.makeLargeTemplateIcon(name: .key), tag: 1)
        
        let dotImageDefinition = BPKTabBarDotImageDefinition(
            lightImage: image(named: "tab_explore_with_dot_lm")!,
            darkImage: image(named: "tab_explore_with_dot_dm")!
        )
        
        // Tab 2
        let tabTwo = UIViewController()
        let tabTwoItem = BPKTabBarItem(
            title: "Tab 2",
            image: BPKIcon.makeLargeTemplateIcon(name: .explore),
            tag: 2,
            dotImageDefinition: dotImageDefinition
        )
        
        tabTwoItem.addDot()
        tabTwo.tabBarItem = tabTwoItem

        // Tab 3
        let tabThree = UIViewController()
        tabThree.tabBarItem = UITabBarItem(title: "Tab 3", image: BPKIcon.makeLargeTemplateIcon(name: .key), tag: 3)
        tabThree.tabBarItem.badgeColor = BPKColor.statusDangerSpotColor
        tabThree.tabBarItem.badgeValue = "42"
        
        // When
        sut.viewControllers = [tabOne, tabTwo, tabThree]
        
        // Then
        assertSnapshot(matching: sut, as: .image(traits: lightTrait))
        assertSnapshot(matching: sut, as: .image(traits: darkTrait))
        assertSnapshot(matching: sut, as: .image(traits: rtlTrait))
    }
    
    // MARK: Helpers
    private func image(named: String) -> UIImage? {
        
        guard let bundlePath = Bundle(for: Self.self).path(forResource: "SnapshotTestImages", ofType: "bundle") else {
            print("Could not locate resource")
            return nil
        }
        
        let bundle = Bundle(path: bundlePath)
        return UIImage(named: named, in: bundle, compatibleWith: nil)
    }
}
