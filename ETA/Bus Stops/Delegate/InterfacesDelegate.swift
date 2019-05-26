//
//  InterfacesDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 08/03/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import UIKit

class InterfacesDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let dataSource: InterfacesDatasource

    init(with dataSource: InterfacesDatasource) {
        self.dataSource = dataSource
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 25, height: 25)
        let width = collectionView.bounds.size.width / CGFloat(dataSource.viewModel.interfaces.count)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
