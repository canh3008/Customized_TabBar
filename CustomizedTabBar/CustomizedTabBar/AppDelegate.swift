//
//  AppDelegate.swift
//  CustomizedTabBar
//
//  Created by Duc Canh on 24/12/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = TabBarController(window: window)
        window?.rootViewController = UINavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
        return true
    }

}

