//
//  MainCoordinator.swift
//  ETA
//
//  Created by Pedro Remedios on 11/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: CoordinatorDelegate {
    var childCoordinators = [CoordinatorDelegate]()
    var navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = BusNumbersViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func busStops(for busNumber: String) {
        let navigationController = UINavigationController()
        let busStopsCoordinator = BusStopsCoordinator(with: navigationController)
        busStopsCoordinator.start()
        //        let viewController = BusStopsViewController.instantiate()
        //        viewController.busNumber = busNumber
        //        viewController.coordinator = self
        //        navigationController.pushViewController(viewController, animated: true)
    }

    func showMessageUI(busStopCode forBusStopCode: String) {

    }
}
