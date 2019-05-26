//
//  ModelController.swift
//  ETA
//
//  Created by Pedro Remedios on 03/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import CoreData

class ModelController: Model {
    var databaseController = DatabaseController(with: "ETA")

    init(with databaseController: DatabaseController = DatabaseController(with: "ETA")) {
        self.databaseController = databaseController
    }

    func fetchAllBusNumbers(onCompletion: ((NSFetchRequest<NSFetchRequestResult>) -> Void)?) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "Bus")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "carreira", ascending: true)]
        fetchRequest.propertiesToFetch = ["carreira"]
        fetchRequest.returnsDistinctResults = true
        fetchRequest.resultType = NSFetchRequestResultType.dictionaryResultType
        onCompletion?(fetchRequest)
    }

    func getAllBusNumbers(onCompletion: ((NSFetchedResultsController<NSFetchRequestResult>) -> Void)?,
                          onError: ((Error) -> Void)?) {
        fetchAllBusNumbers { [weak self] (fetchRequest) in
            if let strongSelf = self {
                let fetchedResultsController =
                    NSFetchedResultsController(fetchRequest: fetchRequest,
                                               managedObjectContext: strongSelf.databaseController.backgroundContext,
                                               sectionNameKeyPath: nil, cacheName: nil)
                do {
                    try fetchedResultsController.performFetch()
                } catch {
                    onError?(error)
                }
                onCompletion?(fetchedResultsController)
            }
        }
    }

    func fetchAllBusStops(for busNumber: String, onCompletion: ((NSFetchRequest<Bus>) -> Void)?) {
        let fetchRequest: NSFetchRequest<Bus> = Bus.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "destino", ascending: false),
                                        NSSortDescriptor(key: "codigo", ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
        onCompletion?(fetchRequest)
    }

    func getAllBusStops(for busNumber: String, onCompletion: ((NSFetchedResultsController<Bus>?, Error?) -> Void)?) {
        fetchAllBusStops(for: busNumber) { [weak self] (fetchRequest) in
            if let strongSelf = self {
                let fetchedResultsController =
                    NSFetchedResultsController(fetchRequest: fetchRequest,
                                               managedObjectContext: strongSelf.databaseController.backgroundContext,
                                               sectionNameKeyPath: "destino", cacheName: nil)
                do {
                    try fetchedResultsController.performFetch()
                } catch {
                    onCompletion?(nil, error)
                }
                onCompletion?(fetchedResultsController, nil)
            }
        }
    }

    func findBusStops(for busNumber: String,
                      with searchText: String,
                      using fetchedResultsController: inout NSFetchedResultsController<Bus>,
                      onSuccess: (() -> Void)?,
                      onError: ((Error?) -> Void)?) {
        if searchText != "" {
            fetchedResultsController.fetchRequest.predicate =
                NSPredicate(format: "carreira = %@ and codigo contains[cd] %@", busNumber, searchText)
        } else {
            fetchedResultsController.fetchRequest.predicate = NSPredicate(format: "carreira = %@", busNumber)
        }
        do {
            try fetchedResultsController.performFetch()
        } catch {
            onError?(error)
        }
        onSuccess?()
    }
}
