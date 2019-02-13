/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2019 Skyscanner Ltd
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

@objcMembers
public class StorageHelpers: NSObject {
    static var SETTINGSFILENAME = "settings.json"

    @objc static func writeSettingsToFile(settings: [String: String]) {
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString]? {
            let dir = dirs[0] //documents directory
            let path = dir.strings(byAppendingPaths: [SETTINGSFILENAME])[0]

            do {
                let data = try JSONSerialization.data(withJSONObject: settings, options: .prettyPrinted)
                if let text = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    try text.write(toFile: path, atomically: false, encoding: String.Encoding.utf8.rawValue)
                }
            } catch {
                print("Unexpected error: \(error).")
            }
        }
    }

    @objc static func readSettingsFromFile() -> [String: String] {
        if let dirs: [NSString] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true) as [NSString]? {
            let dir = dirs[0] //documents directory
            let path = dir.strings(byAppendingPaths: [SETTINGSFILENAME])[0]

            do {
                let text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                if let data = text.data(using: String.Encoding.utf8) {

                    if let dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: String] {

                        return dictionary

                    }
                }
            } catch {

                print("Unexpected error: \(error).")
            }
            return [String: String]()
        }
    }
}
