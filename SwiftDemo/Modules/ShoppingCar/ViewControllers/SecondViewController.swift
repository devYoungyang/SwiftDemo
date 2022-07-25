//
//  SecondViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/8/9.
//
import RSKPlaceholderTextView
import UIKit

class SecondViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let inputTextfield = RSKPlaceholderTextView()
        self.view.addSubview(inputTextfield)
        inputTextfield.sd_layout()
            .centerXEqualTo(self.view)
            .centerYEqualTo(self.view)
            .width(is: 200)
            .height(is: 80)
        inputTextfield.placeholder = "HAHAH"
        inputTextfield.borderColor = .orange
        inputTextfield.borderWidth = 1
        
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
