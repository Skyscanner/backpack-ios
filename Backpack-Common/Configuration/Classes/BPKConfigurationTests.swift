//
//  BPKConfigurationTests.swift
//  Pods
//
//  Created by Kynan Song on 08/09/2025.
//

import XCTest
@testable import Backpack_Common

class BPKConfigurationTest: XCTestCase {
    
    func testConfigurationChipsIsFalseConfigIsNil() {
        
        // Given
        do {
            try BpkConfiguration.shared.set(chipConfig: false)
        } catch {
            XCTFail("Failed to set chip config")
        }
        
        // When
        let chipsConfig = BpkConfiguration.shared.chipConfig
        // Then
        XCTAssertNil(chipsConfig)
    }
    
    func testConfigurationChipsIsTrueConfigNotNil() {
        
        // Given
        BpkConfiguration.reset()
        
        do {
            try BpkConfiguration.shared.set(chipConfig: true)
        } catch {
            XCTFail("Failed to set chip config")
        }
        
        // When
        let chipsConfig = BpkConfiguration.shared.chipConfig
        // Then
        XCTAssertNotNil(chipsConfig)
    }
}
