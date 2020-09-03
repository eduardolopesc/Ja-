//
//  AppDelegate.swift
//  MusiCorreria
//
//  Created by Eduardo Lopes de Carvalho on 27/08/20.
//  Copyright © 2020 Eduardo Lopes de Carvalho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    

    var auth = SPTAuth()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        auth.redirectURL = URL(string: "MusiCorreria://returnAfterLogin")
        auth.sessionUserDefaultsKey = "current session"
        return true
    }

    // MARK: UISceneSession Lifecycle
    
    
    // 1
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    //func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        // 2- check if app can handle redirect URL
//        print("aaaaaaaa")
//        if auth.canHandle(auth.redirectURL) {
//            // 3 - handle callback in closure
//            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
//                // 4- handle error
//                if error != nil {
//                    print("error!")
//                }
//                // 5- Add session to User Defaults
//                let userDefaults = UserDefaults.standard
//                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session)
//                print(sessionData)
//                userDefaults.set(sessionData, forKey: "SpotifySession")
//                userDefaults.synchronize()
//                // 6 - Tell notification center login is successful
//                NotificationCenter.default.post(name: Notification.Name(rawValue: "loginSuccessfull"), object: nil)
//            })
//            return true
//        }
       return false
    }
    
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

//    lazy var persistentContainer: NSPersistentCloudKitContainer = {
//        /*
//         The persistent container for the application. This implementation
//         creates and returns a container, having loaded the store for the
//         application to it. This property is optional since there are legitimate
//         error conditions that could cause the creation of the store to fail.
//        */
//        let container = NSPersistentCloudKitContainer(name: "MusiCorreria")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//
//                /*
//                 Typical reasons for an error here include:
//                 * The parent directory does not exist, cannot be created, or disallows writing.
//                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
//                 * The device is out of space.
//                 * The store could not be migrated to the current model version.
//                 Check the error message to determine what the actual problem was.
//                 */
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()

    // MARK: - Core Data Saving support

//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

}

