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

import Backpack.OverlayView

class OverlayViewsViewController: UIViewController {
    @IBOutlet weak var overlayView: BPKOverlayView!
    var cornerStyle: BPKOverlayViewCornerStyle = .small
    var overlayType: BPKOverlayViewOverlayType = .tint
    var showContent: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupOverlayView()
    }

    func setupOverlayView() {
        overlayView.overlayType = overlayType
        overlayView.cornerStyle = cornerStyle

        // Add foreground content
        if showContent {
            let label = BPKLabel(fontStyle: .textBodyDefault)
            label.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit."
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.numberOfLines = 0
            label.textColor = BPKColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            overlayView.foregroundView.addSubview(label)

            NSLayoutConstraint.activate([
                label.widthAnchor.constraint(equalTo: overlayView.widthAnchor, constant: -BPKSpacingLg),
                label.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
            ])
        }

        // Add background content
        let image = UIImage(named: "pilanesburg-south-africa")
        let imageView = UIImageView.init(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        overlayView.backgroundView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: overlayView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
}
