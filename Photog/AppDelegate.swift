//
//  AppDelegate.swift
//  Photog
//
//  Created by Khairul Akmal on 10/06/2015.
//  Copyright (c) 2015 Khairul Akmal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupParse()
        self.setupAppAppearance()
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        var navigationController = UINavigationController()
        var startViewController = StartViewController(nibName: "StartViewController", bundle: nil)
        // startViewController.view.backgroundColor = UIColor.yellowColor()
        
        if PFUser.currentUser() == nil {
            navigationController.viewControllers = [startViewController]
        }else {
            println("we have a user!")
            println("Sign in as \(PFUser.currentUser()?.username)")
            
            var tabBarController = TabBarController()
            navigationController.viewControllers = [startViewController, tabBarController]
        }
        
        self.window!.rootViewController = navigationController
        self.window!.makeKeyAndVisible()
        
        return true
    }
    
    func setupParse() {
        // Initialize Parse
        Parse.setApplicationId("JoWeA5Rb1iIZkUQs1qyB9R7dxvqEiBjztQQZvhrv",
                    clientKey: "HvUhbL8cHKvSMZ0HL0JhwDjO28YOtqRpf7pezfab")
    }
    
    func setupAppAppearance() {
        // Change the status bar to white
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // Change the navigation bar background
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        // Change the navigation bar item color e.g back button, or navigationbar item
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        // Change the text color of the navigation bar text title color
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBar.appearance().selectionIndicatorImage = UIImage(named: "selectedTabBackground")
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

