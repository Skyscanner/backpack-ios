//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2022 Skyscanner Ltd. All rights reserved.
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
import Backpack_SwiftUI

struct NudgerExampleView: View {
    @State private var minimumValue = 1
    @State private var value = 5
    @State private var maximumValue = 10
    
    var body: some View {
        VStack {
            BPKNudger(value: $minimumValue, min: 1, max: 10)
            BPKNudger(value: $value, min: 1, max: 10)
            BPKNudger(value: $maximumValue, min: 1, max: 10)
        }
        .padding()
    }
}

struct NudgerLabelledExampleView: View {
    @State private var value = 1

    var body: some View {
        BPKNudger(
            title: "Travellers",
            subtitle: "Aged 16 and older",
            icon: .adult,
            value: $value,
            min: 1,
            max: 10
        )
        .accessibilityPrefix("passengers")
        .padding()
    }
}

struct NudgerDisabledExampleView: View {
    @State private var value = 5
    @State private var enabled = false

    var body: some View {
        VStack {
            BPKSwitch(isOn: $enabled, text: "Nudger enabled")
            BPKNudger(value: $value, min: 1, max: 10, enabled: enabled)
        }
        .padding()
    }
}

struct NudgerExampleView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NudgerExampleView()
                .previewDisplayName("Default")
            NudgerLabelledExampleView()
                .previewDisplayName("Labelled")
            NudgerDisabledExampleView()
                .previewDisplayName("Disabled")
        }
    }
}

@MainActor
struct NudgerGroupsProvider {
    let showPresentable: (Presentable) -> Void

    private func presentable<Content: View>(
        _ title: String,
        view: Content
    ) -> CellDataSource {
        PresentableCellDataSource.custom(
            title: title,
            customController: { ContentUIHostingController(view) },
            showPresentable: showPresentable
        )
    }

    func swiftUIGroups() -> [Components.Group] {
        SingleGroupProvider(
            cellDataSources: [
                presentable("Default", view: NudgerExampleView()),
                presentable("Labelled", view: NudgerLabelledExampleView()),
                presentable("Disabled", view: NudgerDisabledExampleView())
            ]
        ).groups()
    }
}
