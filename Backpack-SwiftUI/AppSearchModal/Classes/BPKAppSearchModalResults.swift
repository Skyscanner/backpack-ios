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

public enum BPKAppSearchModalResults: Equatable {
    case loading(BPKAppSearchModalLoading)
    case content(BPKAppSearchModalContent)
    case error(BPKAppSearchModalError)
}

public struct BPKAppSearchModalContent: Equatable {
    let sections: [Section]
    let shortcuts: [Shortcut]?
    
    public init(sections: [Section], shortcuts: [Shortcut]?) {
        self.sections = sections
        self.shortcuts = shortcuts
    }
    
    public struct Shortcut {
        let text: String
        let icon: BPKIcon
        let onShortcutSelected: () -> Void
        
        public init(text: String, icon: BPKIcon, onShortcutSelected: @escaping () -> Void) {
            self.text = text
            self.icon = icon
            self.onShortcutSelected = onShortcutSelected
        }
    }
    
    public struct Section: Hashable {
        let heading: SectionHeading?
        let items: [Item]
        
        public init(heading: SectionHeading?, items: [Item]) {
            self.heading = heading
            self.items = items
        }
    }
    
    public struct SectionHeading {
        let title: String
        let action: BPKAppSearchModalAction?
        
        public init(title: String, action: BPKAppSearchModalAction?) {
            self.title = title
            self.action = action
        }
    }
    
    public struct Item {
        let title: String
        let subtitle: String?
        let tertiaryLabel: String?
        let icon: BPKIcon
        let onItemSelected: () -> Void
        
        public init(
            title: String,
            subtitle: String?,
            tertiaryLabel: String? = nil,
            icon: BPKIcon,
            onItemSelected: @escaping () -> Void
        ) {
            self.title = title
            self.subtitle = subtitle
            self.tertiaryLabel = tertiaryLabel
            self.icon = icon
            self.onItemSelected = onItemSelected
        }
    }
}

public struct BPKAppSearchModalLoading: Equatable {
    let accessibilityLabel: String
    
    public init(accessibilityLabel: String) {
        self.accessibilityLabel = accessibilityLabel
    }
}

public struct BPKAppSearchModalError {
    let title: String
    let description: String
    let action: BPKAppSearchModalAction
    let image: Image
    
    public init(title: String, description: String, action: BPKAppSearchModalAction, image: Image) {
        self.title = title
        self.description = description
        self.action = action
        self.image = image
    }
}

public struct BPKAppSearchModalAction {
    let text: String
    let onActionSelected: () -> Void
    
    public init(text: String, onActionSelected: @escaping () -> Void) {
        self.text = text
        self.onActionSelected = onActionSelected
    }
}

extension BPKAppSearchModalContent.Shortcut: Equatable {
    public static func == (lhs: BPKAppSearchModalContent.Shortcut, rhs: BPKAppSearchModalContent.Shortcut) -> Bool {
        return lhs.text == rhs.text && lhs.icon.name == rhs.icon.name
    }
}

extension BPKAppSearchModalError: Equatable {
    public static func == (lhs: BPKAppSearchModalError, rhs: BPKAppSearchModalError) -> Bool {
        return lhs.title == rhs.title && lhs.description == rhs.description && lhs.image == rhs.image
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
