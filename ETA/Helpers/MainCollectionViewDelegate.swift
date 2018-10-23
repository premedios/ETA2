//
// Created by Pedro Remedios on 12/01/2018.
// Copyright (c) 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class MainCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var results = [Any]()
    var navigationController: UINavigationController? = nil

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let busObject = results[indexPath.row] as? [String: String],
              let busNumber = busObject["carreira"] else { return }
        let busStopsViewController = BusStopsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        busStopsViewController.busNumber = busNumber
        navigationController?.pushViewController(busStopsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.size.width - 9) / 4
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
