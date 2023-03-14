# Backpack/Floating Notification

[![Cocoapods](https://img.shields.io/cocoapods/v/Backpack.svg?style=flat)](https://cocoapods.org/pods/Backpack)
[![class reference](https://img.shields.io/badge/Class%20reference-iOS-blue)](https://backpack.github.io/ios/versions/latest/uikit/Classes/BPKFloatingNotification.html)
[![view on Github](https://img.shields.io/badge/Source%20code-GitHub-lightgrey)](https://github.com/Skyscanner/backpack-ios/tree/main/Backpack/FloatingNotification)

## Default

| Day | Night |
| --- | --- |
| <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-floating-notification___default_lm.png" alt="" width="375" /> | <img src="https://raw.githubusercontent.com/Skyscanner/backpack-ios/main/screenshots/iPhone-floating-notification___default_dm.png" alt="" width="375" /> |

## Usage

Example of a Floating Notification:

```swift
import Backpack

final class ExampleViewController: UIViewController {
    private lazy var exampleButton: BPKButton = {
        let button = BPKButton(size: .default, style: .primary)
        button.title = "Show"
        button.addTarget(self, action: #selector(showNotificationTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(exampleButton)
        exampleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exampleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func showNotificationTapped() {
        BPKFloatingNotification.show(.titleOnly(parentView: view, title: "Saved"))
    }
}
```

Example of a Floating Notification with icon and action:

```swift
import Backpack

final class ExampleViewController: UIViewController {
    private lazy var exampleButton: BPKButton = {
        let button = BPKButton(size: .default, style: .primary)
        button.title = "Show"
        button.addTarget(self, action: #selector(showNotificationTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(exampleButton)
        exampleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            exampleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exampleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func showNotificationTapped() {
        let action = { print("Tapped button") }

        BPKFloatingNotification.show(            
            .titleWithIconAndAction(
                parentView: view,
                title: "Saved",
                iconName: .heart,
                action: .action(title: "View", action: action)
            )
        )
    }
}
```
