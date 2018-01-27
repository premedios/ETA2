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

class MainViewController: UICollectionViewController {

    let cellId = "Bus Number Cell"

    var results = [Any]()

    let mainCollectionViewDataSource = MainCollectionViewDataSource()
    let mainCollectionViewDelegate = MainCollectionViewDelegate()

    fileprivate func setupUI() {
        navigationItem.title = NSLocalizedString("Buses", comment: "")
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//            navigationController?.navigationBar.largeTitleTextAttributes =
//                [NSAttributedStringKey.foregroundColor: UIColor(named: "Navy Blue") as Any]
//        }

        collectionView?.register(BusNumberCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
    }

    fileprivate func showAlert(withTitle title: String, message: String) {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert).show(self, sender: nil)
    }

    fileprivate func setupFetchRequest() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Bus")
        fetchRequest.propertiesToFetch = ["carreira"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        do {
            let fetchResults = try CoreDataManager.sharedManager.mainContext.fetch(fetchRequest)
            results = fetchResults
            mainCollectionViewDataSource.results = results
            mainCollectionViewDelegate.results = results
        } catch {
            showAlert(withTitle: "Error",
                      message: "There was an error fetching the list of bus numbers. Please contact the developer.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        mainCollectionViewDataSource.cellId = cellId
        collectionView?.dataSource = mainCollectionViewDataSource

        mainCollectionViewDelegate.navigationController = navigationController
        collectionView?.delegate = mainCollectionViewDelegate

        setupUI()

        setupFetchRequest()

//        let request = URLRequest(url: URL(string: "http://carris.pt")!)
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print("Data: ", data ?? "")
//            print("Response: ", response ?? "")
//            print("Error: ", error ?? "")
//        }
//        dataTask.resume()

    }

}
