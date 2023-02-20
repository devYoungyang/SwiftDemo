//
//  SwiftLearningController.swift
//  SwiftDemo
//
//  Created by Yang on 2022/7/26.
//

import UIKit

protocol pc {
    associatedtype T
    mutating func add(_ p: T)
}


class C0 { }
class C1: C0 { }
class C2: C0 { }

struct S {
    var p1: String = ""
    var p2: Int
}
extension S {
    func f() -> String {
        return p1 + String(p2)
    }
}

struct S3 {
    var p1: String
    /**  自定义类型中实现了 callAsFunction() 的话，该类型的值就可以直接调用。   */
    func callAsFunction() -> String {
        return "show \(p1)"
    }
}

class SwiftLearningController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title =  "SwiftDemo"
        view.backgroundColor = .random
        let a1 = [2,5,7,3,8,1]
        let a2 = a1.sorted { l, r in
            return l < r
        }
        YYLog(a2)
        let a3 = a1.sorted(by: {(l: Int , r: Int) -> Bool in
            return l > r
        })
        YYLog(a3)
        let a4 = a1.sorted(by: {
            $0 > $1
        })
        YYLog(a4)
        
        f6()
        f7()
        
        let a5 = ["A","B","C","D"]
        let a6 = a5.map{
            "\($0)1"
        }
        
        YYLog(a6)
        let a7 = a5.compactMap{
            "\($0)2"
        }
        YYLog(a7)
        
        let a8 = [1,2,4,6,7,9,8,3]
        let a9 = a8.filter {
            $0 > 5
        }
        YYLog(a9)
        
        YYLog(f8(from: "Beijing"))
        
        let a10 = a1.sorted {
            $0 > $1
        }
        
        YYLog(a10)
        
        
        f9(s: "HAHHA")
        
        YYLog(f10(s: ""))
        
        
    }
    
    func f10(s: String) -> String {
        guard s.isEmpty != true else {
            return  "string is empty"
        }
        return "string \(s) is not empty"
    }
    
    func f8(from hometown: String) -> String {
        return "Hi, i am come from \(hometown)"
    }
    
    /** 为参数设置默认值  */
    func f1(p1: String = "P1") -> String {
         return "p is\(p1)"
    }
    /** 函数作为参数*/
    func f2(fn: (String) -> String ,p1: String) -> String {
        return fn(p1)
    }
    /** 函数作为返回值*/
    func f3(p1: String) -> (String) -> String {
        return f1
    }
    func f4(s: String..., i: Int...){
        print(s)
        print(i)
    }
    /** 嵌套函数可以重载，嵌套函数可以在函数未声明之前调用他 */
    func f5(){
        nf5()
        func nf5(){
            print(" this is neste function")
        }
    }
    /**
        open :  在模块外可以调用金额继承
        public：在模块外不可继承，open只使用类和类成员
        internal：默认级别，模块内可跨源文件调用，模块外不可调用
        fileprivate：只能在源文件内访问
        private： 只能在所在的作用域内访问
     */
    
    enum E1: String, CaseIterable {
        case e1,e2 = "12"
    }
    enum E2{
        case e1([String])
        case e2(Int)
    }
    
    func f6(){
        let e1 = E2.e1(["one","two"])
        let e2 = E2.e2(3)
        switch e1 {
        case .e1(let array):
            print(array)
        case .e2(let int):
            print(int)
        }
        print(e2)
        
        struct S2: pc{
            typealias T = String
            var strs = [String]()
            mutating func add(_ p: String){
                strs.append(p)
            }
        }
    }
    
    func f7(){
        var a = [C0]()
        a.append(C1())
        a.append(C2())
        
        for e in a {
            if e is C1 {
                print("Type is C1")
            }else if e is C2 {
                print("Type is C2")
            }
            if let c1 = e as? C1 {
                print("As C1 \(c1)")
            }else if let c2 = e as? C2 {
                print("As C2 \(c2)")
            }
        }
        
        var s = S(p2: 1)
        s.p1 = "2"
        print(s.f())
        
        let e = E.three
        e.showRawValue()
        
        let s3 = S3(p1: "HAHA")
        print(s3())
        
    }
    
    enum E: String {
        case one , two ,three
        func showRawValue(){
            print(rawValue)
        }
    }
    /** static和class关键字修饰的方法类似 OC 的类方法。static 可以修饰存储属性，而 class 不能；class 修饰的方法可以继承，而 static 不能。在协议中需用 static 来修饰。
     */
    
    
    func f9(s: String?){
        if let s1 = s {
            YYLog("s1 is \(s1)")
        }else {
            YYLog("si is nothing")
        }
        let s2  = s ?? "nothing"
        YYLog("s2 is \(s2)")
        
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
