//
//  InterfacesDatasource.swift
//  ETA
//
//  Created by Pedro Remedios on 08/03/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class InterfacesDatasource: NSObject, UICollectionViewDataSource {

    let viewModel: BusStopCellViewModel

    init(with viewModel: BusStopCellViewModel) {
        self.viewModel = viewModel
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.interfaces.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: InterfaceCell.self), for: indexPath)
        guard let interfaceCell = cell as? InterfaceCell else { fatalError("Wrong collection view cell for bus stop interfaces") }
        interfaceCell.interface = viewModel.interfaces[indexPath.item]
        return interfaceCell
    }

}
