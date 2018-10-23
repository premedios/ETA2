//
//  BusStopCodeBackgroundView.swift
//  ETA
//
//  Created by Pedro Remedios on 27/05/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCodeBackgroundView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "Navy Blue")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
