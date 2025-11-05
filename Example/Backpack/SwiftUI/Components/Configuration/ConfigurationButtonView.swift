//
/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright © 2025 Skyscanner Ltd. All rights reserved.
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

import Backpack_SwiftUI
import SwiftUI

// swiftlint:disable closure_body_length
struct ConfigurationButtonView: View {
    @State var enabled = true
    @State var loading = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Radius - 100  Large Height - 56")
                Text("Default Height - 36")
                Text("Secondary Button colour change")
                Text("Font size 14pt")
                
                HStack {
                    BPKButton("Primary", loading: $loading, enabled: $enabled, size: .large) {}
                        .buttonStyle(.primary)
                    BPKButton("Primary", loading: $loading, enabled: $enabled) {}
                        .buttonStyle(.primary)
                }
                
                ZStack {
                    HStack {
                        BPKButton("Primary on Dark", loading: $loading, enabled: $enabled, size: .large) {}
                            .buttonStyle(.primaryOnDark)
                        BPKButton("Primary on Dark", loading: $loading, enabled: $enabled) {}
                            .buttonStyle(.primaryOnDark)
                    }
                }
                .padding()
                .background(.black)

                HStack {
                    BPKButton("Primary on Light", loading: $loading, enabled: $enabled, size: .large) {}
                        .buttonStyle(.primaryOnLight)
                    BPKButton("Primary on Light", loading: $loading, enabled: $enabled) {}
                        .buttonStyle(.primaryOnLight)
                }
                
                HStack {
                    BPKButton("Secondary", loading: $loading, enabled: $enabled, size: .large) {}
                        .buttonStyle(.secondary)
                    BPKButton("Secondary", loading: $loading, enabled: $enabled) {}
                        .buttonStyle(.secondary)
                }
                
                ZStack {
                    HStack {
                        BPKButton("Secondary on Dark", loading: $loading, enabled: $enabled, size: .large) {}
                            .buttonStyle(.secondaryOnDark)
                        BPKButton("Secondary on Dark", loading: $loading, enabled: $enabled) {}
                            .buttonStyle(.secondaryOnDark)
                    }
                }
                .padding()
                .background(.black)

                HStack {
                    BPKButton("Featured", loading: $loading, enabled: $enabled, size: .large) {}
                        .buttonStyle(.featured)
                    BPKButton("Featured", loading: $loading, enabled: $enabled) {}
                        .buttonStyle(.featured)
                }
                
                HStack {
                    BPKButton("Destructive", loading: $loading, enabled: $enabled, size: .large) {}
                        .buttonStyle(.destructive)
                    BPKButton("Destructive", loading: $loading, enabled: $enabled) {}
                        .buttonStyle(.destructive)
                }
                
                HStack {
                    Toggle("Enabled", isOn: $enabled)
                    Toggle("Loading", isOn: $loading)
                    Spacer()
                }

            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .onDisappear {
            BpkConfiguration.shared.reset()
        }
    }
}

#Preview {
    ConfigurationButtonView()
}
