//
//  BusStopsViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 08/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusStopsViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, UISearchBarDelegate {
    
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
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundColor = UIColor.AppColors.lightCyan
        sb.placeholder = "Enter the bus stop code"
        sb.delegate = self
        return sb
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.register(BusStopCollectionViewCell.self, forCellWithReuseIdentifier: busStopCellId)
        cv.register(BusStopsSectionHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        (cv.collectionViewLayout as! UICollectionViewFlowLayout).sectionHeadersPinToVisibleBounds = true
//        let layout = cv.collectionViewLayout as? UICollectionViewFlowLayout {
//        layout.sectionHeadersPinToVisibleBounds = true
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(handleSearch))
        navigationItem.rightBarButtonItem = searchBarButtonItem
        navigationItem.title = "Bus \(busNumber) stops"
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Unable to set up fetched results controller")
        }
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        searchBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        collectionView.anchor(top: searchBar.bottomAnchor, leading: searchBar.leadingAnchor, bottom: view.bottomAnchor, trailing: searchBar.trailingAnchor, centerX: nil, centerY: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleSearch() {
        print("Searching...")
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        print("\(sections.count) sections")
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId, for: indexPath) as! BusStopsSectionHeaderReusableView
        let sectionInfo = fetchedResultsController.sections?[indexPath.section]
        view.setup(withTitle: sectionInfo?.name ?? "")
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
    
}
