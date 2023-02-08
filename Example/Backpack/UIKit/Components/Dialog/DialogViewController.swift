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

enum DialogType {
    case success, warning, destructive, flare, image
}

class DialogViewController: UIViewController {
    var type: DialogType = .success
    
    private lazy var showButton: BPKButton = {
        let button = BPKButton(size: .large, style: .primary)
        button.title = "Show dialog"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showDialog), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.canvasColor
        
        setupView()
    }
    
    @objc
    private func showDialog() {
        let message = "Description that goes two lines ideally, but sometimes it can go longer"
        var dialogController: BPKDialogController
        
        if type == .flare {
            let flareView = BPKFlareView(frame: .zero)
            let image = UIImage(named: "dialog_flare")
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false

            flareView.backgroundView.addSubview(imageView)
            
            dialogController = BPKDialogController(
                title: dialogTitle,
                message: message,
                iconDefinition: icon,
                flareView: flareView
            )
        } else if type == .image {
            let image = UIImage(named: "dialog_image")
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            dialogController = BPKDialogController(
                title: dialogTitle,
                message: message,
                imageView: imageView,
                textAlignment: .left
            )
        } else {
            dialogController = BPKDialogController(
                title: dialogTitle,
                message: message,
                iconDefinition: icon,
                flareView: nil
            )
        }
        
        if type != .destructive {
            let scrimAction = BPKDialogScrimAction(handler: { (didDismiss) in
                print("Scrim tap \(didDismiss ? "dimissing" : "")")
            }, shouldDismiss: true)
            dialogController.scrimAction = scrimAction
        }

        dialogActions.forEach(dialogController.addButtonAction)
        
        self.present(dialogController, animated: true, completion: nil)
    }
}

// MARK: Util functions
extension DialogViewController {
    private func setupView() {
        view.addSubview(showButton)
        
        NSLayoutConstraint.activate([
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private var icon: BPKDialogIconDefinition? {
        switch type {
        case .success:
            let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .tick)
            return BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.coreAccentColor)
        case .warning:
            let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .alertAdd)
            return BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.statusWarningSpotColor)
        case .destructive:
            let iconTemplate = BPKIcon.makeLargeTemplateIcon(name: .trash)
            return BPKDialogIconDefinition(icon: iconTemplate, iconBackgroundColor: BPKColor.statusDangerSpotColor)
        default:
            return nil
        }
    }
    
    private var dialogTitle: String {
        switch type {
        case .destructive:
            return "Delete"
        default:
            return "Title in here"
        }
    }
    
    private var dialogActions: [BPKDialogButtonAction] {
        switch type {
        case .destructive:
            return [
                .init(title: "Delete", style: .destructive, handler: { _ in
                    print("Delete tapped")
                }),
                .init(title: "Cancel", style: .link, handler: { _ in
                    print("Cancel tapped")
                })
            ]
        case .image:
            return [
                .init(title: "Confirmation", style: .featured, handler: { _ in
                    print("Confirmation tapped")
                }),
                .init(title: "Skip", style: .secondary, handler: { _ in
                    print("Skip tapped")
                })
            ]
        default:
            return [
                .init(title: "Confirmation", style: .featured, handler: { _ in
                    print("Confirmation tapped")
                }),
                .init(title: "Skip", style: .secondary, handler: { _ in
                    print("Skip tapped")
                }),
                .init(title: "Link optional", style: .link, handler: {_ in
                    print("Optional link tapped")
                })
            ]
        }
    }
}
