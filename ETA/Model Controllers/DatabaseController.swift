//
//  DatabaseController.swift
//  ETA
//
//  Created by Pedro Remedios on 28/10/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import Foundation
import CoreData

final class DatabaseController {

    private var modelName = ""

    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var mainContext: NSManagedObjectContext = {
        storeContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        storeContainer.viewContext.undoManager = nil
        storeContainer.viewContext.automaticallyMergesChangesFromParent = true
        return storeContainer.viewContext
    }()

    lazy var backgroundContext: NSManagedObjectContext = {
        let newBackgroundContext = storeContainer.newBackgroundContext()
        newBackgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        newBackgroundContext.automaticallyMergesChangesFromParent = true
        return newBackgroundContext
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Unable to find data model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load data model")
        }
        return managedObjectModel
    }()

    lazy var storeURL: URL = {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask).last?.appendingPathComponent("\(modelName).sqlite",
                                        isDirectory: false)
    }()!

    init(with modelName: String) {
        self.modelName = modelName
    }

    convenience init(with container: NSPersistentContainer) {
        self.init(with: "ETA")
        storeContainer = container
    }

    class func loadPreloadedDatabase(with name: String) {

        var sqliteSourcePath: String?
        var sqliteSourcePathShm: String?
        var sqliteSourcePathWal: String?

        var sqliteSourceURL: URL? = nil
        var sqliteDestinationURL: URL? = nil
        var sqliteSourceURLShm: URL? = nil
        var sqliteDestinationURLShm: URL? = nil
        var sqliteSourceURLWal: URL? = nil
        var sqliteDestinationURLWal: URL? = nil

        // Get the full pathname of the preloaded database
        sqliteSourcePath = Bundle.main.path(forResource: name, ofType: "sqlite")
        sqliteSourcePathShm = Bundle.main.path(forResource: name, ofType: "sqlite-shm")
        sqliteSourcePathWal = Bundle.main.path(forResource: name, ofType: "sqlite-wal")

        // Get the URLs of the pathnames from above
        if let path = sqliteSourcePath {
            sqliteSourceURL = URL(fileURLWithPath: path)
        }
        if let path = sqliteSourcePathShm {
            sqliteSourceURLShm = URL(fileURLWithPath: path)
        }

        if let path = sqliteSourcePathWal {
            sqliteSourceURLWal = URL(fileURLWithPath: path)
        }

        let sqliteDestinationPath = NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite"
        let sqliteDestinationPathShm = NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite-shm"
        let sqliteDestinationPathWal = NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite-wal"
        sqliteDestinationURL = URL(fileURLWithPath: sqliteDestinationPath)
        sqliteDestinationURLShm = URL(fileURLWithPath: sqliteDestinationPathShm)
        sqliteDestinationURLWal = URL(fileURLWithPath: sqliteDestinationPathWal)

        // Copy if doesn't exist
        if !FileManager.default.fileExists(atPath: sqliteDestinationPath) {
            do {
                if let url = sqliteSourceURL {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURL!)
                }
                if let url = sqliteSourceURLShm {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURLShm!)
                }
                if let url = sqliteSourceURLWal {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURLWal!)
                }
                print("Copied")
            } catch {
                print("=======================")
                print("ERROR IN COPY OPERATION")
                print(error)
                print("=======================")
            }
        }
    }

    func setModel(toName name: String) {
        modelName = name
    }

    func save() {
        guard mainContext.hasChanges else { return }

        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
