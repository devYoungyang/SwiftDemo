//
//  MineViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//
import RxDataSources
import NSObject_Rx
import Alamofire
import Moya
import RxCocoa
import RxSwift
import UIKit
import HandyJSON
import SwiftyJSON
import JXSegmentedView
import JXPagingView

extension JXPagingListContainerView: JXSegmentedViewListContainer {}

class MineViewController: BaseViewController {

//    var tableView: UITableView!
    var segmentedDataSource: JXSegmentedTitleDataSource!

    var segmentedView: JXSegmentedView!

    var headerView: TableViewHeaderView!

    var containerView: UIView!

    var pageView: JXPagingView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton(type: .custom)
        btn.setImage(ImageName("setting"), for: .normal)
        btn.rx.tap.subscribe(onNext: { _ in
            self.navigationController?.pushViewController(SettingViewController())
        }).disposed(by: rx.disposeBag)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        self.navigationItem.title = "个人中心"

        self.navigationController?.navigationBar.setBackgroundImage(ImageColor("#ffffff"), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        self.navigationController?.navigationBar.isTranslucent = false

        containerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        headerView = TableViewHeaderView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 200))
        containerView.addSubview(headerView)

        segmentedDataSource = JXSegmentedTitleDataSource()
        segmentedDataSource.titles = ["微博", "主页", "话题"]
        segmentedDataSource.isTitleZoomEnabled = true

        segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        segmentedView.backgroundColor = .white
        segmentedView.dataSource = segmentedDataSource

        pageView = JXPagingView(delegate: self)
        pageView.frame = self.view.bounds
        self.view.backgroundColor = .white
        self.view.addSubview(pageView)
        pageView.mainTableView.backgroundColor = .orange
        segmentedView.listContainer = pageView.listContainerView

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    }

}

extension MineViewController: JXPagingViewDelegate {

    func tableHeaderViewHeight(in pagingView: JXPagingView) -> Int {
        return 200
    }
    func tableHeaderView(in pagingView: JXPagingView) -> UIView {
        return containerView
    }
    func heightForPinSectionHeader(in pagingView: JXPagingView) -> Int {
        return 50
    }
    func viewForPinSectionHeader(in pagingView: JXPagingView) -> UIView {
        return segmentedView
    }
    func numberOfLists(in pagingView: JXPagingView) -> Int {
        return segmentedDataSource.titles.count
    }
    func pagingView(_ pagingView: JXPagingView, initListAtIndex index: Int) -> JXPagingViewListViewDelegate {
        let listVC = ListViewController()
        return listVC
    }
    func pagingView(_ pagingView: JXPagingView, mainTableViewDidScroll scrollView: UIScrollView) {
        headerView.scrollViewDidScroll(contentOffsetY: scrollView.contentOffset.y)
    }
}
