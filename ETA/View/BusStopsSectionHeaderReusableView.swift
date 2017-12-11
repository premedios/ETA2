//
//  BusStopsSectionHeaderReusableView.swift
//  ETA
//
//  Created by Pedro Remedios on 10/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopsSectionHeaderReusableView : UICollectionReusableView {
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColors.navyBlue
        return view
    }()
    
    private let sectionLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.AppColors.linen
        label.font = UIFont(name: UIFont.Vision.heavy, size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(withTitle sectionTitle:String) {
        
        sectionLabel.text = sectionTitle
        
        addSubview(backgroundView)
        backgroundView.addSubview(sectionLabel)
    
        backgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, centerX: nil, centerY: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 4, width: 0, height: 0)
        sectionLabel.anchor(top: nil, leading: backgroundView.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: backgroundView.centerYAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
