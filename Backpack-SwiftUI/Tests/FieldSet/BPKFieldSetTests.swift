//
//  BPKFieldSetTests.swift
//  Backpack-Common-Unit-Tests
//
//  Created by Alaa Amin on 26/08/2024.
//

import XCTest
import SwiftUI
@testable import Backpack_SwiftUI

final class BPKFieldSetTests: XCTestCase {
    // swiftlint:disable large_tuple
    private var testsCases: [(label: String?, description: String?, name: String)] {
        [
            ("Label", "Description", "LabelAndDescription"),
            ("Label", nil, "LabelAndNoDescription"),
            (nil, "Description", "NoLabelAndDescription"),
            (nil, nil, "NoLabelAndNoDescription")
        ]
    }
    
    func test_defaultState() {
        testsCases.forEach { testCase in
            assertSnapshot(
                BPKFieldSet(label: testCase.label, description: testCase.description, content: {
                    BPKTextField(placeholder: "Enter text", .constant(""))
                })
                .frame(width: 300),
                testName: "test_defaultStateWith\(testCase.name)"
            )
        }
    }
    
    func test_errorState() {
        testsCases.forEach { testCase in
            assertSnapshot(
                BPKFieldSet(label: testCase.label, description: testCase.description, content: {
                    BPKTextField(placeholder: "Enter text", .constant(""))
                })
                .inputState(.error(message: "Error Message"))
                .frame(width: 300),
                testName: "test_errorStateWith\(testCase.name)"
            )
        }
    }
}
