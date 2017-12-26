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
import NotificationBanner

struct MessageResultNotification {
    private var result: MessageComposeResult

    var leftView: UIImageView!
    var message: (title: String, subTitle: String)!
    var style: BannerStyle

    init(result: MessageComposeResult) {
        self.result = result
        switch result {
        case MessageComposeResult.sent:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "success"))
            self.message = (NSLocalizedString("Message sent!", comment: ""),
                            NSLocalizedString("You will be receiving an answer shortly", comment: ""))
            self.style = .success
        case MessageComposeResult.cancelled:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "warning"))
            self.message = (NSLocalizedString("Message not sent!", comment: ""),
                            NSLocalizedString("You have cancelled sending", comment: ""))
            self.style = .warning
        case MessageComposeResult.failed:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "error"))
            self.message = (NSLocalizedString("Message not sent!", comment: ""),
                            NSLocalizedString("Please contact your mobile carrier", comment: ""))
            self.style = .danger
        }
    }
}

class BusStopsViewController: UICollectionViewController,
                              UICollectionViewDelegateFlowLayout,
                              NSFetchedResultsControllerDelegate,
                              UISearchResultsUpdating,
                              MFMessageComposeViewControllerDelegate,
                              UISearchBarDelegate {

    private let busStopCellId = "busStopCell"
    private let sectionHeaderId = "sectionHeaderId"

    var busNumber = ""

    private var searchText: String?

    private var searchController: UISearchController!
    private var searchResultsController: SearchResultsController!

    private lazy var fetchedResultsController: NSFetchedResultsController<Bus> = {
        let fetchRequest: NSFetchRequest<Bus> = Bus.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "destino", ascending: false),
        NSSortDescriptor(key: "codigo", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
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
        do {
            try fetchedResultsController.performFetch()
            collectionView?.reloadData()
        } catch {
            showAlert(withTitle: "Error",
                      message: "There was an error retrieving bus stops for this bus. Please contact the developer.")
        }

        setupUI()

        definesPresentationContext = true
    }

    fileprivate func setupSearchController() {
//        if #available(iOS 11.0, *) {
//            searchController = UISearchController(searchResultsController: nil)
//            searchController.searchResultsUpdater = self
//            navigationItem.searchController = searchController
//            navigationItem.hidesSearchBarWhenScrolling = false
//        } else {
            searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.hidesNavigationBarDuringPresentation = false
            searchController.obscuresBackgroundDuringPresentation = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleSearch))
//        }
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Search for a bus stop code", comment: "")
        searchController.searchBar.keyboardType = .phonePad
    }

    @objc private func handleSearch() {
        navigationController?.present(searchController, animated: true)
    }

    fileprivate func setupUI() {

        setupSearchController()

        collectionView?.backgroundColor = .white

        collectionView?.register(BusStopCollectionViewCell.self, forCellWithReuseIdentifier: busStopCellId)
        collectionView?.register(BusStopsSectionHeaderReusableView.self,
                    forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                    withReuseIdentifier: sectionHeaderId)
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }
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

    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: busStopCellId, for: indexPath)
        guard let busStopCollectionViewCell = cell as? BusStopCollectionViewCell else { return cell }
        let object = fetchedResultsController.object(at: indexPath)
        guard let paragem = object.localizacao, let codigo = object.codigo else { return cell }
        busStopCollectionViewCell.setup(withModel: BusStopViewModel(stopName: paragem, stopCode: codigo))

        return cell
    }

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

    // MARK: - MFMessageComposeViewControllerDelegate
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: {
            let messageResultNotification = MessageResultNotification(result: result)
            NotificationBanner(title: messageResultNotification.message.title,
                               subtitle: messageResultNotification.message.subTitle,
                               leftView: messageResultNotification.leftView, rightView: nil,
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
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
        withReuseIdentifier: sectionHeaderId, for: indexPath)
        guard let busStopSectionHeaderReusableView = view as? BusStopsSectionHeaderReusableView else { return view }
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
                NSPredicate(format: "carreira = %@ and codigo beginswith[cd] %@", busNumber, searchText)
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
                              preferredStyle: UIAlertControllerStyle.alert).show(self, sender: nil)
        }
    }
}
