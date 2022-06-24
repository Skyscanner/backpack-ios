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

class MockImage: UIImage {
    var identifier: String?

    override func isEqual(_ object: Any?) -> Bool {
        guard let otherImage: MockImage = object as? MockImage else {
            return false
        }

        return otherImage.identifier == identifier
    }

    override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage {
        return self
    }
}

extension MockImage {
    convenience init(identifier: String) {
        self.init()
        self.identifier = identifier
    }
}

public class TestBundle: NSObject {
    public static var iconsBundle: Bundle {
        guard
            let url = Bundle(for: TestBundle.self).resourceURL?.appendingPathComponent("UnitTestImages.bundle"),
            let bundle = Bundle(url: url)
        else {
            return .main
        }
        return bundle
    }
}

class BPKTabBarItemTest: XCTestCase {

    func testCreateWithoutIconDefintion() {
        let tabBarItem = BPKTabBarItem(
            title: "Tab bar 1",
            image: BPKIcon.makeLargeTemplateIcon(name: .settings),
            tag: 1
        )

        XCTAssertNotNil(tabBarItem)
        XCTAssertEqual(
            tabBarItem.dotShown,
            false,
            "dotShown should be false initially"
        )
        XCTAssertEqual(
            tabBarItem.dotImageDefinition,
            nil,
            "dotImageDefinition should be nil if none was specified during creation"
        )
    }

    func testCreateWithIconDefintion() {
        let regularImage = BPKIcon.makeLargeTemplateIcon(name: .settings)
        let lightImage = UIImage(named: "tab_profile_with_dot_lm", in: TestBundle.iconsBundle, compatibleWith: nil)!
        let darkImage = UIImage(named: "tab_profile_with_dot_dm", in: TestBundle.iconsBundle, compatibleWith: nil)!

        let dotImageDefinition = BPKTabBarDotImageDefinition(lightImage: lightImage, darkImage: darkImage)
        let tabBarItem = BPKTabBarItem(
            title: "Tab bar 1",
            image: regularImage,
            tag: 1,
            dotImageDefinition: dotImageDefinition
        )

        XCTAssertNotNil(tabBarItem)
        XCTAssertEqual(
            tabBarItem.dotShown,
            false,
            "dotShown should be false initially"
        )
        XCTAssertEqual(
            tabBarItem.dotImageDefinition,
            dotImageDefinition,
            "dotImageDefinition should have the value supplied on creation"
        )
    }

    func testSettingImageWithIconDefintion() {
        let regularImage = MockImage(identifier: "regular")
        let lightImage = MockImage(identifier: "tab_profile_with_dot_lm")
        let darkImage = MockImage(identifier: "tab_profile_with_dot_dm")

        let dotImageDefinition = BPKTabBarDotImageDefinition(lightImage: lightImage, darkImage: darkImage)
        let tabBarItem = BPKTabBarItem(
            title: "Tab bar 1",
            image: regularImage,
            tag: 1,
            dotImageDefinition: dotImageDefinition
        )

        XCTAssertEqual(
            tabBarItem.image,
            regularImage,
            "dotImageDefinition should render the regular image on creation"
        )
        tabBarItem.addDot()
        XCTAssertEqual(
            tabBarItem.image,
            lightImage,
            "dotImageDefinition should render the light dot image when dot added"
        )
        tabBarItem.interfaceStyle = .dark
        XCTAssertEqual(
            tabBarItem.image,
            darkImage,
            "dotImageDefinition should render the dark dot image when in dark mode"
        )
        tabBarItem.removeDot()
        XCTAssertEqual(
            tabBarItem.image,
            regularImage,
            "dotImageDefinition should render the regular image when the dot is removed"
        )
    }
}
