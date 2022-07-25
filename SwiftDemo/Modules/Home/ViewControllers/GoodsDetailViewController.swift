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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "详情"
        self.gk_navBackgroundColor = UIColor.orange
//        self.navigationController?.navigationBar.setBackgroundImage(ImageColor("#ffa400"), for: .default)
    
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
        return cell
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
}
