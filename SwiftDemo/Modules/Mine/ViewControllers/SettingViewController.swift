//
//  SettingViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/6/18.
//
import NSObject_Rx
import UIKit
import RxDataSources
import RxSwift

class SettingViewController: BaseViewController {
    let disposeBag = DisposeBag()
    var dataArr: NSMutableArray = NSMutableArray()
    let infoViewModel = InfoViewModel()
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        let arr = [InfoModel(title: "支付"),
                   InfoModel(title: "收藏"),
                   InfoModel(title: "消息通知"),
                   InfoModel(title: "通用"),
                   InfoModel(title: "隐私"),
                   InfoModel(title: "设置"),
                   InfoModel(title: "帮助与反馈"),
                   InfoModel(title: "关于")]
        Observable.just(arr).bind(to: tableView.rx.items(cellIdentifier: "cellId")) {_, model, cell in
            cell.textLabel?.text = model.title
        }.disposed(by: rx.disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            YYLog(indexPath.row)
        }).disposed(by: rx.disposeBag)

//        infoViewModel.infoArray.bind(to: tableView.rx.items(cellIdentifier: "cellId")){
//            row, model, cell in
//            cell.textLabel?.text = model.title
//            cell.textLabel?.textColor = .black
//            cell.accessoryType = .disclosureIndicator
//            cell.backgroundColor = .white
//            cell.selectionStyle = .none
//            print(model)
//        }.disposed(by: disposeBag)
//        tableView.rx.modelSelected(InfoModel.self).subscribe(onNext: {(model) in
//            print("点击了 \(model.title)")
//        }).disposed(by: disposeBag)
//        tableView.rx.itemDeselected.subscribe(onNext: { indexPath in
//            print("选中项的indexPath为: \(indexPath)")
//        }).disposed(by: disposeBag)

        /**使用自带的section*/
//        let items = Observable.just([SectionModel(model: "", items: [InfoModel(title: "支付"),
//                                                                     InfoModel(title: "收藏"),
//                                                                     InfoModel(title: "消息通知"),
//                                                                     InfoModel(title: "通用"),
//                                                                     InfoModel(title: "隐私"),
//                                                                     InfoModel(title: "设置"),
//                                                                     InfoModel(title: "帮助与反馈"),
//                                                                     InfoModel(title: "关于")])])

        /**使用自定义的section*/
//        let items = Observable.just([MySection(header: "分区头", items: [InfoModel(title: "支付"),
//                                                                   InfoModel(title: "收藏"),
//                                                                   InfoModel(title: "消息通知"),
//                                                                   InfoModel(title: "通用"),
//                                                                   InfoModel(title: "隐私"),
//                                                                   InfoModel(title: "设置"),
//                                                                   InfoModel(title: "帮助与反馈"),
//                                                                   InfoModel(title: "关于")])])
//        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(configureCell: {(ds, tv, index, item) in
//            let cell = tv.dequeueReusableCell(withIdentifier: "cellId")!
//            cell.textLabel?.text = item.title
//            cell.textLabel?.textColor = .black
//            cell.accessoryType = .disclosureIndicator
//            cell.backgroundColor = .white
//            cell.selectionStyle = .none
//            print(type(of: ds))
//            return cell
//        },titleForHeaderInSection: {(ds, index) in
//            return ds.sectionModels[index].header
//        })
//        print("\(type(of: dataSource))=========")
//        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
//        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)

        // Do any additional setup after loading the view.
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

struct InfoModel {
    let title: String
    init(title: String) {
        self.title = title
    }
}

struct MySection {
    var header: String
    var items: [Item]
}
extension MySection: SectionModelType {
    typealias Item = InfoModel

    var indentity: String {
        return header
    }
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }

}

struct InfoViewModel {
    let infoArray = Observable.just([
        InfoModel(title: "支付"),
        InfoModel(title: "收藏"),
        InfoModel(title: "消息通知"),
        InfoModel(title: "通用"),
        InfoModel(title: "隐私"),
        InfoModel(title: "设置"),
        InfoModel(title: "帮助与反馈"),
        InfoModel(title: "关于")
    ])
}

extension InfoModel: CustomStringConvertible {
    var description: String {
        return "name==\(title)"
    }
}

extension SettingViewController: UITableViewDelegate {

    func setUpUI() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        _ = tableView.sd_layout()
            .topEqualToView(view)?
            .leftEqualToView(view)?
            .rightEqualToView(view)?
            .bottomEqualToView(view)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenHeight, height: 0.01))
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
