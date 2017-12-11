//
//  MainViewController.swift
//  ETA
//
//  Created by Jaime Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData
import WebKit

class MainViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "Bus Number Cell"
    
    var results = [Any]()
    
    fileprivate func setupUI() {
        navigationItem.title = "Buses"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.AppColors.navyBlue]
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        collectionView?.register(BusNumberCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Bus")
        fetchRequest.propertiesToFetch = ["carreira"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        do {
            let fetchResults = try CoreDataManager.sharedManager.mainContext.fetch(fetchRequest)
            results = fetchResults
        } catch {
            print(error)
        }
        
//        let request = URLRequest(url: URL(string: "http://carris.pt")!)
//        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            print("Data: ", data ?? "")
//            print("Response: ", response ?? "")
//            print("Error: ", error ?? "")
//        }
//        dataTask.resume()
        
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let busNumberCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BusNumberCollectionViewCell
        guard let busObject = results[indexPath.row] as? [String:String], let busNumber = busObject["carreira"]  else { return busNumberCollectionViewCell }
        busNumberCollectionViewCell.viewModel = BusNumberViewModel(carreira: busNumber)
        busNumberCollectionViewCell.setupUI()
        return busNumberCollectionViewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let busObject = results[indexPath.row] as? [String:String], let busNumber = busObject["carreira"] else { return }
        //print(item["carreira"]!)
        let busStopsViewController = BusStopsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        busStopsViewController.busNumber = busNumber
        navigationController?.pushViewController(busStopsViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width - 9) / 3, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}
    

