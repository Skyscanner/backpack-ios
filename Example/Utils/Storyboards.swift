//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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

enum Storyboard: String {
    case bottomSheet

    var make: UIStoryboard {
        return UIStoryboard(name: self.rawValue.capitalizingFirstLetter(), bundle: Bundle.main)
    }
}

protocol StoryboardInstantiable {
    static var storyboardType: Storyboard { get }
    static func make() -> Self?
}

extension StoryboardInstantiable where Self: UIViewController {

    static func make() -> Self? {
        let storyboard = storyboardType.make
        let identifier = NSStringFromClass(Self.self).components(separatedBy: ".").last
        return identifier.map { storyboard.instantiateViewController(withIdentifier: $0) } as? Self
    }

}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
