//
// Created by Pedro Remedios on 12/01/2018.
// Copyright (c) 2018 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusNumbersDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var coordinator: MainCoordinator?

    var containerViewController: BusNumbersViewController?

    let datasource: BusNumbersDataSource

    init(with datasource: BusNumbersDataSource) {
        self.datasource = datasource
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let busObject = datasource.fetchedResultsController.object(at: indexPath) as? [String: String] {
            if let busNumber = busObject["carreira"] {
                containerViewController?.navigationItem.backBarButtonItem =
                    UIBarButtonItem(title: "\(busNumber)", style: .plain, target: nil, action: nil)
                coordinator?.busStops(for: busNumber)
            }
        }

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 12) / 5
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
