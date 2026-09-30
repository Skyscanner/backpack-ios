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

/// The modal `BPKBottomSheet`, presented as a native sheet. UIKit sizes and places it for the window (full width on
/// a phone, a centred card on a wide window) and lays it out again when the window changes, for example when a
/// foldable folds or unfolds.
final class BPKSheetViewController: UIViewController {
    /// How the sheet's heights are worked out.
    enum Sizing {
        /// A single height that fits the content.
        case fitContent
        /// The half position (height above the bottom safe area) and the full position (inset from the top). A
        /// missing full inset means the system's large height.
        case positions(half: CGFloat?, full: CGFloat?)
    }

    let content: UIViewController
    let bottomSection: UIViewController?
    var onDismissed: (() -> Void)?
    var onPositionChanged: ((BPKFloatingPanelPosition) -> Void)?
    /// Keeps the owning `BPKBottomSheet` alive while the sheet is on screen, as callers often don't hold it.
    var owner: BPKBottomSheet?

    private let trackedScrollView: UIScrollView?
    private let sizing: Sizing

    init(
        content: UIViewController,
        trackedScrollView: UIScrollView?,
        bottomSection: UIViewController?,
        sizing: Sizing
    ) {
        self.content = content
        self.trackedScrollView = trackedScrollView
        self.bottomSection = bottomSection
        self.sizing = sizing
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
        configureSheet()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = BPKColor.surfaceElevatedColor
        embed(content)
        if let bottomSection {
            embedBottomSection(bottomSection)
        }
        if let trackedScrollView, trackedScrollView.isDescendant(of: content.view) {
            // The sheet grows from half to full when this scroll view is dragged at its top, as before.
            setContentScrollView(trackedScrollView, for: .bottom)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let bottomSection, let trackedScrollView else { return }
        let inset = bottomSection.view.frame.height
        trackedScrollView.contentInset.bottom = inset
        trackedScrollView.verticalScrollIndicatorInsets.bottom = inset
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        guard isBeingDismissed || presentingViewController == nil else { return }
        onDismissed?()
        owner = nil
    }

    /// Moves the sheet to a position. The hidden position dismisses it.
    func move(to position: BPKFloatingPanelPosition, animated: Bool) {
        guard position != .hidden else {
            dismiss(animated: animated)
            return
        }
        guard let sheet = sheetPresentationController, case .positions = sizing else { return }
        let identifier: UISheetPresentationController.Detent.Identifier = position == .full ? .bpkFull : .bpkHalf
        let change = { sheet.selectedDetentIdentifier = identifier }
        animated ? sheet.animateChanges(change) : change()
    }

    /// Recomputes the sheet's heights, for example after the content changed size.
    func updateSize() {
        guard let sheet = sheetPresentationController else { return }
        let change = { sheet.invalidateDetents() }
        isViewLoaded && view.window != nil ? sheet.animateChanges(change) : change()
    }
}

// MARK: - Sheet configuration

private extension BPKSheetViewController {
    func configureSheet() {
        guard let sheet = sheetPresentationController else { return }
        sheet.delegate = self
        sheet.prefersGrabberVisible = true
        sheet.preferredCornerRadius = BPKCornerRadiusLg
        sheet.prefersEdgeAttachedInCompactHeight = true
        sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        switch sizing {
        case .fitContent:
            sheet.detents = [.custom(identifier: .bpkFit) { [weak self] context in
                self?.fittingHeight(maximum: context.maximumDetentValue)
            }]
        case let .positions(half, full):
            let halfHeight = half ?? BottomSheetInsets.Constants.bottomSheetHeightInHalfPosition
            let fullDetent: UISheetPresentationController.Detent = full.map { inset in
                .custom(identifier: .bpkFull) { context in context.maximumDetentValue - inset }
            } ?? .custom(identifier: .bpkFull) { context in context.maximumDetentValue }
            sheet.detents = [
                .custom(identifier: .bpkHalf) { context in min(halfHeight, context.maximumDetentValue) },
                fullDetent
            ]
            sheet.selectedDetentIdentifier = .bpkHalf
        }
    }

    /// The content's height at the sheet's width, plus the bottom section, capped at the tallest the sheet can be.
    func fittingHeight(maximum: CGFloat) -> CGFloat {
        loadViewIfNeeded()
        let containerWidth = sheetPresentationController?.containerView?.bounds.width ?? 0
        let width = view.bounds.width > 0 ? view.bounds.width : containerWidth
        let target = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
        var height = content.view.systemLayoutSizeFitting(
            target,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
        height = max(height, content.preferredContentSize.height)
        if let bottomSection {
            height += bottomSection.view.systemLayoutSizeFitting(
                target,
                withHorizontalFittingPriority: .required,
                verticalFittingPriority: .fittingSizeLevel
            ).height
        }
        return min(height, maximum)
    }

    func embed(_ child: UIViewController) {
        addChild(child)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(child.view)
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        child.didMove(toParent: self)
    }

    /// Pins the bottom section to the sheet's bottom edge, so it stays visible at every position. Its own
    /// constraints keep its content inside the safe area; its background runs to the screen edge.
    func embedBottomSection(_ bottomSection: UIViewController) {
        addChild(bottomSection)
        bottomSection.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomSection.view)
        NSLayoutConstraint.activate([
            bottomSection.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSection.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSection.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        bottomSection.didMove(toParent: self)
        BottomSectionShadow.apply(to: bottomSection.view)
    }
}

// MARK: - UISheetPresentationControllerDelegate

extension BPKSheetViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(
        _ sheetPresentationController: UISheetPresentationController
    ) {
        onPositionChanged?(sheetPresentationController.selectedDetentIdentifier == .bpkHalf ? .half : .full)
    }
}

extension UISheetPresentationController.Detent.Identifier {
    static let bpkHalf = Self("backpack.bottomSheet.half")
    static let bpkFull = Self("backpack.bottomSheet.full")
    static let bpkFit = Self("backpack.bottomSheet.fit")
}

/// The top shadow that separates a bottom section from the content scrolling under it.
enum BottomSectionShadow {
    private static let radius: CGFloat = 3.0
    private static let opacity: Float = 3.0
    private static let offset = CGSize(width: 0, height: -4)

    static func apply(to view: UIView) {
        view.layer.shadowColor = view.backgroundColor?.cgColor
        view.layer.shadowRadius = radius
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }
}
