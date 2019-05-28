//
//  InterfaceCell.swift
//  ETA
//
//  Created by Pedro Remedios on 10/03/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class InterfaceCell: UICollectionViewCell {
    @IBOutlet weak var interfaceImageView: UIImageView!
    
    var interface: Interface? {
        didSet {
            if interface != nil {
                interfaceImageView.image = UIImage(named: (interface!.rawValue))
            }
        }
    }
}
