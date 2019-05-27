//
//  BusStopsCoordinator.swift
//  ETA
//
//  Created by Pedro Remedios on 26/05/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

class BusStopsCoordinator: CoordinatorDelegate {
    var childCoordinators = [CoordinatorDelegate]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = BusStopsViewController.instantiate()
        viewController.coordinator = self
    }
}
