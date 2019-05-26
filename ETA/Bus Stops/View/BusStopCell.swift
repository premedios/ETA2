//
//  BusStopCollectionViewCell.swift
//  ETA
//
//  Created by Pedro Remedios on 09/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

protocol BusStopCellDelegate {
    var viewModel: BusStopCellViewModel { get }
    
    func configure()
}

class BusStopCell: UITableViewCell, BusStopCellDelegate {

    @IBOutlet weak var busStopCodeLabel: UILabel!
    @IBOutlet weak var busStopNameLabel: UILabel!

    var object: Bus? = nil
    
    var viewModel: BusStopCellViewModel {
        return BusStopCellViewModel(with: object!)
    }

    func configure() {
        busStopCodeLabel.text = viewModel.stopCode
        busStopNameLabel.text = viewModel.stopName
    }
    
}
