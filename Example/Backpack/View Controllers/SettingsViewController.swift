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
import Backpack

class SettingsViewController: UITableViewController {
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var enableThemeSwitch: Switch!
    var showThemeList: Bool = false
    @IBOutlet var selectableCells: [BPKTableViewSelectableCell]!

    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.tintColor = Color.blue500
        closeButton.target = self
        closeButton.action = #selector(SettingsViewController.btnAction)

        let theme = Settings.sharedSettings.activeTheme
        updateUI(theme: theme)
    }

    @objc
    func btnAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func didToggleTheming(_ sender: UISwitch) {
        if sender.isOn {
            applyTheme(theme: .london)
        } else {
            applyTheme(theme: .none)
        }
    }

    func updateUI(theme: ThemeHelpers.ThemeName) {
        showThemeList = true

        for cell in selectableCells {
            cell.setApplied(applied: false)
        }

        switch theme {
        case .london:
            selectableCells[0].setApplied(applied: true)
        case .hongKong:
            selectableCells[1].setApplied(applied: true)
        case .doha:
            selectableCells[2].setApplied(applied: true)
        case .silver:
            selectableCells[3].setApplied(applied: true)
        case .none:
            showThemeList = false
        }

        enableThemeSwitch.isOn = showThemeList

        tableView.reloadData()
    }

    func applyTheme(theme: ThemeHelpers.ThemeName) {
        let themeDefinition = ThemeHelpers.themeDefinition(forTheme: theme)
        Settings.sharedSettings.activeTheme = theme

        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: Theme.didChangeNotification as String),
            object: themeDefinition
        )

        updateUI(theme: theme)
    }

    // MARK: Table View

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        applyTheme(theme: ThemeHelpers.ThemeName(rawValue: 1 + Int(indexPath.row))!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return showThemeList ? 2 : 1
    }
}
