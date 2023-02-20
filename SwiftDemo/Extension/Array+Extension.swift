//
//  Array+Extension.swift
//  SwiftDemo
//
//  Created by Yang on 2022/11/24.
//

import Foundation

extension Array {
    
//    func indexValue(safe index: Index) -> Element {
//        return indices.contains(index) ? self[index]: nil
//    }
    
    mutating func appends(_ elements: [Element]){
        self.append(contentsOf: elements)
    }
    
//    func toJSON() -> String? {
//        let array = self
//        guard JSONSerialization.isValidJSONObject(array) else{
//            YYLog("无法解析出JSONString")
//            return ""
//        }
//    }
}

extension Array where Element: Equatable{
    func indexes(_ item: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<count where self[index] == item{
            indexes.append(index)
        }
        return indexes
    }
    func firstIndex(_ item: Element) -> Index? {
        for (index, value) in self.enumerated() where value == item {
            return index
        }
        return nil
    }
    func lastIndex(_ item: Element) -> Int? {
        let indexs = indexes(item)
        return indexs.last
    }
    
}

extension Array where Element :Equatable{
    
//    @discardableResult
//    mutating func remove(_ element: Element, isRepeat: Bool = true) -> Array{
//        var removeIndexs: [Int] = []
//        for i in 0..<count{
//            if self[i] == element{
//                removeIndexs.append(i)
//                if !isRepeat { break }
//            }
//        }
//        for index in removeIndexs.reversed() {
//            self.remove(at: index)
//        }
//    }
    
    @discardableResult
    mutating func removeArray(_ elements :[Element], isRepeat: Bool = true) -> Array {
        for element in elements{
            if self.contains(element){
                self.remove(element,isRepeat: true)
            }
        }
        return self
    }
    
}

