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

    public init(structure: NavigationData.AppStructure) {
        super.init(style: .grouped)

        self.appStructure = structure
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.appStructure = NavigationData.appStructure
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        self.tableView.setStyle = UITableView.Style.insetGrouped

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
        return appStructure.sections.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // We won't show the heading if there is only one section
        if appStructure.sections.count > 1 {
            return appStructure.sections[section].name
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appStructure.sections[section].items?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: .zero)
        let item = appStructure.sections[indexPath.section].items?[indexPath.row]
        let name = item?.name
        cell.textLabel?.text = name

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = appStructure.sections[indexPath.section].items?[indexPath.row]
        let resultingVC = (item?.result.makeViewController())
        if resultingVC != nil {
            resultingVC!.title = item?.name
            self.show(resultingVC!, sender: self)
//            navigationController?.pushViewController(resultingVC!, animated: true)
        }
    }
}
