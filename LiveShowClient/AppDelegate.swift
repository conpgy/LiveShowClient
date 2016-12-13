//
//  AppDelegate.swift
//  LiveShowClient
//
//  Created by penggenyong on 16/12/12.
//  Copyright © 2016年 penggenyong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        setupRootWindowAndRootViewController()
        
        return true
    }


}

extension AppDelegate {
    func setupRootWindowAndRootViewController() -> Void {
        
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        let tabBarVc = UITabBarController(nibName: nil, bundle: nil)
        window?.rootViewController = tabBarVc
        
        let homeViewController = HomeViewController()
        let rankViewController = RankViewController()
        let discoverViewController = DiscoverViewController()
        let profileViewController = ProfileViewController()
        
        homeViewController.tabBarItem.image = UIImage(named: "live-p")
        homeViewController.tabBarItem.selectedImage = UIImage(named: "live-n")
        homeViewController.title = "首页"
        let homeNavigationController = BaseNavigationController(rootViewController: homeViewController)
        
        rankViewController.tabBarItem.image = UIImage(named: "ranking-p")
        rankViewController.tabBarItem.selectedImage = UIImage(named: "ranking-n")
        rankViewController.title = "排行"
        let rankNavigationController = BaseNavigationController(rootViewController: homeViewController)
        
        discoverViewController.tabBarItem.image = UIImage(named: "found-p")
        discoverViewController.tabBarItem.selectedImage = UIImage(named: "found-n")
        discoverViewController.title = "发现"
        let discoverNavigationController = BaseNavigationController(rootViewController: homeViewController)
        
        profileViewController.tabBarItem.image = UIImage(named: "mine-p")
        profileViewController.tabBarItem.selectedImage = UIImage(named: "mine-n")
        profileViewController.title = "我的"
        let profileNavigationController = BaseNavigationController(rootViewController: homeViewController)
        
        tabBarVc.viewControllers = [homeNavigationController,rankNavigationController,discoverNavigationController,profileNavigationController]
        
    }
    
    func addChildViewController() {
        
    }
}
