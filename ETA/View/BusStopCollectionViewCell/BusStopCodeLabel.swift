//
//  BusStopCodeLabel.swift
//  ETA
//
//  Created by Pedro Remedios on 27/05/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCodeLabel: UILabel {

    var labelText: String? {
        didSet {
            self.text = labelText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: UIFont.Vision.bold, size: 20)
        self.textColor = UIColor.AppColors.linen
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
