//
//  AppDelegate.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/15/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func isUserLoggedIn() -> Bool{
        if Auth.auth().currentUser != nil {
            print("user present already")
            return true;
        }else{
            print("user not present")
        }
        return false;
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let storyboard = UIStoryboard(name: "Tracker", bundle: nil)
        FirebaseApp.configure()
        var identifier = ""
        if isUserLoggedIn(){
            let sb = UIStoryboard(name: "HomePage", bundle: nil)
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().tintColor = .red
            
                  let initialViewController = sb.instantiateViewController(withIdentifier: "HomePageVC")
                   
                   window = UIWindow(frame: UIScreen.main.bounds)
                   
                   let navigationBarSecond = UINavigationController(rootViewController: initialViewController)
                   window?.rootViewController = navigationBarSecond
                   window?.makeKeyAndVisible()
            
            
            
           // identifier = "HomeViewController"
        }else{
            identifier = "FirstViewController"
            let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier)
                   
                   window = UIWindow(frame: UIScreen.main.bounds)
                   
                   let navigationBarSecond = UINavigationController(rootViewController: initialViewController)
                   window?.rootViewController = navigationBarSecond
                   window?.makeKeyAndVisible()
        }
        
       
        
        return true
    }
    
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

