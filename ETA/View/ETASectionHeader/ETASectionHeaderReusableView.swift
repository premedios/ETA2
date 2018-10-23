//
//  ETASectionHeaderReusableView.swift
//  ETA
//
//  Created by Pedro Remedios on 21/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class ETASectionHeaderReusableView: UICollectionReusableView {
    private let backgroundView = ETASectionHeaderBackgroundView()
    private let sectionLabel = ETASectionHeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(withTitle sectionTitle: String) {
        
        sectionLabel.labelText = sectionTitle
        
        addSubview(backgroundView)
        backgroundView.addSubview(sectionLabel)
        
        backgroundView.pinAnchor(top: (anchor: topAnchor, constant: 4),
                                 leading: (anchor: leadingAnchor, constant: 4),
                                 bottom: (anchor: bottomAnchor, constant: 4),
                                 trailing: (anchor: trailingAnchor, constant: 4))
        
        sectionLabel.pinAnchor(top: nil,
                               leading: (anchor: backgroundView.leadingAnchor, constant: 8),
                               bottom: nil,
                               trailing: nil)
        sectionLabel.centerAnchor(centerX: nil,
                                  centerY: (anchor: backgroundView.centerYAnchor, constant: 0))
    }
}
