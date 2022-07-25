//
//  HomeModel.swift
//  SwiftDemo
//
//  Created by Yang on 2021/3/9.
//
import HandyJSON
import UIKit

class HomeModel<T: HandyJSON>: HandyJSON {
    typealias ModelType = T

    var acode: Int?

    var dataArr: [ModelType]?

    required init() {}

    func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.dataArr <-- "data"
        mapper <<<
            self.acode <-- "code"
    }

}

class GoodsModel: HandyJSON {

    var productName: String!

    var weight: String!

    var price: String!

    required init() {}

}
