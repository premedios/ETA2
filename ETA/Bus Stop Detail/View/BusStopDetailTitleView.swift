//
//  BusStopDetailTitleView.swift
//  ETA
//
//  Created by Pedro Remedios on 19/01/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopDetailTitleView: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        self.font = UIFont.preferredFont(forTextStyle: .headline)
        self.textAlignment = .center
        self.textColor = UIColor(named: "Navy Blue")
        self.numberOfLines = 2

        self.widthAnchor.constraint(equalToConstant: 200).isActive = true
        //self.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
