//
//  Stop+CoreDataProperties.swift
//  ETA
//
//  Created by Jaime Remedios on 12/10/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//
//

import Foundation
import CoreData


extension Stop {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stop> {
        return NSFetchRequest<Stop>(entityName: "Stop")
    }

    @NSManaged public var codigo: String?
    @NSManaged public var interface: String?
    @NSManaged public var localizacao: String?
    @NSManaged public var microzona: String?
    @NSManaged public var nome: String?
    @NSManaged public var sentido: String?
    @NSManaged public var bus: Bus?

}
