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

struct Components {
    struct Group {
        let title: String
        let cells: [Cell]
    }
    
    struct Cell {
        let title: String
        let onSelection: () -> Void
    }
    
    struct Tab {
        let title: String
        let viewController: () -> UIViewController
        let image: UIImage?
    }
}

protocol CellDataSource {
    var title: String { get }
    func onSelected()
}

extension CellDataSource {
    var cell: Components.Cell {
        Components.Cell(title: title, onSelection: onSelected)
    }
}
