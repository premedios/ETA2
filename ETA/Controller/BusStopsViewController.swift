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
            self.message = ("Message sent!", "You will be receiving an answer shortly")
            self.style = .success
        case MessageComposeResult.cancelled:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "warning"))
            self.message = ("Message not sent!", "You have cancelled sending")
            self.style = .warning
        case MessageComposeResult.failed:
            self.leftView = UIImageView(image: #imageLiteral(resourceName: "error"))
            self.message = ("Message not sent!", "Please contact your mobile carrier")
            self.style = .danger
        }
    }
}

class BusStopsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout,
                              NSFetchedResultsControllerDelegate, UISearchResultsUpdating,
                              MFMessageComposeViewControllerDelegate {

    private let busStopCellId = "busStopCell"
    private let sectionHeaderId = "sectionHeaderId"

    var busNumber = ""

    private var searchText: String?

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

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Bus \(busNumber)"
        do {
            try fetchedResultsController.performFetch()
        } catch {
            UIAlertController(title: "Error",
            message: "There was an error retrieving bus stops for this bus. Please contact the developer.",
          preferredStyle: .alert).show(self, sender: nil)
        }

        setupUI()

        definesPresentationContext = true
    }

    fileprivate func setupUI() {
        collectionView?.backgroundColor = .white
        collectionView?.register(BusStopCollectionViewCell.self, forCellWithReuseIdentifier: busStopCellId)
        collectionView?.register(BusStopsSectionHeaderReusableView.self,
                                 forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                 withReuseIdentifier: sectionHeaderId)
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionHeadersPinToVisibleBounds = true
        }

        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a bus stop code"
        searchController.searchBar.keyboardType = .phonePad
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
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
        dismiss(animated: true, completion: {
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

    // MARK: - UISearchUpdating
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
            UIAlertController(title: "Search Error",
                              message: "An error ocurred performing a serch. Please contact the developer.",
                              preferredStyle: UIAlertControllerStyle.alert).show(self, sender: nil)
        }
    }
}
