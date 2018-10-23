//
//  BusStopFavouritesViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 10/06/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

private let cellID = "Cell"
private let headerCellID = "Header"

class BusStopFavouritesViewController: UICollectionViewController,
                                       NSFetchedResultsControllerDelegate {

    private let busStopFavouritesCollectionViewControllerDataSource = BusStopFavouritesCollectionViewControllerDataSource()
    private let busStopFavouritesCollectionViewControllerDelegate = BusStopFavouritesCollectionViewControllerDelegate()
    
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Bus> = {
        let fetchRequest: NSFetchRequest<Bus> = Bus.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "carreira", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "favourite = 1")
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: CoreDataManager.sharedManager.mainContext,
                                             sectionNameKeyPath: "carreira", cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(BusStopFavouritesCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.register(ETASectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellID)
        
        busStopFavouritesCollectionViewControllerDataSource.cellID = cellID
        busStopFavouritesCollectionViewControllerDataSource.sectionCellID = headerCellID
        busStopFavouritesCollectionViewControllerDataSource.fetchedResultsController = fetchedResultsController
        
        busStopFavouritesCollectionViewControllerDelegate.navigationController = navigationController
        busStopFavouritesCollectionViewControllerDelegate.fetchedResultsController = fetchedResultsController
        
        collectionView?.backgroundColor = .white
        
        collectionView?.dataSource = busStopFavouritesCollectionViewControllerDataSource
        collectionView?.delegate = busStopFavouritesCollectionViewControllerDelegate
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = NSLocalizedString("Favourites", comment: "")
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: "Navy Blue") as Any]
        try! fetchedResultsController.performFetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        try! fetchedResultsController.performFetch()
    }
}
