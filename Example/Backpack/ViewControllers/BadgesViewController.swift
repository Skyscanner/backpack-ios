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

import UIKit
import Backpack

class BadgesViewController: UIViewController {
    @IBOutlet var badgeCollections: [BPKBadgeContainer]!
    fileprivate static var badgeTypes = [
        BPKBadgeType.success, BPKBadgeType.warning,
        BPKBadgeType.destructive, BPKBadgeType.light,
        BPKBadgeType.inverse, BPKBadgeType.outline
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(badgeCollections.count == BadgesViewController.badgeTypes.count)

        var iterator = 0
        for badgeCollection in badgeCollections {
            badgeCollection.badgeType = BadgesViewController.badgeTypes[iterator]
            iterator += 1
        }
    }
}
