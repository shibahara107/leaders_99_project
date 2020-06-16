//
//  AppDelegate.swift
//  leaders_99_project
//
//  Created by Yoshinori Shibahara on 2020/05/19.
//  Copyright © 2020 Yoshinori Shibahara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var backgroundImageString: String!
    var frameImageString: String!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH"
        
        let currentTime = dateFormatter.string(from: date)
                
        if Int(currentTime) ?? 12 == 03 || Int(currentTime) ?? 12 == 04 || Int(currentTime) ?? 12 == 05 || Int(currentTime) ?? 12 == 06 {
            backgroundImageString = "Artboard 27 copy 3.png"
            frameImageString = "Artboard 13.png"
            print("Good morning")
            
        } else if Int(currentTime) ?? 12 == 07 || Int(currentTime) ?? 12 == 08 || Int(currentTime) ?? 12 == 09 || Int(currentTime) ?? 12 == 10 || Int(currentTime) ?? 12 == 11 || Int(currentTime) ?? 12 == 12 || Int(currentTime) ?? 12 == 13 || Int(currentTime) ?? 12 == 14 || Int(currentTime) ?? 12 == 15 {
            backgroundImageString = "Artboard 27 copy 2.png"
            frameImageString = "Artboard 15.png"
            print("Hello")
            
        } else if Int(currentTime) ?? 12 == 16 || Int(currentTime) ?? 12 == 17 || Int(currentTime) ?? 12 == 18 {
            backgroundImageString = "Artboard 27(1).png"
            frameImageString = "Artboard 12.png"
            print("Sunset")
            
        } else if Int(currentTime) ?? 12 == 19 || Int(currentTime) ?? 12 == 20 || Int(currentTime) ?? 12 == 21 || Int(currentTime) ?? 12 == 22 || Int(currentTime) ?? 12 == 23 || Int(currentTime) ?? 12 == 24 || Int(currentTime) ?? 12 == 01 || Int(currentTime) ?? 12 == 02 {
            backgroundImageString = "Artboard 27 copy.png"
            frameImageString = "Artboard 14.png"
            print("Good night")
            
        }
        
        if Auth.auth().currentUser != nil {
            let currentUserID = Auth.auth().currentUser?.uid
            let currentUserEmail = Auth.auth().currentUser?.email
            print("Logged In")
            print(currentUserEmail!)
            print(currentUserID!)
            
            //            self.window = UIWindow(frame: UIScreen.main.bounds)
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //            let initialViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
            //            self.window?.rootViewController = initialViewController
            //            self.window?.makeKeyAndVisible()
            
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
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
    
    
}

