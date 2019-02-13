/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2019 Skyscanner Ltd
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
import Backpack.Icon

class UITableViewSelectableCell: UITableViewCell {
    let tickIcon: IconView = IconView(iconName: IconName.tick, size: BPKIconSize.small)

    func setApplied(applied: Bool) {
        if(applied) {
            tickIcon.tintColor = Color.blue500
            self.addSubview(tickIcon)
            tickIcon.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tickIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                tickIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -0.5*BPKSpacingXl)
                ])
        } else {
            tickIcon.removeFromSuperview()
        }
    }

}
