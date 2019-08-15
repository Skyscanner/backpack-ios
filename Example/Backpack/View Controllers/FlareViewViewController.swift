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

class FlareViewViewController: UIViewController {
    @IBOutlet weak var flareViewView: FlareView!

    var showFlare: Bool = true
    var backgroundImage: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        flareViewView.isFlareVisible = showFlare
        flareViewView.backgroundColor = Color.blue500

        let label = Label(fontStyle: .textXlEmphasized)
        label.text = "Much wow!"
        label.textColor = Color.white
        label.translatesAutoresizingMaskIntoConstraints = false
        flareViewView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: flareViewView.contentView.topAnchor, constant: BPKSpacingBase),
            label.leadingAnchor.constraint(equalTo: flareViewView.contentView.leadingAnchor, constant: BPKSpacingBase)
            ])

        if backgroundImage {
            if let imageURL = URL(string: "https://live.staticflickr.com/65535/47591735142_10d889b77c_h.jpg") {
                if let imageData = try? Data(contentsOf: imageURL) {
                    let image = UIImage.init(data: imageData)
                    let imageView = UIImageView.init(image: image)
                    imageView.contentMode = .scaleAspectFill
                    imageView.translatesAutoresizingMaskIntoConstraints = false

                    flareViewView.addSubview(imageView)

                    NSLayoutConstraint.activate([
                        imageView.heightAnchor.constraint(equalTo: flareViewView.heightAnchor),
                        imageView.widthAnchor.constraint(equalTo: flareViewView.widthAnchor),
                        imageView.topAnchor.constraint(equalTo: flareViewView.topAnchor),
                        imageView.leadingAnchor.constraint(equalTo: flareViewView.leadingAnchor),
                        flareViewView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
                        flareViewView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
                        ])
                }
            }
        }
    }
}
