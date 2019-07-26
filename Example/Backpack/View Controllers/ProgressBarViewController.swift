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

class ProgressBarViewController: UIViewController {
    @IBOutlet weak var progressBar: ProgressBar!
    @IBOutlet weak var increaseButton: Button!
    @IBOutlet weak var resetButton: Button!

    override func viewDidLoad() {
        super.viewDidLoad()

        progressBar.progress = 0.0
        resetButton.style = .secondary
        resetButton.isEnabled = false

        increaseButton.addTarget(self, action: #selector(increaseButtonTapped), for: .touchUpInside)

        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }

    @objc
    func increaseButtonTapped() {
        let newProgress = progressBar.progress + 0.333
        progressBar.setProgress(newProgress, animated: true)

        resetButton.isEnabled = true
    }

    @objc
    func resetButtonTapped() {
        progressBar.setProgress(0.0, animated: true)

        resetButton.isEnabled = false
    }
}
