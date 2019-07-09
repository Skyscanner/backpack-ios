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
    @IBOutlet weak var enableRTLSwitch: Switch!
    var showThemeList: Bool = false
    var rtlEnabled: Bool = false
    var activeTheme: ThemeHelpers.ThemeName = .none
    @IBOutlet var selectableCells: [BPKTableViewSelectableCell]!

    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.tintColor = Color.blue500
        closeButton.target = self
        closeButton.action = #selector(SettingsViewController.btnAction)

        activeTheme = Settings.sharedSettings.activeTheme
        rtlEnabled = Settings.sharedSettings.rtlEnabled
        updateUI()
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

    @IBAction func didToggleRTL(_ sender: UISwitch) {
        applyRTL(rtlOn: sender.isOn)
    }

    func updateUI() {
        showThemeList = true

        for cell in selectableCells {
            cell.setApplied(applied: false)
        }

        switch activeTheme {
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
        enableRTLSwitch.isOn = rtlEnabled

        tableView.reloadData()
    }

    func applyTheme(theme: ThemeHelpers.ThemeName) {
        activeTheme = theme
        let themeDefinition = ThemeHelpers.themeDefinition(forTheme: activeTheme)
        Settings.sharedSettings.activeTheme = theme

        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: Theme.didChangeNotification as String),
            object: themeDefinition
        )

        updateUI()
    }

    func applyRTL(rtlOn: Bool) {
        rtlEnabled = rtlOn
        Settings.sharedSettings.rtlEnabled = rtlEnabled

        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: BPKRTLTestHelper.didChangeNotification as String),
            object: rtlEnabled
        )

        updateUI()
    }

    // MARK: Table View

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        applyTheme(theme: ThemeHelpers.ThemeName(rawValue: 1 + Int(indexPath.row))!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return showThemeList ? 3 : 2
    }
}
