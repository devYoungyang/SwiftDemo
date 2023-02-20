//
//  HomeViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//
import HealthKit

import SwifterSwift
import RxViewController
import ReactorKit
import NSObject_Rx
import RxSwift
import RxCocoa
import RxDataSources
import SwiftyJSON
import HandyJSON
import Moya
import Alamofire
import UIKit
import Toast_Swift
import SnapKit

class HomeViewController: BaseViewController, UITableViewDelegate, View {
    var dataArr: [GoodsModel] = []
    var disposeBag = DisposeBag()
//    lazy var ds: RxTableViewSectionedReloadDataSource<GoodsSection<GoodsModel>> = {
//        let ds = RxTableViewSectionedReloadDataSource<GoodsSection<GoodsModel>>(configureCell: {(dataSource, tableView, indexPath, item) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! NewsCell
//            cell.reactor = GoodsReactor(model: item)
//            return cell
//        })
//        return ds
//    }()
    
    var dataSource: RxTableViewSectionedReloadDataSource<GoodsSection<GoodsModel>>?
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
//        tableView.estimatedRowHeight = 0
        tableView.register(GoodsTableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        view.addSubview(tableView)
        self.gk_navBackgroundColor = .red
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
//        tableView.snp.makeConstraints { make in
//            make.left.equalTo(view)
//            make.top.equalTo(view)
//            make.right.equalTo(view)
//            make.bottom.equalTo(view).offset(-SafeBottomHeight-44)
//        }
        
        _ = tableView.sd_layout()
            .leftEqualToView(view)?
            .rightEqualToView(view)?
            .topSpaceToView(view, NavBarHeight)?
            .bottomSpaceToView(view, SafeBottomHeight + 44)
        
        self.dataSource = RxTableViewSectionedReloadDataSource(configureCell: {(_, tv, _, item) in
            YYLog(item)
            let cell = tv.dequeueReusableCell(withIdentifier: "cellId") as! GoodsTableViewCell
            cell.backgroundColor = .white
            cell.selectionStyle = .none
            cell.reactor = GoodsReactor(model: item)
            return cell
        })
        self.reactor = HomeReactor()
        
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(ImageName("add"), for: .normal)
        addBtn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: addBtn)
    }
    override func hasHeaderRefresh() -> Bool {
        return true
    }
    override func hasFooterRefresh() -> Bool {
        return true
    }
    override func scrollViewInstance() -> UIScrollView? {
        return self.tableView
    }
    override func refreshNetworking(operation: Operation) {
        self.reactor?.action.onNext(.getGoodsList(operation))
    }
    @objc func btnClicked() {
//        let webVC = WebViewController()
//        webVC.url = "https://www.baidu.com"
        let goodsVC = GoodsDetailViewController()
        goodsVC.text = "详情"
        self.navigationController?.pushViewController(LambdaViewController())
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(GoodsDetailViewController.init())
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
}

extension HomeViewController {
    func bind(reactor: HomeReactor) {
        rx.viewDidLoad.subscribe(onNext: {
            print("+++___viewDidLoad___+++")

        }).disposed(by: disposeBag)
        rx.viewWillAppear.subscribe(onNext: { _ in
            reactor.action.onNext(.getGoodsList(.refresh))
           
        }).disposed(by: disposeBag)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        reactor.state.map { $0.goods }.bind(to: tableView.rx.items(dataSource: dataSource!)).disposed(by: disposeBag)
        reactor.state.map { $0.refreshState }.subscribe(onNext: { _ in
            self.tableView.mj_header?.endRefreshing()
            self.tableView.mj_footer?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

/*
extension UITableView {
    public enum Style : Int {
        
        case plan = 0
        
        case group = 1
        
        @available(iOS 13.0, *)
        case insetGroup = 2
    }
    
    public enum ScrollPosition : Int {
        
        case none = 0
        
        case top = 1
        
        case middle = 2
        
        case bottom = 3
        
    }
    
    public enum RowAnimation : Int {
        
        case fade = 0
        
        case right = 1
        
        case left = 2
        
        case top = 3
        
        case bottom = 4
        
        case none = 5
        
        case middle = 6
        
        case automaitc = 100
        
    }
    
    @available(iOS 3.0, *)
    public class let indexSearch: String
    
    @available(iOS 5.0, *)
    public class let automaticDimension: CFloat
    
    public class let selectionDidChangeNotification: NSNotification.Name
    
    @available(iOS 11.0, *)
    public enum SeparatorInsetReference : Int {
        
        case fromCellEdges = 0
        
        case fromAutomaticInsets = 1
        
    }
    
    public protocol UITableViewDelegate : UIScrollViewDelegate {
        
        optional func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowat indexPath: NSIndexPath)
        
        optional func tableView(_tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
        
        optional func tableView(_ tableView: UITableView, heightForRowAt indexPath: NSIndexPath) -> CGFloat
        
        optional func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
        
        optional func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
        
        optional func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
        
        optional func tableView(_ tableView: UITableView, didSelectRowAt indexPath: NSIndexPath)
        
        
    }
    
    @available(iOS 2.0, *)
    open class UITableView: UIScrollView, NSCoding, UIDataSourceTranslating {
        public init(frame: CGRect, style: UITableView.Style)
        
        public init?(coder: NSCoder)
        
//        open var style: UITableView.Style { get }
        
        
        
    }
    
    
}
**/
