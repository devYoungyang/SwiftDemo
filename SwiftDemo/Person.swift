//
//  Person.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//

import UIKit

// class Person: NSObject {
//    var name: String?
//    var age: Int {
//        return 20
//    }
//    override init() {
//
//    }
// }

class Person: NSObject, BaseProtocol {

    var isMan: Bool {
        return false
    }

    var address: String {
        get {
            return String.init("上海")
        }
        set{
            
        }
    }
//    class var weight: Float
//    static var height: Float
    
    var name: String
    var age: Int
    init?(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    func say() {

    }
}

class Student<T: Person>: Person {

}
