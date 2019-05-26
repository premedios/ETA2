//
//  AppDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //print(UIFont.familyNames);

        DatabaseController.loadPreloadedDatabase(with: "ETA")

        UINavigationBar.appearance().barTintColor = UIColor(named: "Linen")
        UINavigationBar.appearance().tintColor = UIColor(named: "Navy Blue")

        UINavigationBar.appearance().titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor(named: "Navy Blue") as Any,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]

        let navigationController = UINavigationController()
        let mainCoordinator = MainCoordinator(with: navigationController)
        mainCoordinator.start()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        window?.rootViewController = navigationController

        return true
    }
}
