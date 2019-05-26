//
//  BusNumberCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusNumberCell: UICollectionViewCell {

    @IBOutlet weak var busNumberLabel: UILabel!

    var busNumber: String? {
        didSet {
            busNumberLabel.text = busNumber
        }
    }
}
