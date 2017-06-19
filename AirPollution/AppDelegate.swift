//
//  AppDelegate.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 3/4/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import UIKit
import GooglePlaces
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Configure Firebase
        FirebaseApp.configure()
        
        //Configure UINavigationBar for the whole app
        UIApplication.shared.statusBarStyle = .lightContent
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = navigationBarTintColor
        appearance.barTintColor = UIColor.black
        appearance.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.init(r: 201, g: 251, b: 82), NSFontAttributeName : UIFont.getFutura(fontSize: 18)]
        
        //Configure API Key for Google Places SDK
        GMSPlacesClient.provideAPIKey(geocodingAPIKey)
        
        //Initialize UIWindows for the App
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        //Configure the root view controller
        if let dictionary = userDefaults.dictionary(forKey: currentUserKey), userDefaults.object(forKey: locationMethodKey) != nil {
            Client.currentUser = User(dictionary: dictionary as [String : AnyObject])
            window?.rootViewController = EsTabBarController.sharedInstance.open()
        }
        else {
            let loginController = LoginController()
            window?.rootViewController = loginController
            
        }
        
        //Configure the icon badge number
        application.applicationIconBadgeNumber = 0
        
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
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: backFromSetting), object: nil)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        // With swizzling disabled you must set the APNs token here.
        // Messaging.messaging().apnsToken = deviceToken

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Opening the app because user clicks push notification")
        //open specific view here
        EsTabBarController.sharedInstance.selectedIndex = 2
    }
    
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
}

