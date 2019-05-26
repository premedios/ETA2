//
//  ModelControllerProtocol.swift
//  ETA
//
//  Created by Pedro Remedios on 03/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import CoreData

protocol Model {
    var databaseController: DatabaseController { get set }
}
