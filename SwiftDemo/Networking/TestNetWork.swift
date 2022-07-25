//
//  TestNetWork.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/19.
//
import HandyJSON
import SwiftyJSON
import Moya
import Alamofire
import Foundation

/**     不能被继承 */
final class TestNetWork: MoyaProvider<HttpRequest> {

    init() {
        super.init()
    }
    func requestWithTarget(_ target: Target, responseHandler:@escaping (_ data: [GoodsModel], _ error: Error?) -> Void ) {
        var array: [GoodsModel] = []
        var err: Error?
        self.request(target) { (response) in
            switch response {
                case let .success(response):
                    let json = JSON.init(response.data)
                    let res = JSONDeserializer<HomeModel<GoodsModel>>.deserializeFrom(json: json.description)!
                    array = res.dataArr!
                case let .failure(error):
                    err = error
            }
            responseHandler(array, err)
        }
    }
}
