//
//  HomeApi.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/19.
//
import Moya
import Foundation

enum HomeApi {
    case getGoodsList
    case getGoodsDetail(goodsID: String)
}

extension HomeApi: BaseTargetType {
//    public var baseURL: URL {
//        switch self {
//        case .getGoodsList:
//            return URL(string: "http://test123.cn.utools.club")!
//        case .getGoodsDetail(goodsID: _):
//            return URL(string: "dsdsd")!
//        }
//    }
    var path: String {
        switch self {
        case .getGoodsList:
            return "/data.json"
        case .getGoodsDetail(goodsID: _):
            return "/api/v1/getGoodsDetail"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getGoodsList:
            return .get
        case .getGoodsDetail(goodsID: _):
            return .get
        }
    }
    var parameters: [String: Any] {
        var param: [String: Any] = [ : ]
        switch self {
        case .getGoodsList:
            break
        case .getGoodsDetail(goodsID: let goodsID):
        param["goodsID"] = goodsID

        }
        return param
    }
}
