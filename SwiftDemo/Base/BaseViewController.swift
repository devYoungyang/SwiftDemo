//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/17.
//
import RxSwift
import GKNavigationBarSwift
import UIKit

class BaseViewController: UIViewController, RefreshViewControllerProtocol {

    func hasHeaderRefresh() -> Bool {
        return false
    }

    func hasFooterRefresh() -> Bool {
        return false
    }

    func retryNewData() {
        self.setNetWorkMonitoring()
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.gk_navLineHidden
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.gk_statusBarStyle
    }
//
    var rxRefresh = PublishSubject<Void>()

    var scrollViewOriginalContentInsetAdjustmentBehaviorRawValue: Int?

    var titleEmpty: String?

    var descEmpty: String?

    func refreshNetworking(operation: Operation) {

    }
    /**如果有下拉刷新需重写这个方法*/
    func scrollViewInstance() -> UIScrollView? {
        //        fatalError("scrollView 子类实现")
        return nil
    }
    
    var navigationBarBackgroundColor: String? {
        return "#ffffff"
    }
    
    func customBackBarButton () {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(ImageName("nav_back_black_icon"), for: .normal)
        backBtn.rx.tap.subscribe(onNext: { _ in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
    }
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        navigationController?.navigationBar.barTintColor = UIColor(hex: navigationBarBackgroundColor!)
//        navigationController?.navigationBar.setBackgroundImage(ImageColor(navigationBarBackgroundColor!), for: .default)
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hexString: "#353535")!]
        
    
        
        
        if (self.navigationController?.viewControllers.count)! > 1 {
            customBackBarButton()
        }
        self.setNetWorkMonitoring()
        guard let scrollView = self.scrollViewInstance() else {
            return
        }
        if #available(iOS 11, *) {
            self.scrollViewOriginalContentInsetAdjustmentBehaviorRawValue =
                scrollView.contentInsetAdjustmentBehavior.rawValue
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        scrollView.emptyDataSetSource = self
        scrollView.emptyDataSetDelegate = self
        scrollView.reloadEmptyDataSet()
        if hasHeaderRefresh() {
            scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                self.refreshNetworking(operation: .refresh)
            })
        }
        if hasFooterRefresh() {
            scrollView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
                self.refreshNetworking(operation: .more)
            })
        }
        rxRefresh.subscribe(onNext: { _ in
            self.scrollViewInstance()?.mj_header?.beginRefreshing()
        }).disposed(by: rx.disposeBag)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    func setNetWorkMonitoring() {
        if let netState = NetWorkMonitoring.shareMonitoring.currentNetState, netState == .unavailable {
            self.titleEmpty = "网络不可用"
            self.descEmpty = "请检查网络后重试"
        } else {
            self.titleEmpty = "暂无数据"
            self.descEmpty = "请点击重试"
        }
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

extension BaseViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSMutableAttributedString(string: self.titleEmpty!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
    }
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSMutableAttributedString(string: self.descEmpty!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24)])
    }
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        rxRefresh.onNext(Void())
    }
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return nil
    }
}
