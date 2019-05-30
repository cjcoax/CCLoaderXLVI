//
//  AppDelegate.swift
//  LoaderXLVI
//
//  Created by Amir REZVANI on 5/28/19.
//  Copyright © 2019 Amir REZVANI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

