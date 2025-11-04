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

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI
@testable import Backpack_Common

final class BPKButtonConfigurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        let config = BpkConfiguration.shared
        do {
            try config.set(buttonConfig: true)
        } catch {
            XCTFail("Failed to set chip config")
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        BpkConfiguration.shared.reset()
    }
    
    func test_primaryButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Primary", size: .large) {}
                    .buttonStyle(.primary)
                    .padding()
                
                BPKButton("Primary") {}
                    .buttonStyle(.primary)
                    .padding()
                
            }.padding()
        )
    }
    
    func test_primaryOnLightButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Primary on light", size: .large) {}
                    .buttonStyle(.primaryOnLight)
                    .padding()
                
                BPKButton("Primary on light") {}
                    .buttonStyle(.primaryOnLight)
                    .padding()
                
            }.padding()
        )
    }
    
    func test_primaryOnDarkButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Primary on dark", size: .large) {}
                    .buttonStyle(.primaryOnDark)
                    .padding()
                
                BPKButton("Primary on dark") {}
                    .buttonStyle(.primaryOnDark)
                    .padding()
                
            }.padding()
        )
    }
    
    func test_secondaryButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Secondary", size: .large) {}
                    .buttonStyle(.secondary)
                    .padding()
                
                BPKButton("Secondary") {}
                    .buttonStyle(.secondary)
                    .padding()
                
            }.padding()
        )
    }
    
    func test_secondaryOnDarkButton_configuration() {
        assertSnapshot(
            ZStack {
                HStack(spacing: 2) {
                    BPKButton("Secondary", size: .large) {}
                        .buttonStyle(.secondaryOnDark)
                        .padding()
                    
                    BPKButton("Secondary") {}
                        .buttonStyle(.secondaryOnDark)
                        .padding()
                    
                }
            }
            .padding()
            .background(.black)

        )
    }
    
    func test_featuredButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Featured", size: .large) {}
                    .buttonStyle(.featured)
                    .padding()
                
                BPKButton("Featured") {}
                    .buttonStyle(.featured)
                    .padding()
                
            }.padding()
        )
    }
    
    func test_destructiveButton_configuration() {
        assertSnapshot(
            HStack(spacing: 2) {
                BPKButton("Destructive", size: .large) {}
                    .buttonStyle(.destructive)
                    .padding()
                
                BPKButton("Destructive") {}
                    .buttonStyle(.destructive)
                    .padding()
                
            }.padding()
        )
    }
}
