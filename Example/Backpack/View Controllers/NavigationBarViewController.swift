//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2019 Skyscanner Ltd. All rights reserved.
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
    private static let CellIdentifier = "CellIdentifier"

    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.title = "Explore"

        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: NavigationBarViewController.CellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self

        navigationBar.setUp(for: tableView)
        #if swift(>=4.2)
            view.bringSubviewToFront(navigationBar)
        #else
            view.bringSubview(toFront: navigationBar)
        #endif
    }

    @available(iOS 11.0, *)
    override func viewLayoutMarginsDidChange() {
        super.viewLayoutMarginsDidChange()
        navigationBar.largeTitleLayoutMargins = tableView.layoutMargins
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
}
