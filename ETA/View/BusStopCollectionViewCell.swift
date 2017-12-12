//
//  BusStopCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 09/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCollectionViewCell : UICollectionViewCell {

    private let busStopNameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Vision.bold, size: 20)
        label.textColor = UIColor.AppColors.navyBlue
        return label
    }()
    
    private let busStopCodeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Vision.bold, size: 14)
        label.textColor = UIColor.AppColors.navyBlue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(withData viewModel: BusStopViewModel) {
        contentView.backgroundColor = UIColor.AppColors.lightCyan
        contentView.addSubview(busStopNameLabel)
        busStopNameLabel.text = viewModel.stopName
        contentView.addSubview(busStopCodeLabel)
        busStopCodeLabel.text = viewModel.stopCode
        
        busStopNameLabel.anchor(top: nil, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: contentView.centerYAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        busStopCodeLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, centerX: nil, centerY: contentView.centerYAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
}
