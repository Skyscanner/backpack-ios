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

import FloatingPanel

final class BPKFloatingPanelController: FloatingPanelController {
    var bottomSheet: BPKBottomSheet?

    var onDismissed: (() -> Void)?

    var bottomSectionViewController: UIViewController? {
        didSet {
            guard let bottomSection = bottomSectionViewController else { return }
            add(bottomSection)
            addTopShadow(to: bottomSection)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateScrollViewInsetsForBottomSection()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if parent == nil {
            onDismissed?()
            bottomSheet = nil
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            if self.traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle {
                guard let bottomSection = bottomSectionViewController else { return }
                addTopShadow(to: bottomSection)
            }
        }
    }
}

// MARK: - Bottom Section
private extension BPKFloatingPanelController {

    private struct ShadowConstants {
        static let radius: CGFloat = 3.0
        static let opacity: Float = 3.0
        static let offset: CGSize = .init(width: 0, height: -4)
    }

    func add(_ bottomSection: UIViewController) {
        guard let content = contentViewController else { return }

        #if swift(>=4.2)
        addChild(bottomSection)
        #else
        addChildViewController(bottomSection)
        #endif

        bottomSection.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSection.view)

        let outsideSafeAreaView = addOutsideSafeAreaView(to: bottomSection)

        let bottomContainerConstraint = bottomSection.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        bottomContainerConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            bottomSection.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSection.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainerConstraint,

            outsideSafeAreaView.topAnchor.constraint(
                greaterThanOrEqualTo: content.view.topAnchor,
                constant: 0
            )
        ])
    }

    func addOutsideSafeAreaView(to bottomSection: UIViewController) -> UIView {
        let invisibleOutsideSafeAreaView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            self.view.addSubview(view)
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                view.topAnchor.constraint(equalTo: safeAreaBottomAnchor),
                view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
            return view
        }()

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        bottomSection.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: bottomSection.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: bottomSection.view.trailingAnchor),
            view.topAnchor.constraint(greaterThanOrEqualTo: bottomSection.view.topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomSection.view.bottomAnchor),
            view.heightAnchor.constraint(equalTo: invisibleOutsideSafeAreaView.heightAnchor)
        ])
        return view
    }

    func addTopShadow(to bottomSection: UIViewController) {
        bottomSection.view.layer.shadowColor = bottomSection.view.backgroundColor?.cgColor
        bottomSection.view.layer.shadowRadius = ShadowConstants.radius
        bottomSection.view.layer.shadowOpacity = ShadowConstants.opacity
        bottomSection.view.layer.shadowOffset = ShadowConstants.offset
        bottomSection.view.layer.masksToBounds = false
    }

    func updateScrollViewInsetsForBottomSection() {
        guard let scrollView = trackingScrollView, let bottomSection = bottomSectionViewController else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: bottomSection.view.frame.size.height, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
}

private extension BPKFloatingPanelController {
    var safeAreaBottomAnchor: NSLayoutYAxisAnchor {
        return view.safeAreaLayoutGuide.bottomAnchor
    }
}
