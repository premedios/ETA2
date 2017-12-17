//
//  BusStopCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 09/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCollectionViewCell: UICollectionViewCell {

    private let busStopNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Vision.bold, size: 18)
        label.textColor = UIColor.AppColors.navyBlue
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private let busStopCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Vision.bold, size: 15)
        label.textColor = UIColor.AppColors.navyBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withModel viewModel: BusStopViewModel) {
        contentView.backgroundColor = UIColor.AppColors.lightCyan
        contentView.addSubview(busStopNameLabel)
        busStopNameLabel.text = viewModel.stopName
        contentView.addSubview(busStopCodeLabel)
        busStopCodeLabel.text = viewModel.stopCode

        busStopCodeLabel.pinAnchor(top: nil,
                                   leading: nil,
                                   bottom: nil,
                                   trailing: (anchor: contentView.trailingAnchor, constant: 8))
        busStopCodeLabel.centerAnchor(centerX: nil,
                                      centerY: (anchor: contentView.centerYAnchor, constant: 0))
        busStopNameLabel.pinAnchor(top: nil,
                                   leading: (anchor: contentView.leadingAnchor, constant: 8),
                                   bottom: nil,
                                   trailing: (anchor: busStopCodeLabel.leadingAnchor, constant: 8))
        busStopNameLabel.centerAnchor(centerX: nil,
                                      centerY: (anchor: contentView.centerYAnchor, constant: 0))

    }
}
