//
//  GradientSelectorTableViewController.swift
//  Backpack Native
//
//  Created by Hugo Tunius on 09/11/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class GradientSelectorTableViewController: UITableViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GradientViewController else {
            assert(false, "Destination for gradient segues shoudlbe `GradientViewController`")
        }

        switch segue.identifier {
        case "ShowPrimary":
            destination.gradientType = .primary
            destination.title = "Primary"
        case "ShowBaselineScrim":
            destination.gradientType = .baselinesSrim
            destination.title = "Baseline Scrim"
        default:
            assert(
                false,
                "Unknown segue identifier for `GradientSelectorTableViewController`:"
                + "`\(String(describing: segue.identifier))`"
            )
        }
    }
}
