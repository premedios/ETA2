//
//  BusStopName.swift
//  ETA
//
//  Created by Pedro Remedios on 26/05/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopNameLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = UIFont(name: UIFont.Vision.bold, size: 18)
        self.textColor = UIColor.AppColors.navyBlue
        self.numberOfLines = 2
        self.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
