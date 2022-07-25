//
//  DetailViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2022/7/1.
//
import RxSwift
import RxDataSources
import UIKit


class DetailViewController: BaseViewController,UITableViewDelegate {

    var dataSources: RxTableViewSectionedReloadDataSource<HomeSection<DetailModel>>?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight), style: .grouped)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.dataSources = RxTableViewSectionedReloadDataSource(configureCell: { (ds, tableView, indexPath, item) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
            cell.textLabel?.text = item.title
            return cell
        })
        
        self.gk_navBackgroundColor = UIColor.random
        
        
        let p = DetailModel()
        p.title = "111"
        let section = HomeSection(items: [p,p,p,p,p])
        
        Observable.just([section]).bind(to: tableView.rx.items(dataSource: self.dataSources!)).disposed(by: rx.disposeBag)
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
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
