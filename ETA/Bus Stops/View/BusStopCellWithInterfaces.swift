//
//  BusStopCellWithInterfaces.swift
//  ETA
//
//  Created by Pedro Remedios on 18/05/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class BusStopCellWithInterfaces: BusStopCell {

    @IBOutlet weak var busStopInterfaces: UICollectionView!
    @IBOutlet weak var busStopInterfacesWidth: NSLayoutConstraint!

    @IBOutlet weak var busStopLabelVerticalSpacing: NSLayoutConstraint!

    private var interfacesDelegate: InterfacesDelegate?
    private var interfacesDatasource: InterfacesDatasource?

    override func configure() {
        super.configure()
        interfacesDatasource = InterfacesDatasource(with: viewModel)
        interfacesDelegate = InterfacesDelegate(with: interfacesDatasource!)
        busStopInterfaces.dataSource = interfacesDatasource
        busStopInterfaces.delegate = interfacesDelegate
    }
}
