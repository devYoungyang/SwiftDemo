//
//  ViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white

        let p = Person.init(name: "", age: 16)
        p?.address = ""
//        p?.isMan
    }

}
