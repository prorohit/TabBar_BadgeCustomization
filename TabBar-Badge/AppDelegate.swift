//
//  AppDelegate.swift
//  TabBar-Badge
//
//  Created by Rohit.Singh on 03/02/17.
//  Copyright © 2017 Rohit.Singh. All rights reserved.
//

import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    var tabBarController : UITabBarController?
    
    var navTab1 : UINavigationController?
    var navTab2 : UINavigationController?
    var navTab3 : UINavigationController?
   


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setUpTabBarController()
        
        self.window?.rootViewController = self.tabBarController
        self.window?.makeKeyAndVisible();
        return true
    }
    
    func setUpTabBarController()  {
        
        self.tabBarController  = UITabBarController()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let viewCHome : Home = storyBoard.instantiateViewController(withIdentifier: "Home") as! Home

        // Here we have to use the option of "withRenderingMode", if we want to display the original colored  image
        let tabItem1 = UITabBarItem(title: "Home", image: UIImage(named: "first_normal"), selectedImage: UIImage(named: "first_selected")?.withRenderingMode(UIImageRenderingMode.alwaysOriginal))
        self.navTab1 = UINavigationController(rootViewController: viewCHome)
        self.navTab1?.tabBarItem = tabItem1
        
        // 62 119 281
        // Customization of the text color of the title lable of UITabBarItem
        
        let color = UIColor(red: 62/255.0, green: 219/255.0, blue: 181/255.0, alpha: 1)
        
        self.navTab1?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : color], for: UIControlState.selected)
        self.navTab1?.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : color], for: UIControlState.normal)
        self.tabBarController?.viewControllers = [self.navTab1!]
        
        self.tabBarController?.addBadgeWithSize(width: 24, height: 24, xOffset: 12, yOffset: 15, animationType: AnimationType.Push, isEnglish: true, index: 0, value: 10, color: UIColor.black, font: UIFont.systemFont(ofSize: 15))
        
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

}



