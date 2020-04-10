/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2020 Skyscanner Ltd
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
import FloatingPanel

@objcMembers
@objc(BPKBottomSheet)
public final class BPKBottomSheet: NSObject {
    
    private enum Constants {
        static let bottomSheetHeightInHalfPosition: CGFloat = 386.0
        static let backdropAlpha: CGFloat = 0.3
        static let grabberHandleWidth: CGFloat = 60.0
    }

    /// View controller that will be presented when calling
    /// `present(in: _, animated: _, completion: _)`.
    /// It can also be presented using UIKit's native presentation API.
    public var viewControllerToPresent: UIViewController {
        return floatingPanelController
    }

    /// View controller contained in the bottom sheet.
    public var contentViewController: UIViewController? {
        return floatingPanelController.contentViewController
    }

    /// Fixed bottom section. Can only be passed when initializing
    /// the bottom sheet.
    public var bottomSectionViewController: UIViewController? {
        return floatingPanelController.bottomSectionViewController
    }

    /// This closure will be executed once the bottom sheet has been
    /// fully dismissed.
    public var onDismissed: (() -> Void)? {
        get {
            return floatingPanelController.onDismissed
        }
        set {
            floatingPanelController.onDismissed = newValue
        }
    }
    
    private lazy var floatingPanelController: BPKFloatingPanelController = {
        let panel = BPKFloatingPanelController(delegate: self)
        panel.surfaceView.backgroundColor = BPKColor.backgroundTertiaryColor
        panel.surfaceView.cornerRadius = BPKBorderRadiusLg
        panel.surfaceView.grabberTopPadding = BPKSpacingMd
        panel.surfaceView.grabberHandleHeight = BPKSpacingSm
        panel.surfaceView.grabberHandleWidth = Constants.grabberHandleWidth
        panel.surfaceView.grabberHandle.barColor = BPKColor.skyGrayTint06
        
        panel.isRemovalInteractionEnabled = true
        
        // We do this to hold a strong reference to `BPKBottomSheet` and force it
        // to exist as long as `floatingPanelController` exists.
        // Reference will be cleaned up by `floatingPanelController` when
        // it's dismissed, to avoid a reference cycle.
        panel.bottomSheet = self

        return panel
    }()
    
    private var scrollView: UIScrollView?
    
    /// Instantiates a `BPKBottomSheet` with a scrollable content. Default initial height is 386pt and can't be changed.
    /// Optionally, an always visible bottom section can be added.
    ///
    /// - Parameters:
    ///   - contentViewController: Content of the bottom sheet.
    ///   - scrollViewToTrack: The bottom sheet uses this scroll view's gesture recognizer
    ///     instead of creating a new one. This allows the scroll view to start offseting its
    ///     content only after the bottom sheet has reached its full screen position.
    ///   - bottomSectionViewController: Optional. A bottom section can be provided so that it is
    ///     always visible regardless of the bottom sheet position. Useful for providing actions
    ///     that should be accessible at all times. A top shadow is automatically added so that
    ///     it integrates better with the content of the bottom sheet.
    ///     Note: Safe Area should be taken into account in the bottom section's inner constraints.
    public init(contentViewController: UIViewController,
                scrollViewToTrack: UIScrollView,
                bottomSectionViewController: UIViewController? = nil) {
        super.init()
        
        self.scrollView = scrollViewToTrack
        
        floatingPanelController.contentViewController = contentViewController
        floatingPanelController.track(scrollView: scrollViewToTrack)
        floatingPanelController.bottomSectionViewController = bottomSectionViewController
    }
    
    /// Instantiates a `BPKBottomSheet` with a non-scrollable content. Height of the bottom sheet will be
    /// calculated based on the content.
    /// If the content height might not fit the screen, then `init(contentViewController: _, scrollViewToTrack: _)`
    /// should be used instead.
    /// - Parameter contentViewController: Content of the bottom sheet.
    public init(contentViewController: UIViewController) {
        super.init()
        floatingPanelController.contentViewController = contentViewController
    }

    /// This presents the bottom sheet. It is just a wrapper of native API
    /// `UIViewController.present(_, animated: _, completion: _)`.
    ///
    /// - Parameters:
    ///   - viewController: The view controller that should present this bottom sheet.
    ///   - animated: Animated or not.
    ///   - completion: Completion closure called after presentation animation.
    @objc(presentInViewController:animated:completion:)
    public func present(in viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        viewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    /// This method allows presenting a new bottom sheet on top of a previously existing one.
    /// The previous bottom sheet is automatically moved to the initial position, its scroll view content
    /// inset is reset, and the new bottom sheet won't add any more alpha to the backdrop view.
    /// - Parameters:
    ///   - bottomSheet: The new bottom sheet to present.
    ///   - animated: Animated or not.
    ///   - completion: Completion closure called after the presentation animation.
    @objc(presentBottomSheet:animated:completion:)
    public func present(_ bottomSheet: BPKBottomSheet, animated: Bool, completion: (() -> Void)? = nil) {
        if let scrollView = floatingPanelController.scrollView {
            scrollView.setContentOffset(.init(x: 0, y: -scrollView.adjustedContentInset.top), animated: animated)
        }
        
        // It's important to set `backgroundColor` to clear instead of setting alpha to 0,
        // in order for the view to keep receiving touch events
        bottomSheet.floatingPanelController.backdropView.backgroundColor = .clear
        
        floatingPanelController.move(to: .half, animated: true)
        bottomSheet.present(in: floatingPanelController, animated: animated, completion: completion)
    }
    
    /// Forces the bottom sheet layout to be updated.
    /// It can be useful, for example, when changing the inner constraints of the `contentViewController`
    /// and bottom sheet needs to be resized to fit the content.
    public func updateLayout() {
        floatingPanelController.updateLayout()
    }

}

extension BPKBottomSheet: FloatingPanelControllerDelegate {
    final class Layout: FloatingPanelLayout {
        var initialPosition: FloatingPanelPosition {
            return .half
        }

        var supportedPositions: Set<FloatingPanelPosition> {
            return [.full, .half]
        }

        func insetFor(position: FloatingPanelPosition) -> CGFloat? {
            switch position {
            case .half: return Constants.bottomSheetHeightInHalfPosition
            default: return nil
            }
        }

        func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
            switch position {
            case .full, .half:
                return Constants.backdropAlpha
            default:
                return 0.0
            }
        }
    }
    
    final class IntrinsicLayout: FloatingPanelIntrinsicLayout {
        func backdropAlphaFor(position: FloatingPanelPosition) -> CGFloat {
            return Constants.backdropAlpha
        }
    }

    public func floatingPanel(_ viewController: FloatingPanelController,
                              layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return scrollView == nil ? IntrinsicLayout() : Layout()
    }
}
