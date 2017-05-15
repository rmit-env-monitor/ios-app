//
//  AppDelegate.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import OpenSansSwift
import GooglePlaces


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UIApplication.shared.statusBarStyle = .lightContent
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = navigationBarTintColor
        appearance.barTintColor = UIColor.black
        _ = OpenSans.registerFonts()
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(r: 201, g: 251, b: 82), NSFontAttributeName : UIFont.openSansSemiboldFontOfSize(18)]
        
        GMSPlacesClient.provideAPIKey(geocodingAPIKey)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        
     
        window?.makeKeyAndVisible()

        if let dictionary = Client.userDefaults.dictionary(forKey: currentUserKey), Client.userDefaults.object(forKey: locationMethodKey) != nil {
            Client.currentUser = User(dictionary: dictionary as [String : AnyObject])
            window?.rootViewController = EsTabBarController.sharedInstance.open()
        }
        else {
            let loginController = LoginController()
            window?.rootViewController = loginController

        }
        
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
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: backFromSetting), object: nil)
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

