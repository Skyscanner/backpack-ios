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

import Foundation

public struct FloatingNotificationViewModel {
    let parentView: UIView
    let title: String
    let hideAfter: TimeInterval
    let action: FloatingNotificationAction?
    let iconName: BPKIconName?
    let didDismiss: (() -> Void)?
    
    public init(
        parentView: UIView,
        title: String,
        hideAfter: TimeInterval,
        action: FloatingNotificationAction? = nil,
        iconName: BPKIconName? = nil,
        didDismiss: (() -> Void)? = nil
    ) {
        self.parentView = parentView
        self.title = title
        self.hideAfter = hideAfter
        self.action = action
        self.iconName = iconName
        self.didDismiss = didDismiss
    }
    
    public static func titleOnly(
        parentView: UIView,
        title: String,
        hideAfter: TimeInterval = 4.0,
        didDismiss: (() -> Void)? = nil
    ) -> FloatingNotificationViewModel {
        FloatingNotificationViewModel(
            parentView: parentView,
            title: title,
            hideAfter: hideAfter,
            didDismiss: didDismiss
        )
    }
    
    public static func titleWithAction(
        parentView: UIView,
        title: String,
        hideAfter: TimeInterval = 4.0,
        action: FloatingNotificationAction,
        didDismiss: (() -> Void)? = nil
    ) -> FloatingNotificationViewModel {
        FloatingNotificationViewModel(
            parentView: parentView,
            title: title,
            hideAfter: hideAfter,
            action: action,
            didDismiss: didDismiss
        )
    }
    
    public static func titleWithIcon(
        parentView: UIView,
        title: String,
        hideAfter: TimeInterval = 4.0,
        iconName: BPKIconName,
        didDismiss: (() -> Void)? = nil
    ) -> FloatingNotificationViewModel {
        FloatingNotificationViewModel(
            parentView: parentView,
            title: title,
            hideAfter: hideAfter,
            iconName: iconName,
            didDismiss: didDismiss
        )
    }
    
    public static func titleWithIconAndAction(
        parentView: UIView,
        title: String,
        hideAfter: TimeInterval = 4.0,
        iconName: BPKIconName,
        action: FloatingNotificationAction,
        didDismiss: (() -> Void)? = nil
    ) -> FloatingNotificationViewModel {
        FloatingNotificationViewModel(
            parentView: parentView,
            title: title,
            hideAfter: hideAfter,
            action: action,
            iconName: iconName,
            didDismiss: didDismiss
        )
    }
    
    public struct FloatingNotificationAction {
        let title: String
        let action: (() -> Void)
        
        public static func action(title: String, action: @escaping (() -> Void)) -> FloatingNotificationAction {
            FloatingNotificationAction(title: title, action: action)
        }
    }
}
