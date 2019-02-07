//
//  AppDelegate.swift
//  secureCryptographicAlgorithms
//
//  Created by Przemyslaw Biskup on 04/02/2019.
//  Copyright © 2019 Przemyslaw Biskup. All rights reserved.
//

import UIKit
import Security

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let vc = MenuViewController()
        let nc = UINavigationController()
        nc.viewControllers = [vc]
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }
}
