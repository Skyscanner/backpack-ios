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
import Backpack
import SnapshotTesting

class BPKNavigationBarSnapshotTest: XCTestCase {

    var sut: BPKNavigationBar!
    var tableView: UITableView!
    var containerView: UIViewController!
    
    let cellIdentifier = "TestCell"
    
    let darkTrait = UITraitCollection(userInterfaceStyle: .dark)
    let lightTrait = UITraitCollection(userInterfaceStyle: .light)
    let rtlTrait = UITraitCollection(layoutDirection: .rightToLeft)

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
        
        sut = BPKNavigationBar()
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        containerView = UIViewController()
        
        setupView()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        tableView = nil
        containerView = nil
        
        try? super.tearDownWithError()
    }
    
    func testNavBarPosition() {
        // Then
        assertSnapshot(matching: containerView, as: .image(traits: lightTrait))
        assertSnapshot(matching: containerView, as: .image(traits: darkTrait))
        assertSnapshot(matching: containerView, as: .image(traits: rtlTrait))
    }
    
    func testNavBarCollapsed() {
        // Given
        let indexPath = IndexPath(item: 249, section: 0)
        
        // When
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        
        // Then
        assertSnapshot(matching: containerView, as: .image(traits: lightTrait))
        assertSnapshot(matching: containerView, as: .image(traits: darkTrait))
        assertSnapshot(matching: containerView, as: .image(traits: rtlTrait))
    }
    
    func testNavBarExpandedWithButtons() {
        // When
        sut.leftButton.title = "Back"
        sut.leftButton.isHidden = false
        sut.rightButton.title = "Done"
        sut.rightButton.isHidden = false
        
        // Then
        assertSnapshot(matching: containerView, as: .image(traits: lightTrait))
        assertSnapshot(matching: containerView, as: .image(traits: darkTrait))
        assertSnapshot(matching: containerView, as: .image(traits: rtlTrait))
    }
    
    func testNavBarCollapseddWithButtons() {
        // Given
        let indexPath = IndexPath(item: 249, section: 0)
        sut.leftButton.title = "Back"
        sut.leftButton.isHidden = false
        sut.rightButton.title = "Done"
        sut.rightButton.isHidden = false
        
        // When
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
        
        // Then
        assertSnapshot(matching: containerView, as: .image(traits: lightTrait))
        assertSnapshot(matching: containerView, as: .image(traits: darkTrait))
        assertSnapshot(matching: containerView, as: .image(traits: rtlTrait))
    }
    
    func testNavBarLargeTitleAlignment() {
        // Given
        sut.largeTitleTextAlignment = .right
        
        // Then
        assertSnapshot(matching: containerView, as: .image(traits: lightTrait))
        assertSnapshot(matching: containerView, as: .image(traits: darkTrait))
        assertSnapshot(matching: containerView, as: .image(traits: rtlTrait))
    }
    
    // MARK: Helpers
    private func setupView() {
        [tableView, sut].forEach {
            $0!.translatesAutoresizingMaskIntoConstraints = false
            containerView.view.addSubview($0!)
        }
        
        // The sut is set with a topAnchor, to simulate the safearea spacing on notched devices.
        NSLayoutConstraint.activate([
            sut.leadingAnchor.constraint(equalTo: containerView.view.leadingAnchor),
            sut.trailingAnchor.constraint(equalTo: containerView.view.trailingAnchor),
            sut.topAnchor.constraint(equalTo: containerView.view.topAnchor, constant: BPKSpacingLg),
            
            tableView.leadingAnchor.constraint(equalTo: containerView.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: sut.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.view.bottomAnchor)
        ])
        
        containerView.view.backgroundColor = BPKColor.canvasColor
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        sut.title = "Explore"
        sut.setUp(for: tableView)
        containerView.view.bringSubviewToFront(sut)
        
        tableView.reloadData()
    }
}

extension BPKNavigationBarSnapshotTest: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = "Hello"
        
        return cell
    }
}

extension BPKNavigationBarSnapshotTest: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        sut.update(with: scrollView)
    }
}
