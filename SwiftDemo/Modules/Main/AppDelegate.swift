//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//
import ESTabBarController_swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        self.window?.backgroundColor = .white

//        UINavigationBar.appearance().barTintColor = UIColor.green
//        UINavigationBar.appearance().tintColor = UIColor.red
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.orange]
        return true
    }

}

extension AppDelegate{
    func createRootViewController() -> MainNavigationController {
        let tabBarController = ESTabBarController()
        let homeVC = HomeViewController()
        let foundVC = FoundViewController()
        let carVC = ShoppingCarViewController()
        let mineVC = MineViewController()
        homeVC.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "首页", image: UIImage(named: "unhome"), selectedImage: UIImage(named: "home"))
        foundVC.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "发现", image: UIImage(named: "d1"), selectedImage: UIImage(named: "d2"))
        carVC.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "购物车", image: UIImage(named: "shopping1"), selectedImage: UIImage(named: "shopping2"))
        mineVC.tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: "我的", image: UIImage(named: "unmine"), selectedImage: UIImage(named: "mine"))
        tabBarController.viewControllers = [homeVC,foundVC,carVC,mineVC]
        
        let navigationController = MainNavigationController.init(rootViewController: tabBarController)
        return navigationController
    }
}
