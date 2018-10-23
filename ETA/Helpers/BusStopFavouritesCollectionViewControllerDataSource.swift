//
//  BusStopFavouritesCollectionViewControllerDataSource.swift
//  ETA
//
//  Created by Pedro Remedios on 16/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusStopFavouritesCollectionViewControllerDataSource: NSObject, UICollectionViewDataSource {

    var cellID: String?
    var sectionCellID = ""
    var fetchedResultsController: NSFetchedResultsController<Bus>?
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = fetchedResultsController?.sections else { return 0 }
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let object = fetchedResultsController?.object(at: indexPath), let carreira = object.carreira {
            print(carreira)
        }
        
        
        if let cellID = cellID {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BusStopFavouritesCollectionViewCell
            
            // Configure the cell
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        print(sectionCellID)
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: sectionCellID, for: indexPath)
        guard let busStopFavouritesSectionHeaderReusableView = view as? ETASectionHeaderReusableView else { return view }
        
        let sectionInfo = fetchedResultsController?.sections?[indexPath.section]
        busStopFavouritesSectionHeaderReusableView.setup(withTitle: sectionInfo?.name ?? "")
        return busStopFavouritesSectionHeaderReusableView
    }

}
