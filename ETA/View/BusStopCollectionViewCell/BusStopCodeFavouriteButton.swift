//
//  BusStopCodeFavouriteButton.swift
//  ETA
//
//  Created by Pedro Remedios on 27/05/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCodeFavouriteButton: UIButton {

    var delegate: BusFavouriteDelegate?
    
    var isFavourite: Bool? {
        didSet {
            self.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: (self.isFavourite ?? false) ? .solid : .regular)
            self.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.fontAwesome(ofSize: 30, style: (self.isFavourite ?? false) ? .solid : .regular)
        self.setTitle(String.fontAwesomeIcon(name: .star), for: .normal)
        self.setTitleColor(UIColor(named: "Navy Blue"), for: .normal)
        self.addTarget(self, action: #selector(self.toggleIcon), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggleState(favouriteState: Bool) {
        self.isFavourite = favouriteState
    }
    
    @objc
    func toggleIcon(sender: UIButton) {
        self.isFavourite = !(self.isFavourite ?? false)
        delegate?.didTapFavouriteButton(atRow: tag)
    }
    
}
