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

import Backpack

// swiftlint:disable:next type_name
final class BottomSheetResizableContentViewController: UIViewController {
    
    var contentDidUpdateConstraints: (() -> Void)?
    
    private var state: State = .collapsed {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var button: Button!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightConstraint.priority = .defaultHigh - 1
        updateUI()
    }
    
    private func updateUI() {
        switch state {
        case .collapsed:
            button.title = "Set content height to 400"
            heightConstraint.constant = 200
        case .expanded:
            button.title = "Set content height to 200"
            heightConstraint.constant = 400
        }
        
        contentDidUpdateConstraints?()
    }
    
    @IBAction private func didClickButton(_ sender: Any) {
        switch state {
        case .collapsed:
            state = .expanded
        case .expanded:
            state = .collapsed
        }
    }
}

extension BottomSheetResizableContentViewController: StoryboardInstantiable {
    static var storyboardType: Storyboard { return .bottomSheet }
}

extension BottomSheetResizableContentViewController {
    enum State {
        case collapsed
        case expanded
    }
}
