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

import UIKit
import Backpack

class BPKRootListTableViewController: UITableViewController {
    @IBOutlet weak var settingsButton: UIBarButtonItem?
    var appStructure = NavigationData.appStructure

    public init(structure: [Item]) {
        super.init(style: .grouped)

        appStructure = structure
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        appStructure = NavigationData.appStructure
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if ThemeHelpers.isThemingSupported() && (settingsButton != nil) {
            let largeSettingsIcon = BPKIcon.makeLargeTemplateIcon(name: .settings)
            settingsButton!.image = largeSettingsIcon
            settingsButton!.accessibilityLabel = "Settings"
            settingsButton!.target = self
            settingsButton!.action = #selector(self.didTapSettingsButton)
        }

        // Apply data and create navigation
        tableView.delegate = self
    }

    @objc
    func didTapSettingsButton() {
        ExampleApp.showSettingsView()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return appStructure.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // We won't show the heading if there is only one section
        if appStructure.count > 1 {
            return appStructure[section].name
        }

        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = appStructure[section].result
        var sectionItems: [Item]?

        switch section {
        case .group(let items):
            sectionItems = items
        default:
            sectionItems = nil
        }

        return sectionItems?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        let section = appStructure[indexPath.section].result
        var sectionItems: [Item]?

        switch section {
        case .group(let items):
            sectionItems = items
        default:
            sectionItems = nil
        }

        let item: Item? = sectionItems?[indexPath.row]

        if item != nil {
            let name = item!.name
            cell.textLabel?.text = name
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = appStructure[indexPath.section].result
        var sectionItems: [Item]?

        switch section {
        case .group(let items):
            sectionItems = items
        default:
            sectionItems = nil
        }

        let item = sectionItems?[indexPath.row]
        let result = item?.result
        var resultingVC: UIViewController?

        switch result {
        case .story(let presentable):
            resultingVC = presentable.makeViewController()
        case .group(let items):
            resultingVC = BPKRootListTableViewController(structure: items)
        default:
            resultingVC = nil
        }

        if resultingVC != nil {
            resultingVC!.title = item?.name
            show(resultingVC!, sender: self)
        }
    }
}
