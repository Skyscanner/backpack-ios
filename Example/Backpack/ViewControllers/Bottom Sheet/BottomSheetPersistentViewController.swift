//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2021 Skyscanner Ltd
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

import Foundation
import Backpack
import MapKit

final class BottomSheetPersistentViewController: UIViewController {
    var bottomSheet: BPKBottomSheet?
    
    private let closeButton: BPKButton = {
        let closeButton = BPKButton(size: .default, style: .secondary)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(BPKIcon.makeLargeTemplateIcon(name: .close))
        closeButton.secondaryBackgroundColor = BPKColor.dynamicColor(
            withLightVariant: BPKColor.white,
            darkVariant: BPKColor.blackTint06
        )
        closeButton.secondaryContentColor = BPKColor.dynamicColor(
            withLightVariant: BPKColor.skyGray,
            darkVariant: BPKColor.blackTint01
        )
        closeButton.secondaryBorderColor = BPKColor.clear
        return closeButton
    }()

    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.translatesAutoresizingMaskIntoConstraints = false

        return mapView
    }()

    override func loadView() {
        super.loadView()

        view.addSubview(mapView)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            closeButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            closeButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: BPKSpacingSm)
        ])
        
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }
    
    // swiftlint:disable:next attributes
    @objc func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
        let viewController =  PersistentBottomListViewController.make()!

        bottomSheet = BPKBottomSheet(
            contentViewController: viewController,
            scrollViewToTrack: viewController.tableView,
            bottomSectionViewController: nil,
            presentationStyle: .persistent
        )
        bottomSheet?.addPanel(toParent: self)
        bottomSheet?.delegate = self
    }
}

extension BottomSheetPersistentViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        bottomSheet?.move(to: .tip)
    }
}

extension BottomSheetPersistentViewController: BPKBottomSheetDelegate {
    func bottomSheetDidChangePosition(_ position: BPKFloatingPanelPosition) {
        let defaultInsets = BottomSheetInsets()
        switch position {
        case .half:
            mapView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: defaultInsets.half ?? 0, right: 0)
        case .tip:
            mapView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: defaultInsets.tip ?? 0, right: 0)
        default:
            break
        }
    }
}

final class PersistentBottomListViewController: UITableViewController, StoryboardInstantiable {
    static var storyboardType: Storyboard { return .bottomSheet }
}
