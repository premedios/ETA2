//
//  InterfacesDatasource.swift
//  ETA
//
//  Created by Pedro Remedios on 20/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

class InterfacesDatasource: NSObject, UICollectionViewDataSource {

    private var cellReuseID: String!

    private var viewModel: BusStopDetailViewModel!

    init(with viewModel: BusStopDetailViewModel) {
        self.viewModel = viewModel
        if self.viewModel.numberOfCells.count == 0 {
            cellReuseID = String(describing: NoInterfaceCell.self)
        } else {
            cellReuseID = String(describing: InterfaceCell.self)
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if viewModel.interfaces.count > 0 {
            return viewModel.numberOfCells.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.numberOfCells.count == 0 {
            return 0
        }
        return viewModel.numberOfCells[section]
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if viewModel.numberOfCells.count > 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath)
            guard let interfaceCell = cell as? InterfaceCell else { fatalError("Could not deque cell") }
            if indexPath.section == 0 {
                interfaceCell.interface = viewModel.interfaces[indexPath.item]
            } else {
                interfaceCell.interface = viewModel.interfaces[viewModel.numberOfCells[indexPath.section - 1] + indexPath.item]
            }
            return interfaceCell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath)
            guard let noInterfaceCell = cell as? NoInterfaceCell else { fatalError("Could not deque cell") }
            noInterfaceCell.setText(to: NSLocalizedString("No Interfaces", comment: ""))
            return noInterfaceCell
        }
    }
}
