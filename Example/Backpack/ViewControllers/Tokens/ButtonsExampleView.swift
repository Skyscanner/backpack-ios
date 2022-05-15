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

struct ButtonsExampleView: View {
    @State var times = 0
    @State var enabled = true
    @State var loading = false
    @State var title: String = "Click Me"
    @State var trailingIcon = true
    @State var buttonType: BPKButton.Style = .primary
    
    var body: some View {
        VStack {
            Toggle("Enabled", isOn: $enabled)
            Toggle("Loading", isOn: $loading)
            Toggle("Icon Position", isOn: $trailingIcon)
            HStack {
                Text("Change Title")
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
            }
            Text("Tapped \(times) times")
            Spacer()
            HStack {
                Spacer()
                BPKButton(
                    title,
                    icon: BPKButton.Icon(icon: .plus, position: trailingIcon ? .trailing : .leading),
                    loading: $loading,
                    enabled: $enabled,
                    size: .default
                ) { times += 1 }
                .buttonStyle(buttonType)
                Spacer()
                BPKButton(
                    title,
                    icon: BPKButton.Icon(icon: .plus, position: trailingIcon ? .trailing : .leading),
                    loading: $loading,
                    enabled: $enabled,
                    size: .large
                ) { times += 1 }
                .buttonStyle(buttonType)
                Spacer()
            }
            .padding()
            .background(buttonType == .primaryOnDark || buttonType == .secondaryOnDark || buttonType == .linkOnDark ? .black : .backgroundColor)
            Spacer()
            Picker("Style", selection: $buttonType) {
                Text("Primary").tag(BPKButton.Style.primary)
                Text("Primary On Light").tag(BPKButton.Style.primaryOnLight)
                Text("Primary On Dark").tag(BPKButton.Style.primaryOnDark)
                Text("Destructive").tag(BPKButton.Style.destructive)
                Text("Featured").tag(BPKButton.Style.featured)
                Text("Secondary").tag(BPKButton.Style.secondary)
                Text("Secondry On Dark").tag(BPKButton.Style.secondaryOnDark)
                Text("Link").tag(BPKButton.Style.link)
                Text("Link On Dark").tag(BPKButton.Style.linkOnDark)
            }
            .pickerStyle(.inline)
        }
        .padding()
    }
}
struct ButtonsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsExampleView()
    }
}
