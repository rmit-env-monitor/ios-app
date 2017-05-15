//
//  TabBarController.swift
//  AirPollution
//
//  Created by Nguyen Duc Gia Bao on 4/18/17.
//  Copyright © 2017 Nguyen Duc Gia Bao. All rights reserved.
//

import Foundation
import ESTabBarController_swift

class EsTabBarController : NSObject {
    
    static let sharedInstance = EsTabBarController()
    
    var tabBarController = ESTabBarController()
    
    
    func open() -> ESTabBarController {
        let v4 = UIViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let smartDashBoardVC = storyboard.instantiateViewController(withIdentifier: SmartDashBoardVCStoryBoardID) as? SmartDashBoardController
        
        let fullDashBoardVC = storyboard.instantiateViewController(withIdentifier: FullDashBoardVCStoryBoardID) as? FullDashBoardController
        
        
        let mapVC = storyboard.instantiateViewController(withIdentifier: MapVCStoryBoardID) as?
        MapViewController
        
        if let tabBar = EsTabBarController.sharedInstance.tabBarController.tabBar as? ESTabBar {
            tabBar.itemCustomPositioning = .fillIncludeSeparator
            tabBar.backgroundColor = UIColor.black
        }
        let smartDashBoardNC = UINavigationController(rootViewController: smartDashBoardVC!)
        
        let fullDashBoardNC = UINavigationController(rootViewController: fullDashBoardVC!)
        
        let mapNC = UINavigationController(rootViewController: mapVC!)
        
        
        
        smartDashBoardNC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"), tag: 1)
        fullDashBoardNC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "All Sensors", image: UIImage(named: "currentlocation"), selectedImage: UIImage(named: "currentlocation"), tag: 2)
        mapNC.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Map", image: UIImage(named: "routing"), selectedImage: UIImage(named: "routing"), tag: 3)
        v4.tabBarItem = ESTabBarItem.init(CustomTabBarContentView(), title: "Setting", image: UIImage(named: "setting"), selectedImage: UIImage(named: "setting"), tag: 4)
        
        EsTabBarController.sharedInstance.tabBarController.viewControllers = [smartDashBoardNC,fullDashBoardNC,mapNC,v4]
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTabBarControllerWhenLoggedOut), name: Notification.Name("handleTabBarControllerWhenLoggedOut"), object: nil)
        return EsTabBarController.sharedInstance.tabBarController
    }
    
    func handleTabBarControllerWhenLoggedOut() {
        EsTabBarController.sharedInstance.tabBarController.dismiss(animated: true, completion: nil)
        let loginController = UIApplication.shared.keyWindow?.rootViewController as! LoginController
        loginController.nameTextField.text = ""
        loginController.pwTextField.text = ""
        
    }
    
    
    
}
