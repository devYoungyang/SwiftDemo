//
//  GoodsDetailViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/17.
//

import UIKit
import SwifterSwift
class GoodsDetailViewController: BaseViewController {

    var text: String?
//    grouped: 没有设置header/footer时，仍会显示默认高度值, plain:会隐藏header
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedSectionHeaderHeight = 0
//        tableView.estimatedSectionFooterHeight = 0
//        tableView.tableHeaderView = self.createHeaderView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    func createHeaderView() -> UIView {
        let title = UILabel.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 50))
        title.backgroundColor = .random
        title.text = "表头"
        return title
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "详情"
        self.gk_navBackgroundColor = UIColor.orange
    
        tableView.backgroundColor = .white
        self.view.addSubview(self.tableView)
         _ = self.tableView.sd_layout()
            .leftEqualToView(view)?
            .rightEqualToView(view)?
            .topSpaceToView(view,NavBarHeight)?
            .bottomSpaceToView(view,SafeBottomHeight)
        
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.green
//        UIColor(hex: "#4EEE94")
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

extension GoodsDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId")!
        cell.textLabel?.text = "HAHAHAHAHAHA"
        YYLog(indexPath.row)
        if indexPath.row == 0{
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 0.01
//    }
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0.01
//    }
}
