//
// Created by Pedro Remedios on 12/01/2018.
// Copyright (c) 2018 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

class BusNumbersDataSource: NSObject, UICollectionViewDataSource {

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>

    init(with fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>) {
        self.fetchedResultsController = fetchedResultsController
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: BusNumberCell.self),
                                               for: indexPath) as? BusNumberCell
        else {
            fatalError("Cannot find the cell to reuse with that identifier")
        }
        guard let busObject = fetchedResultsController.object(at: indexPath) as? [String: String] else {
            return cell
        }
        cell.busNumber = busObject["carreira"]
        return cell
    }
}
