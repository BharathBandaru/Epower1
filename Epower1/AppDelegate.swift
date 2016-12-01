//
//  AppDelegate.swift
//  Epower1
//
//  Created by Bharath Bandaru on 08/11/16.
//  Copyright © 2016 Minimark. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 2);
//        // Override point for customization after application launch.
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.white], for: .normal)
//        
//        UITabBar.appearance().tintColor = UIColor(red: 246/255, green: 78/255, blue: 10/255, alpha: 1.0)
//        self.window?.tintColor = UIColor(red: 246/255, green: 78/255, blue: 10/255, alpha: 1.0)
//        // UINavigationBar.appearance().barTintColor = UIColor(red: 59/255, green: 31/255, blue: 127/255, alpha: 1.0)
//        UIToolbar.appearance().barTintColor = UIColor(red: 204/255, green: 04/255, blue: 204/255, alpha: 1.0)
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().barTintColor = UIColorFromRGB(rgbValue: 0x1A3D54)
        //UIToolbar.appearance().barTintColor = UIColor.white
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}

