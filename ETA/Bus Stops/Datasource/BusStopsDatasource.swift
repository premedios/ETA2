//
//  BusStopsDatasource.swift
//  ETA
//
//  Created by Pedro Remedios on 10/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class BusStopsDatasource: NSObject, UITableViewDataSource {

    var modelController = ModelController()
    var fetchedResultsController: NSFetchedResultsController<Bus>

    init(with fetchedResultsController: NSFetchedResultsController<Bus>) {
        self.fetchedResultsController = fetchedResultsController
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busObject = fetchedResultsController.object(at: indexPath)
        if busObject.interface != "-" {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BusStopCellWithInterfaces.self)) as? BusStopCellWithInterfaces else { fatalError("Unable to dequeue cell") }
            cell.object = busObject
            cell.configure()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BusStopCell.self),
                                                           for: indexPath) as? BusStopCell
                else { fatalError("Unable to dequeue cell") }
            cell.object = busObject
            cell.configure()
            return cell
        }
    }
}
