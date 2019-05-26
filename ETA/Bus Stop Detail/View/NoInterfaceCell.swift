//
//  NoInterfaceCell.swift
//  ETA
//
//  Created by Pedro Remedios on 25/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class NoInterfaceCell: UICollectionViewCell {
    @IBOutlet weak var noInterfacesLabel: UILabel!

    func setText(to string: String) {
        noInterfacesLabel.text = string
    }
}
