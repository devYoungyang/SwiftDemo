//
//  GoodsSection.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/8.
//
import RxDataSources
import ReactorKit
import UIKit

struct GoodsSection<T>: SectionModelType {
    var items: [T]

    init(items: [T] = []) {
        self.items = items
    }

    init(original: GoodsSection, items: [T]) {
        self = original
        self.items = items
    }

}
