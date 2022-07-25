//
//  HomeSection.swift
//  SwiftDemo
//
//  Created by Yang on 2022/7/1.
//

import Foundation
import RxDataSources

struct HomeSection<T> : SectionModelType{
    
    var items: [T]
    
    init(items: [T] = []) {
        self.items = items
    }
    init(original: HomeSection<T>, items: [T]) {
        self = original
        self.items = items
    }
    
}
