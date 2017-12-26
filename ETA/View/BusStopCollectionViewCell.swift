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
        label.font = UIFont(name: UIFont.Vision.bold, size: 20)
        label.textColor = UIColor.AppColors.linen
        return label
    }()

    private let busStopCodeBackgroundView: UIView = {
        let view = UIView()
        if #available(iOS 11.0, *) {
            view.backgroundColor = UIColor(named: "Navy Blue")
        } else {
            view.backgroundColor = UIColor.AppColors.navyBlue
        }
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(withModel viewModel: BusStopViewModel) {
        contentView.backgroundColor = UIColor.AppColors.lightCyan
        contentView.addSubview(busStopCodeBackgroundView)
        busStopCodeBackgroundView.addSubview(busStopCodeLabel)
        busStopCodeLabel.text = viewModel.stopCode

        contentView.addSubview(busStopNameLabel)
        busStopNameLabel.text = viewModel.stopName

        busStopCodeBackgroundView.pinAnchor(top: (anchor: contentView.topAnchor, constant: 0),
                                            leading: (anchor: contentView.leadingAnchor, constant: 0),
                                            bottom: (anchor: contentView.bottomAnchor, constant: 0),
                                            trailing: nil)
        busStopCodeBackgroundView.sizeAnchor(width: 88, height: 0)
        busStopCodeLabel.centerAnchor(centerX: (anchor: busStopCodeBackgroundView.centerXAnchor, constant: 0),
                                      centerY: (anchor: busStopCodeBackgroundView.centerYAnchor, constant: 0))
        busStopNameLabel.pinAnchor(top: nil,
                                   leading: (anchor: busStopCodeBackgroundView.trailingAnchor, constant: 8),
                                   bottom: nil,
                                   trailing: (anchor: contentView.trailingAnchor, constant: 8))
        busStopNameLabel.centerAnchor(centerX: nil,
                                      centerY: (anchor: contentView.centerYAnchor, constant: 0))

    }
}
