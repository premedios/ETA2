//
//  SearchResultsController.swift
//  ETA
//
//  Created by Pedro Remedios on 23/12/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController, UISearchResultsUpdating {
    let cellId = "cellId"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        print("called")
    }
}
