/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2023 Skyscanner Ltd
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *`
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import SwiftUI

public enum BPKAppSearchModalResults {
    case loading(BPKAppSearchModalLoading)
    case content(BPKAppSearchModalContent)
    case error(BPKAppSearchModalError)
}

public struct BPKAppSearchModalContent {
    public let sections: [Section]
    public let shortcuts: [Shortcut]?
    
    public init(sections: [Section], shortcuts: [Shortcut]?) {
        self.sections = sections
        self.shortcuts = shortcuts
    }
    
    public struct Shortcut {
        public let text: String
        public let icon: BPKIcon
        public let onShortcutSelected: () -> Void
        
        public init(text: String, icon: BPKIcon, onShortcutSelected: @escaping () -> Void) {
            self.text = text
            self.icon = icon
            self.onShortcutSelected = onShortcutSelected
        }
    }
    
    public struct Section: Hashable {
        public let items: [Item]
        
        public init(heading: SectionHeading?, items: [Item]) {
            self.heading = heading
            self.items = items
        }
    }
    
    public struct SectionHeading {
        public let title: String
        public let action: BPKAppSearchModalAction?
        
        public init(title: String, action: BPKAppSearchModalAction?) {
            self.title = title
            self.action = action
        }
    }
    
    public struct Item {
        public let title: String
        public let subtitle: String
        public let icon: BPKIcon
        public let onItemSelected: () -> Void
        
        public init(title: String, subtitle: String, icon: BPKIcon, onItemSelected: @escaping () -> Void) {
            self.title = title
            self.subtitle = subtitle
            self.icon = icon
            self.onItemSelected = onItemSelected
        }
    }
}

public struct BPKAppSearchModalLoading {
    public let accessibilityLabel: String
    
    public init(accessibilityLabel: String) {
        self.accessibilityLabel = accessibilityLabel
    }
}

public struct BPKAppSearchModalError {
    public let title: String
    public let description: String
    public let action: BPKAppSearchModalAction
    public let image: Image
    
    public init(title: String, description: String, action: BPKAppSearchModalAction, image: Image) {
        self.title = title
        self.description = description
        self.action = action
        self.image = image
    }
}

public struct BPKAppSearchModalAction {
    public let text: String
    public let onActionSelected: () -> Void
    
    public init(text: String, onActionSelected: @escaping () -> Void) {
        self.text = text
        self.onActionSelected = onActionSelected
    }
}

extension BPKAppSearchModalContent.SectionHeading: Hashable {
    public static func == (
        lhs: BPKAppSearchModalContent.SectionHeading,
        rhs: BPKAppSearchModalContent.SectionHeading
    ) -> Bool {
        return lhs.title == rhs.title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

extension BPKAppSearchModalContent.Item: Hashable {
    public static func == (
        lhs: BPKAppSearchModalContent.Item,
        rhs: BPKAppSearchModalContent.Item
    ) -> Bool {
        return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle && lhs.icon.name == rhs.icon.name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(icon.name)
    }
}
