/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2021 Skyscanner Ltd. All rights reserved.
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

class NudgerViewController: UIViewController {
    lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none

        return formatter
    }()

    lazy var configuration: BPKNudgerConfiguration = {
        let numberFormatter = self.numberFormatter
        return BPKNudgerConfiguration(
            labelFormatter: { (value) -> String in
                numberFormatter.string(from: NSNumber(value: value)) ?? ""
            },
            accessibilityLabelFormatter: { (value) -> String in
                guard let number = numberFormatter.string(from: NSNumber(value: value)) else {
                    return ""
                }

                return "\(number) passengers"
            })

    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = BPKColor.backgroundColor

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let nudger = BPKNudger(configuration: configuration)
        nudger.translatesAutoresizingMaskIntoConstraints = false
        nudger.value = 1
        nudger.minimumValue = 1
        nudger.maximumValue = 10

        nudger.addTarget(self, action: #selector(nudgerValueChanged(sender:)), for: .valueChanged)

        view.addSubview(nudger)

        NSLayoutConstraint.activate([
            nudger.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nudger.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc
    func nudgerValueChanged(sender: BPKNudger) {
        print("Nudger value changed: \(sender.value)")
    }
}
