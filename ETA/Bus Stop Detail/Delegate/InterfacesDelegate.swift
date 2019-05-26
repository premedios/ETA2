//
//  InterfacesDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 20/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

class InterfacesDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private var numberOfCells: [Int]!

    init(with numberOfCells: [Int]) {
        self.numberOfCells = numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width / CGFloat(numberOfCells[indexPath.section])
        return CGSize(width: width, height: 70.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
