//
//  MainNavigationController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/19.
//

import UIKit

class MainNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
        
//        UINavigationBar.appearance().tintColor = .red
//        self.navigationBar.setBackgroundImage(ImageColor("#4EEE94"), for: .default)
//        self.navigationBar.shadowImage = UIImage()
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: HexStringColor("#353535")!]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
//            self.interactivePopGestureRecognizer?.isEnabled = true
//            let backBtn = UIButton(type: .custom)
//            backBtn.setImage(ImageName("nav_back_black_icon"), for: .normal)
//            backBtn.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 44, height: 44))
//            backBtn.rx.tap.subscribe { _ in
//                YYLog("HAHHAHAH")
//                self.popViewController(animated: true)
//            }.disposed(by: rx.disposeBag)
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
