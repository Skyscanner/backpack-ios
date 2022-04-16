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

import SwiftUI

struct PresentableCellDataSource: CellDataSource {
    var title: String
    private let presentable: () -> Presentable
    private let enrich: ((UIViewController) -> Void)?
    private let showPresentable: (Presentable) -> Void
    
    private init(
        title: String,
        presentable: @escaping () -> Presentable,
        enrich: ((UIViewController) -> Void)?,
        showPresentable: @escaping (Presentable) -> Void
    ) {
        self.title = title
        self.presentable = presentable
        self.enrich = enrich
        self.showPresentable = showPresentable
    }
    
    private func decoratePresentable() -> Presentable {
        guard let enrich = enrich else {
            return presentable()
        }
        return presentable().enrich(enrich)
    }
    
    func onSelected() {
        showPresentable(decoratePresentable())
    }
}

extension PresentableCellDataSource {
    struct Storyboard {
        fileprivate let name: String
        fileprivate let identifier: String
        
        static func named(_ name: String, on identifier: String) -> Storyboard {
            Storyboard(name: name, identifier: identifier)
        }
    }
    
    init(
        title: String,
        storyboard: Storyboard,
        showPresentable: @escaping (Presentable) -> Void
    ) {
        self.title = title
        self.presentable = { loadStoryboard(name: storyboard.name, identifier: storyboard.identifier) }
        self.showPresentable = showPresentable
        enrich = nil
    }
    
    static func enrichable<Screen: UIViewController>(
        title: String,
        storyboard: Storyboard,
        enrich: @escaping (Screen) -> Void,
        showPresentable: @escaping (Presentable) -> Void
    ) -> PresentableCellDataSource {
        func handle(_ screen: UIViewController) {
            guard let screen = screen as? Screen else { return }
            enrich(screen)
        }
        return PresentableCellDataSource(
            title: title,
            presentable: { loadStoryboard(name: storyboard.name, identifier: storyboard.identifier) },
            enrich: handle(_:),
            showPresentable: showPresentable
        )
    }
}

extension PresentableCellDataSource {
    static func customEnrichable<Screen: UIViewController>(
        title: String,
        customController: @escaping () -> UIViewController,
        enrich: @escaping (Screen) -> Void,
        showPresentable: @escaping (Presentable) -> Void
    ) -> PresentableCellDataSource {
        func handle(_ screen: UIViewController) {
            guard let screen = screen as? Screen else { return }
            enrich(screen)
        }
        return PresentableCellDataSource(
            title: title,
            presentable: { CustomPresentable(generateViewController: customController) },
            enrich: handle(_:),
            showPresentable: showPresentable
        )
    }
    
    static func custom(
        title: String,
        customController: @escaping () -> UIViewController,
        showPresentable: @escaping (Presentable) -> Void
    ) -> PresentableCellDataSource {
        return PresentableCellDataSource(
            title: title,
            presentable: { CustomPresentable(generateViewController: customController) },
            enrich: nil,
            showPresentable: showPresentable
        )
    }
    
    static func swiftUI<Content: View>(
        title: String,
        view: @escaping () -> Content,
        showPresentable: @escaping (Presentable) -> Void
    ) -> PresentableCellDataSource {
        return PresentableCellDataSource(
            title: title,
            presentable: { SwitUIPresentable(generateView: view) },
            enrich: nil,
            showPresentable: showPresentable
        )
    }
}
