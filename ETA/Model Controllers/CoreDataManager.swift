//
//  CoreDataManager.swift
//  ETACoreDataImport
//
//  Created by Pedro Remedios on 28/10/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
    
    // MARK: - Properties
    
    private var modelName = "";
    
    private lazy var storeContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var mainContext : NSManagedObjectContext = {
        storeContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        storeContainer.viewContext.undoManager = nil
        return storeContainer.viewContext
    }()
    
    lazy var backgroundContext : NSManagedObjectContext = {
        let newBackgroundContext = storeContainer.newBackgroundContext()
        newBackgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        newBackgroundContext.automaticallyMergesChangesFromParent = true
        return newBackgroundContext
    }()
    
    private lazy var managedObjectModel : NSManagedObjectModel = {
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Unable to find data model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Unable to load data model")
        }
        return managedObjectModel
    }()
    
    lazy var storeURL : URL = {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("\(modelName).sqlite", isDirectory: false)
        }()!
    
    // MARK: - Initializer
    
    // Private initializer for singleton
    private init() {}
    
    // MARK: - Methods
    
    func loadPreloadedDatabase(withName name:String) {
        
        var sqliteSourcePath : String?
        var sqliteSourcePath_shm : String?
        var sqliteSourcePath_wal : String?
        
        var sqliteSourceURL : URL? = nil
        var sqliteDestinationURL : URL? = nil
        var sqliteSourceURL_shm : URL? = nil
        var sqliteDestinationURL_shm : URL? = nil
        var sqliteSourceURL_wal : URL? = nil
        var sqliteDestinationURL_wal : URL? = nil
        
        // Get the full pathname of the preloaded database
        sqliteSourcePath = Bundle.main.path(forResource: name, ofType: "sqlite")
        sqliteSourcePath_shm = Bundle.main.path(forResource: name, ofType: "sqlite-shm")
        sqliteSourcePath_wal = Bundle.main.path(forResource: name, ofType: "sqlite-wal")
        
        // Get the URLs of the pathnames from above
        if let path = sqliteSourcePath {
            sqliteSourceURL = URL(fileURLWithPath: path)
        }
        if let path = sqliteSourcePath_shm {
            sqliteSourceURL_shm = URL(fileURLWithPath: path)
        }
        
        if let path = sqliteSourcePath_wal {
            sqliteSourceURL_wal = URL(fileURLWithPath: path)
        }
        
        sqliteDestinationURL = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite")
        sqliteDestinationURL_shm = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite-shm")
        sqliteDestinationURL_wal = URL(fileURLWithPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite-wal")
        
        // Copy if doesn't exist
        if !FileManager.default.fileExists(atPath: NSPersistentContainer.defaultDirectoryURL().relativePath + "/\(name).sqlite") {
            do {
                if let url = sqliteSourceURL  {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURL!)
                }
                if let url = sqliteSourceURL_shm {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURL_shm!)
                }
                if let url = sqliteSourceURL_wal {
                    try FileManager.default.copyItem(at: url, to: sqliteDestinationURL_wal!)
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
    
    func setModel(toName name:String) {
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
