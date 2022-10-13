/*
 * Backpack - Skyscanner's Design System
 *
 * Copyright 2018-2022 Skyscanner Ltd
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

class BPKMapAnnotationSnapshotTest: XCTestCase {
    
    private let reuseIdentifier = "Annotation"
    private let traitDarkMode = UITraitCollection(userInterfaceStyle: .dark)

    override func setUpWithError() throws {
        try? super.setUpWithError()
        isRecording = false
    }
    
    // MARK: State testing
    private func createAllStates(hasIcon: Bool) -> UIView {
        let stackView = createStackView()
        let parentView = UIView(frame: .zero)
        
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(stackView)
        
        let label = "Edinburgh"
        
        let allStateViews = [
            create(withLabel: label, alwaysShowCallout: false, previouslySelected: false, selected: false, enabled: true, icon: hasIcon),
            create(withLabel: label, alwaysShowCallout: false, previouslySelected: false, selected: true, enabled: true, icon: hasIcon),
            create(withLabel: label, alwaysShowCallout: true, previouslySelected: false, selected: false, enabled: true, icon: hasIcon),
            create(withLabel: label, alwaysShowCallout: true, previouslySelected: true, selected: false, enabled: true, icon: hasIcon),
            create(withLabel: label, alwaysShowCallout: true, previouslySelected: false, selected: true, enabled: true, icon: hasIcon),
            create(withLabel: label, alwaysShowCallout: true, previouslySelected: false, selected: false, enabled: false, icon: hasIcon)
        ]
        
        allStateViews.forEach(stackView.addArrangedSubview(_:))
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: parentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            parentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            parentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        return parentView
    }
    
    func testAllStates() {
        let exampleView = createAllStates(hasIcon: false)
        
        assertSnapshot(matching: exampleView, as: .image)
        assertSnapshot(matching: exampleView, as: .image(traits: traitDarkMode))
    }
    
    func testAllStatesWithIcon() {
        let exampleView = createAllStates(hasIcon: true)
        
        assertSnapshot(matching: exampleView, as: .image)
        assertSnapshot(matching: exampleView, as: .image(traits: traitDarkMode))
    }
    
    
    // MARK: Long titles
    private func createWithLongTitle(hasIcon: Bool) -> UIView {
        let view = create(
            withLabel: "Callout with a super super super long title that goes on and on and on",
            alwaysShowCallout: true,
            previouslySelected: false,
            selected: false,
            enabled: true,
            icon: hasIcon
        )
        
        return view
    }
    
    func testLongTitleCalloutViewWith() {
        let exampleView = createWithLongTitle(hasIcon: false)
        
        assertSnapshot(matching: exampleView, as: .image)
        assertSnapshot(matching: exampleView, as: .image(traits: traitDarkMode))
    }

    func testLongTitleCalloutViewWithIcon() {
        let exampleView = createWithLongTitle(hasIcon: true)
        
        assertSnapshot(matching: exampleView, as: .image)
        assertSnapshot(matching: exampleView, as: .image(traits: traitDarkMode))
    }
    
    // MARK: Util
    // swiftlint:disable:next function_parameter_count
    private func create(
        withLabel label: String,
        alwaysShowCallout: Bool,
        previouslySelected: Bool,
        selected: Bool,
        enabled: Bool,
        icon: Bool
    ) -> UIView {
        let annotation = BPKMapAnnotation()
        annotation.title = label
        annotation.alwaysShowCallout = alwaysShowCallout
        annotation.enabled = enabled
        
        if icon {
            annotation.iconName = .airports
        }
        
        let annotationView = BPKMapAnnotationView(
            annotation: annotation,
            reuseIdentifier: reuseIdentifier
        )
        
        annotationView.isSelected = previouslySelected
        annotationView.isSelected = selected
        
        let wrapper = UIView()
        wrapper.addSubview(annotationView)
        
        annotationView.translatesAutoresizingMaskIntoConstraints = false
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            annotationView.widthAnchor.constraint(equalToConstant: annotationView.bounds.size.width),
            annotationView.heightAnchor.constraint(equalToConstant: annotationView.bounds.size.height),
            annotationView.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            annotationView.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            wrapper.widthAnchor.constraint(equalTo: annotationView.widthAnchor, constant: BPKSpacingSm * 2),
            wrapper.heightAnchor.constraint(equalTo: annotationView.heightAnchor, constant: BPKSpacingSm * 2)
        ])
        
        return wrapper
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalCentering
        stackView.spacing = BPKSpacingMd
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
