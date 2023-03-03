//
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

class NavigationBarViewController: UIViewController {
    var showBackbutton: Bool = true
    var showRightButton: Bool = true
    var collapsed: Bool = false
    var interactive: Bool = false
    
    private static let CellIdentifier = "CellIdentifier"

    @IBOutlet weak var navigationButton: UIButton!
    @IBOutlet weak var navigationBar: BPKNavigationBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.isHidden = true
        
        if collapsed {
            tableView.scrollToRow(at: IndexPath(item: 10, section: 0), at: .top, animated: false)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "Title"

        navigationButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        
        if showBackbutton {
            // Left button setup
            navigationBar.leftButton.isHidden = false
            navigationBar.leftButton.setImage(BPKIcon.makeLargeTemplateIcon(name: .chevronLeft))
            navigationBar.leftButton.contentColor = BPKColor.textPrimaryColor
            navigationBar.leftButton.accessibilityLabel = "Back"
            navigationBar.leftButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
        }
        
        if showRightButton {
            // Right button setup
            navigationBar.rightButton.isHidden = false
            navigationBar.rightButton.setImage(BPKIcon.makeLargeTemplateIcon(name: .settings))
            navigationBar.rightButton.contentColor = BPKColor.textPrimaryColor
            navigationBar.rightButton.addTarget(self, action: #selector(rightButtonPressed), for: .touchUpInside)
        }

        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: NavigationBarViewController.CellIdentifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = !interactive

        navigationBar.setUp(for: tableView)
        #if swift(>=4.2)
            view.bringSubviewToFront(navigationBar)
        #else
            view.bringSubview(toFront: navigationBar)
        #endif
    }

    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        navigationBar.largeTitleLayoutMargins = tableView.layoutMargins
    }

    @objc
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }

    @objc
    func rightButtonPressed() {
        print("Right button pressed")
    }
}

extension NavigationBarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = NavigationBarViewController.CellIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId)  else {
            assertionFailure("Expected to find cell with identifier \(cellId)")
            return UITableViewCell()
        }

        cell.textLabel?.text = "Hello \(indexPath.row)"

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 250
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension NavigationBarViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationBar.update(with: scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        navigationBar.makeTitleVisible(with: scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            navigationBar.makeTitleVisible(with: scrollView)
        }
    }
}
