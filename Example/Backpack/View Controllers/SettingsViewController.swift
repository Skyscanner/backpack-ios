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
    var showThemeList: Bool?
    @IBOutlet var selectableCells: [UITableViewSelectableCell]!

    enum Theme: Int {
        case london = 0
        case hongKong = 1
        case doha = 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.tintColor = Color.blue500
        closeButton.target = self
        closeButton.action = #selector(SettingsViewController.btnAction)
        enableThemeSwitch.addTarget(self, action: #selector(SettingsViewController.themingToggled), for: .touchUpInside)

        let settings = StorageHelpers.readSettingsFromFile()

        switch settings["themeEnabled"] {
        case "London":
            applyTheme(theme: .london)
        case "Hong Kong":
            applyTheme(theme: .hongKong)
        case "Doha":
            applyTheme(theme: .doha)
        default:
            applyTheme(theme: nil)
        }
    }

    @objc func btnAction() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func themingToggled() {
        if enableThemeSwitch.isOn {
            applyTheme(theme: .london)
        } else {
            applyTheme(theme: nil)
        }
    }

    func applyTheme(theme: Theme?) {
        var themeToApply = "None"
        showThemeList = false
        enableThemeSwitch.isOn = false
        for cell in selectableCells {
            cell.setApplied(applied: false)
        }

        if theme != nil {
            showThemeList = true
            switch theme! {
            case .london:
                themeToApply = "London"
                selectableCells[0].setApplied(applied: true)
            case .hongKong:
                themeToApply = "Hong Kong"
                selectableCells[1].setApplied(applied: true)
            case .doha:
                themeToApply = "Doha"
                selectableCells[2].setApplied(applied: true)
            }
        }
        enableThemeSwitch.isOn = showThemeList ?? false
        ThemingHelpers.applyExampleTheme(themeName: themeToApply)
        StorageHelpers.writeSettingsToFile(settings: ["themeEnabled": themeToApply])
        tableView.reloadData()
    }

    // pragmamark tableView

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        applyTheme(theme: Theme(rawValue: indexPath.row)!)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return showThemeList! ? 2 : 1
    }

}
