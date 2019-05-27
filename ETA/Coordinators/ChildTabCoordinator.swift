//
//  TabCoordinator.swift
//  ETA
//
//  Created by Pedro Remedios on 07/02/2019.
//  Copyright © 2019 Pedro Remedios. All rights reserved.
//

import Foundation
import UIKit

class BusesTabCoordinator: TabCoordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        let viewController = BusNumbersViewController.instantiate()
        navigationController.pushViewController(viewController, animated: true)
    }
}
