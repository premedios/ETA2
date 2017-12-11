//
//  BusStopsViewController.swift
//  ETA
//
//  Created by Jaime Remedios on 08/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusStopsViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
    
    private let busStopCellId = "busStopCell"
    private let sectionHeaderId = "sectionHeaderId"
    
    var busNumber = ""
    
    private lazy var fetchedResultsController : NSFetchedResultsController<Bus> = {
        let fetchRequest : NSFetchRequest<Bus> = Bus.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "destino", ascending: false), NSSortDescriptor(key: "codigo", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.sharedManager.mainContext, sectionNameKeyPath: "destino", cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        collectionView?.backgroundColor = .white
        navigationItem.title = "Bus \(busNumber) stops"
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unable to set up fetched results controller")
        }
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
        
        collectionView?.register(BusStopCollectionViewCell.self, forCellWithReuseIdentifier: busStopCellId)
        collectionView?.register(BusStopsSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
    }
    
    @objc func handleSearch() {
        print("Searching...")
    }
    
    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        print("\(sections.count) sections")
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: busStopCellId, for: indexPath) as! BusStopCollectionViewCell
        let object = fetchedResultsController.object(at: indexPath)
        guard let paragem = object.localizacao else { return cell }
        guard let codigo = object.codigo else { return cell }
        cell.setup(withData: BusStopViewModel(stopName: paragem, stopCode: codigo))
        return cell
    }
    
    // MARK: - UICollectionViewFlowLayoutDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width-8, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId, for: indexPath) as! BusStopsSectionHeaderReusableView
        let sectionInfo = fetchedResultsController.sections?[indexPath.section]
        view.setup(withTitle: sectionInfo?.name ?? "")
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
}
