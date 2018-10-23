//
//  BusNumberLabel.swift
//  ETA
//
//  Created by Pedro Remedios on 10/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusNumberLabel: UILabel {

    var labelText: String? {
        didSet {
            self.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.textColor = UIColor.AppColors.linen
        self.font = UIFont(name: UIFont.Vision.bold, size: 30)
        self.textAlignment = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
