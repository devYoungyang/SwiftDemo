//
//  ListViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/6/18.
//
import JXPagingView
import UIKit

class ListViewController: UIViewController {

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.view.backgroundColor = .random

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

extension ListViewController: JXPagingViewListViewDelegate {

    func listScrollView() -> UIScrollView {
        return self.tableView
    }

    func listViewDidScrollCallback(callback: @escaping (UIScrollView) -> Void) {

    }

    func listView() -> UIView {
        return self.view
    }

}
