//
//  MainViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData
import WebKit

import CloudKit

class BusNumbersViewController: UICollectionViewController, Storyboarded {

    var modelController = ModelController()

    var busNumbersDatasource: BusNumbersDataSource?
    var busNumbersDelegate: BusNumbersDelegate?

    var coordinator: MainCoordinator?

    fileprivate func setupUI() {
        navigationItem.title = NSLocalizedString("Buses", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor(named: "Navy Blue") as Any]

        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
    }

    fileprivate func showAlert(withTitle title: String, message: String) {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert).show(self, sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let favouritesQuery = CKQuery(recordType: "Favourites", predicate: NSPredicate(value: true))

        CKContainer.default().publicCloudDatabase.perform(favouritesQuery, inZoneWith: nil) { records, error in
            if let records = records {
                for record in records {
                    print(record.value(forKey: "busnumber")!)
                }
            }
        }

        modelController.getAllBusNumbers(onCompletion: { [weak self] (fetchedResultsController) in
            self?.busNumbersDatasource = BusNumbersDataSource(with: fetchedResultsController)
            self?.busNumbersDelegate = BusNumbersDelegate(with: (self?.busNumbersDatasource)!)
            self?.busNumbersDelegate!.coordinator = self?.coordinator
            self?.collectionView?.dataSource = self?.busNumbersDatasource
            self?.collectionView?.delegate = self?.busNumbersDelegate
            self?.collectionView?.reloadData()
            }, onError: { (error) in
                print("Error")
        })

        setupUI()
    }

}
