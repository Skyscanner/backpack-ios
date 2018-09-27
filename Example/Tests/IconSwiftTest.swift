//
//  IconSwiftTest.swift
//  Backpack Native
//
//  Created by Hugo Tunius on 27/09/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit
import XCTest
import Backpack

class IconSwiftTest: XCTestCase {

    func testCreateWithEnum() {
        let icon = Backpack.Icon.makeIcon(name: .flag, color: Backpack.Color.blue500, size: .large)

        XCTAssertNotNil(icon)
    }
}
