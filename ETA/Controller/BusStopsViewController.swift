//
//  BusStopsViewController.swift
//  ETA
//
//  Created by Pedro Remedios on 08/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData
import MessageUI
import NotificationBannerSwift

class BusStopsViewController: UICollectionViewController,
                              UICollectionViewDelegateFlowLayout,
                              NSFetchedResultsControllerDelegate,
                              UISearchResultsUpdating,
                              MFMessageComposeViewControllerDelegate,
                              UISearchBarDelegate,
                              BusStopCollectionViewCellDelegate {

    private let busStopCellId = "busStopCell"
    private let sectionHeaderId = "sectionHeaderId"

    var busNumber = ""

    private var searchText: String?

    private var searchController: UISearchController!
    
    private var rightBarButtonItems = [UIBarButtonItem]();

    private lazy var fetchedResultsController: NSFetchedResultsController<Bus> = {
        let fetchRequest: NSFetchRequest<Bus> = Bus.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "destino", ascending: false),
        NSSortDescriptor(key: "codigo", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
        //fetchRequest.propertiesToFetch = ["codigo", "favourite", "destino"]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
          managedObjectContext: CoreDataManager.sharedManager.mainContext,
          sectionNameKeyPath: "destino", cacheName: nil)
        frc.delegate = self
        return frc
    }()

    fileprivate func showAlert(withTitle title: String, message: String) {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert).show(self, sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "\(NSLocalizedString("Bus", comment: "")) \(busNumber)"
        navigationItem.largeTitleDisplayMode = .never
        do {
            try fetchedResultsController.performFetch()
            //collectionView?.reloadData()
        } catch {
            showAlert(withTitle: "Error",
                      message: "There was an error retrieving bus stops for this bus. Please contact the developer.")
        }

        setupUI()

    }

    fileprivate func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = NSLocalizedString("Search for a bus stop code", comment: "")
        searchController.searchBar.keyboardType = .phonePad
        searchController.dimsBackgroundDuringPresentation = false
    }

    @objc private func handleSearch() {
        navigationController?.present(searchController, animated: true)
    }

    fileprivate func setupUI() {

        setupSearchController()

        collectionView?.backgroundColor = .white

        collectionView?.register(BusStopCollectionViewCell.self, forCellWithReuseIdentifier: busStopCellId)
        collectionView?.register(ETASectionHeaderReusableView.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: sectionHeaderId)
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }

        navigationItem.rightBarButtonItems = rightBarButtonItems
    }

    // MARK: - UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: busStopCellId, for: indexPath)
        guard let busStopCollectionViewCell = cell as? BusStopCollectionViewCell else { return cell }
        let object = fetchedResultsController.object(at: indexPath)
        guard let paragem = object.localizacao, let codigo = object.codigo else { return cell }
        busStopCollectionViewCell.object = object
        busStopCollectionViewCell.indexPath = indexPath
        busStopCollectionViewCell.viewModel = BusStopViewModel(stopName: paragem, stopCode: codigo, favourite: object.favourite)
        busStopCollectionViewCell.delegate = self
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if MFMessageComposeViewController.canSendText() {
            let object = fetchedResultsController.object(at: indexPath)
            guard let codigo = object.codigo else { return }
            let messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.messageComposeDelegate = self
            messageComposeViewController.recipients = ["3599"]
            messageComposeViewController.body = "C \(codigo)"
            present(messageComposeViewController, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false;
    }

    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {
            let messageResultNotification = MessageResultNotification(result: result)
            NotificationBanner(title: messageResultNotification.message.title,
                               subtitle: messageResultNotification.message.subTitle,
                               leftView: messageResultNotification.leftView,
                               style: messageResultNotification.style).show()
        })
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

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: sectionHeaderId, for: indexPath)
        guard let busStopSectionHeaderReusableView = view as? ETASectionHeaderReusableView else { return view }
        let sectionInfo = fetchedResultsController.sections?[indexPath.section]
        busStopSectionHeaderReusableView.setup(withTitle: sectionInfo?.name ?? "")
        return view
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 50)
    }

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else { return }
        if searchText != "" {
            fetchedResultsController.fetchRequest.predicate =
                NSPredicate(format: "carreira = %@ and codigo contains[cd] %@", busNumber, searchText)
        } else {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
        }
        do {
            try fetchedResultsController.performFetch()
            collectionView?.reloadData()
        } catch {
            let title = NSLocalizedString("Search Error", comment: "")
            let message = NSLocalizedString(
                "An error ocurred performing a search. Please contact the developer.", comment: "")
            UIAlertController(title: title,
                              message: message,
                              preferredStyle: UIAlertController.Style.alert).show(self, sender: nil)
        }
    }
    
    // MARK: - BusStopCollectionViewCellDelegate
    func collectionView(_ collectionView: UICollectionView, didChangeFavouriteStateForCellAt indexPath: IndexPath) {
        let object: Bus = fetchedResultsController.object(at: indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as! BusStopCollectionViewCell
        if let favourite = cell.viewModel?.favourite {
            object.favourite = favourite
        }
        try! fetchedResultsController.managedObjectContext.save()
    }
}
