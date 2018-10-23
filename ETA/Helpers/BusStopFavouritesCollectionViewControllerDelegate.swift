//
//  BusStopFavouritesCollectionViewControllerDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 16/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusStopFavouritesCollectionViewControllerDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var navigationController: UINavigationController?
    var fetchedResultsController: NSFetchedResultsController<Bus>?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // MARK: - UICollectionViewFlowLayoutDelegate
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width-8, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
}
