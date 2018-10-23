//
//  BusStopCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 09/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

enum ScreenType {
    case BusStops, BusStopFavourites
}

class BusStopCollectionViewCell: UICollectionViewCell, BusFavouriteDelegate {
    
    var object: Bus!
    
    var delegate: BusStopCollectionViewCellDelegate?
    
    var viewModel: BusStopViewModel? {
        didSet {
            busStopNameLabel.text = viewModel?.stopName
            busStopCodeLabel.labelText = viewModel?.stopCode
            busStopCodeFavouriteButton.toggleState(favouriteState: (viewModel?.favourite)!)
        }
    }
    
    var screenType: ScreenType = .BusStops
    
    var indexPath: IndexPath! {
        didSet {
            if let row = indexPath?.row {
                busStopCodeFavouriteButton.tag = row
            }
        }
    }

    private let busStopNameLabel = BusStopNameLabel()
    private let busStopCodeLabel = BusStopCodeLabel()
    private let busStopCodeBackgroundView = BusStopCodeBackgroundView()
    private let busStopCodeFavouriteButton = BusStopCodeFavouriteButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.AppColors.lightCyan
        contentView.addSubview(busStopCodeBackgroundView)
        busStopCodeBackgroundView.addSubview(busStopCodeLabel)

        contentView.addSubview(busStopNameLabel)
        contentView.addSubview(busStopCodeFavouriteButton)

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
                                   trailing: (anchor: busStopCodeFavouriteButton.leadingAnchor, constant: 8))
        
        if screenType == .BusStops {
            busStopCodeFavouriteButton.pinAnchor(top: nil, leading: nil, bottom: nil, trailing: (anchor: contentView.trailingAnchor, constant: 8))
            busStopCodeFavouriteButton.centerAnchor(centerX: nil, centerY: (anchor: contentView.centerYAnchor, constant: 0))
            busStopNameLabel.centerAnchor(centerX: nil, centerY: (anchor: busStopCodeBackgroundView.centerYAnchor, constant: 0))
        }

        busStopCodeFavouriteButton.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapFavouriteButton(atRow: Int) {
        self.viewModel?.favourite = busStopCodeFavouriteButton.isFavourite
        delegate?.collectionView(self.superview as! UICollectionView, didChangeFavouriteStateForCellAt: self.indexPath)
    }
}
