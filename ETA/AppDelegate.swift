//
//  AppDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        CoreDataManager.sharedManager.loadPreloadedDatabase(withName: "ETA")
        CoreDataManager.sharedManager.setModel(toName: "ETA")

        UINavigationBar.appearance().barTintColor = UIColor.AppColors.linen
        UINavigationBar.appearance().tintColor = UIColor.AppColors.navyBlue
        UINavigationBar.appearance().titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor(named: "Navy Blue") as Any]

        window = UIWindow()
        window?.makeKeyAndVisible()

        let mainViewController = MainViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController()
        navigationController.navigationBar.isTranslucent = false
        navigationController.viewControllers = [mainViewController]
        window?.rootViewController = navigationController

        return true
    }
}
