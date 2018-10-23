//
//  AppDelegate.swift
//  ETA
//
//  Created by Pedro Remedios on 28/04/2017.
//  Copyright © 2017 Pedro Remedios. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //print(UIFont.familyNames);

        CoreDataManager.sharedManager.loadPreloadedDatabase(withName: "ETA")
        CoreDataManager.sharedManager.setModel(toName: "ETA")

        UINavigationBar.appearance().barTintColor = UIColor(named: "Linen")
        UINavigationBar.appearance().tintColor = UIColor(named: "Navy Blue")

        UINavigationBar.appearance().titleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor(named: "Navy Blue") as Any,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        window = UIWindow()
        window?.makeKeyAndVisible()

        window?.rootViewController = ETATabBarController()

        return true
    }
}
