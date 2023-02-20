//
//  LambdaViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2022/7/27.
//

import UIKit

class LambdaViewController: UIViewController {

    struct Point {
        var x = 0.0
        var y = 0.0
    }
    struct Size {
        var width = 0.0
        var height = 0.0
    }
    struct Rect {
        var origin = Point()
        var size = Size()
        var center: Point {  //  计算型属性
            get {
                let centerX = origin.x + size.width/2
                let centerY = origin.y + size.height/2
                return Point(x: centerX, y: centerY)
            }
            set {
                origin.x = newValue.x - size.width/2
                origin.y = newValue.y - size.height/2
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        navigationItem.title = " Lambda"
        
        
        let a1 = [4,2,7,1,9,3]
        let a2 = a1.sorted(by: { s1,s2 in
            return s1 > s2
        })
        print(a2)
        
        someFunctionThatTakesAClosure {
            
        }
        
        
//        var square = Rect(origin: Point(x: 0.0, y: 0.0),size: Size(width: 10.0, height: 10.0))
        
        
    }
    func someFunctionThatTakesAClosure(closure: () -> Void ){
        
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
