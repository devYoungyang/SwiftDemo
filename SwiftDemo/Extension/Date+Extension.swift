//
//  Date+Extension.swift
//  SwiftDemo
//
//  Created by Yang on 2022/11/24.
//

import Foundation

extension Date {
    static var secondStamp: String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        return "\(Int(timeInterval))"
    }
    static var currentDate: Date {
        return Date()
    }
    
    var year: Int {
        return Calendar.current.component(Calendar.Component.year, from: Date())
    }
    
    var month: Int {
        return Calendar.current.component(Calendar.Component.month, from: Date())
    }
    var hour: Int {
        return Calendar.current.component(.hour, from: Date())
    }
    
}
