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

class BusStopsViewController: UITableViewController,
                              UISearchResultsUpdating,
                              MFMessageComposeViewControllerDelegate,
                              UISearchBarDelegate, Storyboarded {

    var busNumber = ""

    private var searchText: String?

    private var searchController: UISearchController!

    private var modelController = ModelController()

    private var dataSource: BusStopsDatasource?
    private var delegate: BusStopsDelegate?

    var coordinator: BusStopsCoordinator?

    fileprivate func showAlert(withTitle title: String, message: String) {
        let title = NSLocalizedString(title, comment: "")
        let message = NSLocalizedString(message, comment: "")
        UIAlertController(title: title,
                          message: message,
                          preferredStyle: .alert).show(self, sender: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let reuseID = String(describing: BusStopsSectionHeader.self)
        self.tableView.register(BusStopsSectionHeader.self, forHeaderFooterViewReuseIdentifier: reuseID)

        tableView.separatorStyle = .none

        modelController.getAllBusStops(for: busNumber) { [weak self] (fetchedResultsController, error) in
            if let fetchedResultsController = fetchedResultsController {
                self?.dataSource = BusStopsDatasource(with: fetchedResultsController)
                self?.delegate = BusStopsDelegate(with: (self?.dataSource)!)
                self?.delegate?.coordinator = self?.coordinator
                self?.tableView?.delegate = self?.delegate
                self?.tableView?.dataSource = self?.dataSource
                self?.tableView?.reloadData()
            }
        }

        navigationItem.title = "\(NSLocalizedString("Bus", comment: "")) \(busNumber)"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem?.title = "\(busNumber)"

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

        tableView?.backgroundColor = .white

        navigationItem.backBarButtonItem =
            UIBarButtonItem(title: "\(busNumber)",
                style: .plain,
                target: nil,
                action: nil)
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

    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {

        guard let searchText = searchController.searchBar.text else { return }
        guard let dataSource = tableView?.dataSource as? BusStopsDatasource else { return }
        modelController.findBusStops(for: busNumber,
                                     with: searchText,
                                     using: &dataSource.fetchedResultsController,
                                     onSuccess: { [weak self] in
            self?.tableView?.reloadData()
            }, onError: { (error) in
                let title = NSLocalizedString("Search Error", comment: "")
                let message = NSLocalizedString(
                    "An error ocurred performing a search. Please contact the developer.", comment: "")
                UIAlertController(title: title,
                                  message: message,
                                  preferredStyle: UIAlertController.Style.alert).show(self, sender: nil)
        })
    }

}
