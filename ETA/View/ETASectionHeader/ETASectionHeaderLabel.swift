//
//  ETASectionHeaderLabel.swift
//  ETA
//
//  Created by Pedro Remedios on 24/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class ETASectionHeaderLabel: UILabel {

    var labelText: String? {
        didSet {
            self.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor(named: "Linen")
        self.font = UIFont(name: UIFont.Vision.heavy, size: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
