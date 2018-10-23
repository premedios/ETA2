//
//  ETATabBarController.swift
//  ETA
//
//  Created by Pedro Remedios on 20/05/2018.
//  Copyright © 2018 Pedro Remedios. All rights reserved.
//

import UIKit

class ETATabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainNavigationController = UINavigationController(rootViewController: MainViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        //        navigationController.navigationBar.isTranslucent = false
        mainNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Buses_NotSelected")
        mainNavigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Buses_Selected")
        mainNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        let favouritesNavigationController = UINavigationController(rootViewController: BusStopFavouritesViewController(collectionViewLayout: UICollectionViewFlowLayout()))
        favouritesNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Favourites_NotSelected")
        favouritesNavigationController.tabBarItem.selectedImage = #imageLiteral(resourceName: "Favourites_Selected")
        favouritesNavigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        tabBar.tintColor = UIColor(named: "Navy Blue")
        tabBar.unselectedItemTintColor = UIColor(named: "Light Navy Blue");
        tabBar.barTintColor = UIColor(named: "Linen");
        viewControllers = [mainNavigationController, favouritesNavigationController]
    }
}
