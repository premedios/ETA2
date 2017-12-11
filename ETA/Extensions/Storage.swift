//
//  storage.swift
//  Places
//
//  Created by Caixa Mágica on 02/04/2017.
//  Copyright © 2017 Caixa Magica. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/// NSPersistentStoreCoordinator extension
extension NSPersistentStoreCoordinator {
  
  /// NSPersistentStoreCoordinator error types
  public enum CoordinatorError: Error {
    /// .momd file not found
    case modelFileNotFound
    /// NSManagedObjectModel creation fail
    case modelCreationError
    /// Gettings document directory fail
    case storePathNotFound
  }
  
  /// Return NSPersistentStoreCoordinator object
  static func coordinator(name: String) throws -> NSPersistentStoreCoordinator? {
    
    guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {
      throw CoordinatorError.modelFileNotFound
    }
    
    guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
      throw CoordinatorError.modelCreationError
    }
    
    let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
    
    guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
      throw CoordinatorError.storePathNotFound
    }
    
    do {
      let url = documents.appendingPathComponent("\(name).sqlite")
      let options = [ NSMigratePersistentStoresAutomaticallyOption : true,
                      NSInferMappingModelAutomaticallyOption : true ]
      try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
    } catch {
      throw error
    }
    
    return coordinator
  }
}

struct Storage {
  
  var shouldUpdate = false
  static var shared = Storage()
  
  @available(iOS 10.0, *)
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Places")
    container.loadPersistentStores { (storeDescription, error) in
      guard error == nil else {
        print("CoreData: Unresolved error \(error!)")
        return
      }
    }
    return container
  }()
  
  private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
    do {
      return try NSPersistentStoreCoordinator.coordinator(name: "Places")
    } catch {
      print("CoreData: Unresolved error \(error)")
    }
    return nil
  }()
  
  private lazy var managedObjectContext: NSManagedObjectContext = {
    let coordinator = self.persistentStoreCoordinator
    var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    managedObjectContext.undoManager = nil
    managedObjectContext.persistentStoreCoordinator = coordinator
    return managedObjectContext
  }()
  
  private lazy var privateManagedObjectContext: NSManagedObjectContext = {
    var managedObjectContext = self.persistentContainer.newBackgroundContext()
    managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    managedObjectContext.undoManager = nil
    //managedObjectContext.parent = self.managedObjectContext
    managedObjectContext.automaticallyMergesChangesFromParent = true
    return managedObjectContext
  }()
  
  // MARK: Public methods
  
  enum SaveStatus {
    case saved, rolledBack, hasNoChanges
  }
  
  var context: NSManagedObjectContext {
    mutating get {
        return persistentContainer.viewContext
    }
  }
  
  var backgroundContext: NSManagedObjectContext {
    mutating get {
//      if #available(iOS 10.0, *) {
//        return persistentContainer.newBackgroundContext()
//      } else {
//        return privateManagedObjectContext
//      }
      return privateManagedObjectContext
    }
  }
  
  mutating func save() -> SaveStatus {
    if context.hasChanges {
      do {
        try context.save()
        return .saved
      } catch {
        context.rollback()
        return .rolledBack
      }
    }
    return .hasNoChanges
  }
  
}
