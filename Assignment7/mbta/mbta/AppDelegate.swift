//
//  AppDelegate.swift
//  mbta
//
//  Created by Krishna Vikas on 3/20/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let storyboard = UIStoryboard(name: "train", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "EntryViewController")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationBarSecond = UINavigationController(rootViewController: initialViewController)
        window?.rootViewController = navigationBarSecond
        window?.makeKeyAndVisible()
        return true
    }



}

