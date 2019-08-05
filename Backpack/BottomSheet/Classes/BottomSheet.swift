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
import FloatingPanel

@objcMembers
@objc(BPKBottomSheet)
public final class BottomSheet: NSObject {
    
    private struct Constants {
        static let bottomSheetHeightInHalfPosition: CGFloat = 386.0
        static let backdropAlpha: CGFloat = 0.3
    }
    
    private lazy var floatingPanelController: BackpackFloatingPanelController = {
        let panel = BackpackFloatingPanelController(delegate: self)
        panel.surfaceView.cornerRadius = 24.0
        panel.isRemovalInteractionEnabled = true
        
        // We do this to hold a strong reference to `BottomSheet` and force it
        // to exist as long as `floatingPanelController` exists.
        // Reference will be cleaned up by `floatingPanelController` when
        // it's dismissed, to avoid a reference cycle.
        panel.backpackBottomSheet = self
        
        return panel
    }()
    
    /// View controller that will be presented when calling
    /// `present(in: _, animated: _, completion: _)`.
    /// It can also be presented using UIKit's native presentation API.
    public var viewControllerToPresent: UIViewController {
        get {
            return floatingPanelController
        }
    }
    
    /// View controller contained in the bottom sheet.
    public var contentViewController: UIViewController? {
        get {
            return floatingPanelController.contentViewController
        }
    }
    
    /// Fixed bottom section. Can only be passed when initializing
    /// the bottom sheet.
    public var bottomSectionViewController: UIViewController? {
        get {
            return floatingPanelController.bottomSectionViewController
        }
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
    
    /// Instantiates a `BottomSheet`.
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
    public init(contentViewController: UIViewController, scrollViewToTrack: UIScrollView, bottomSectionViewController: UIViewController? = nil) {
        super.init()
        floatingPanelController.contentViewController = contentViewController
        floatingPanelController.track(scrollView: scrollViewToTrack)
        floatingPanelController.bottomSectionViewController = bottomSectionViewController
    }
    
    /// This presents the bottom sheet. It is just a wrapper of native API
    /// `UIViewController.present(_, animated: _, completion: _)`.
    ///
    /// - Parameters:
    ///   - viewController: The view controller that should present this bottom sheet.
    ///   - animated: Animated or not.
    ///   - completion: Completion closure called after presentation animation.
    public func present(in viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
}

extension BottomSheet: FloatingPanelControllerDelegate {
    public func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
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
                switch position{
                case .full, .half:
                    return Constants.backdropAlpha
                default:
                    return 0.0
                }
            }
        }
        
        return Layout()
    }
}
