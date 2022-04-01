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

class BPKNavigationViewController: UITableViewController {
    private let cellIdentifier = "BPKNavigationViewControllerTableViewCell"

    var appStructure = sectionify(items: NavigationData.appStructure)

    public init(structure: [Item]) {
        super.init(style: .grouped)

        appStructure = sectionify(items: structure)
    }

    convenience init() {
        self.init(structure: NavigationData.appStructure)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        appStructure.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        appStructure[section].name
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        appStructure[section].rows.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = appStructure[indexPath.section].rows[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = appStructure[indexPath.section].rows[indexPath.row].value
        let resultingVC: UIViewController?

        switch item.value {
        case .story(let presentable):
            resultingVC = presentable.makeViewController()
        case .group(let items):
            resultingVC = BPKNavigationViewController(structure: items)
        }

        guard let viewController = resultingVC else {
            return
        }

        viewController.title = item.name
        show(viewController, sender: self)
    }
}
