//
//  CoordinatorDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 07/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

protocol CoordinatorDelegate {
    var childCoordinators: [CoordinatorDelegate] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
