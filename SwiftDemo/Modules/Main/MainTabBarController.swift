//
//  MainTabBarController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//
import Starscream
import Tiercel
import Charts
import CryptoSwift
import ESTabBarController_swift
import YYKit
import UIKit
class MainTabBarController: ESTabBarController {

    enum TabBarItemTitle: String {
        case homePage = "首页"
        case found = "发现"
        case car = "购物车"
        case mine = "我的"
    }

    var needsLoginItems: [TabBarItemTitle] = [.mine]
    fileprivate var currentSelect: Int = -1
    fileprivate var lastSelectTime: TimeInterval?
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBar.backgroundColor = .white
        createController()
        // Do any additional setup after loading the view.
    }
    func addChildVC(viewcontroller: UIViewController, title: String, selectImage: String, unselectImage: String) {
        let tabBarItem = ESTabBarItem.init(TabBarItemContentView(), title: title, image: UIImage(named: unselectImage), selectedImage: UIImage(named: selectImage))
//        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
//        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], for: .selected)
        viewcontroller.tabBarItem = tabBarItem
        viewcontroller.navigationController?.title = title
        let nav = MainNavigationController.init(rootViewController: viewcontroller)
        if self.viewControllers == nil {
            self.viewControllers = [nav]
        } else {
            self.viewControllers?.append(nav)
        }
    }
    func createController() {
        self.delegate = self
        let homeVC = HomeViewController()
        let foundVC = FoundViewController()
        let mineVC = MineViewController()
        let carVC = ShoppingCarViewController()
        self.addChildVC(viewcontroller: homeVC, title: TabBarItemTitle.homePage.rawValue, selectImage: "home", unselectImage: "unhome")
        self.addChildVC(viewcontroller: foundVC, title: TabBarItemTitle.found.rawValue, selectImage: "d2", unselectImage: "d1")
        self.addChildVC(viewcontroller: carVC, title: TabBarItemTitle.car.rawValue, selectImage: "shopping2", unselectImage: "shopping1")
        self.addChildVC(viewcontroller: mineVC, title: TabBarItemTitle.mine.rawValue, selectImage: "mine", unselectImage: "unmine")

    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    func scrollToTop(_ viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController {
            let topViewController = navigationController.topViewController
            let firstViewController  = navigationController.viewControllers.first
            if let vc = topViewController, vc == firstViewController {
                print("当前控制器 ：\(vc)")
                switch type(of: vc) {
                case is HomeViewController.Type:
                    (vc as? BaseViewController)?.rxRefresh.onNext(Void())
//                    print("HomeViewController")
                case is FoundViewController.Type:
                    print("FoundViewController")
                case is MineViewController.Type:
                    print("MineViewController")
                default:
                    break
                }
            }
        }
        guard let scrollView = viewController.view.subviews.first as? UIScrollView else { return }
        scrollView.setContentOffset(.zero, animated: true)
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        if self.currentSelect == self.selectedIndex {
            let current = Date.init().timeIntervalSince1970
            if current - (lastSelectTime ?? 0) < 0.8 {
                self.scrollToTop(viewController)
            }
        }
        self.lastSelectTime = Date.init().timeIntervalSince1970
        self.currentSelect = self.selectedIndex
    }

}
