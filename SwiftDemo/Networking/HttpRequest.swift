//
//  HttpRequest.swift
//  SwiftDemo
//
//  Created by Yang on 2021/3/8.
//

import Moya
public enum HttpRequest {

    case getHomeListData

    case getSceneListData

    case getRoomListData

    case testApi

    case apiWithParameters(pid: String)

}

extension HttpRequest: TargetType {

    public var baseURL: URL {
        switch self {
        case .testApi:
            return URL(string: "http://test123.cn.utools.club")!
        case .apiWithParameters(pid: _):
            return URL(string: "dsdsd")!
        default:
            return URL(string: "https://api.pl-mi.com")!
        }

    }

    public var path: String {
        switch self {
        case .testApi:
            return "/data.json"
        case .getHomeListData:
            return "/v2/home/list"
        case .getSceneListData:
            return "/v2/scene/list"
        case .getRoomListData:
            return "/v2/room/list"
        case .apiWithParameters(pid: _):
            return "/dsds"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .testApi:
            return .get
        case .getHomeListData:
            return .get
        case .getSceneListData:
            return .get
        default:
            return .get
        }
    }

    public var sampleData: Data {
        return Data()
    }

    public var task: Task {
        switch self {
        case .getHomeListData:
            return .requestParameters(parameters: ["accessToken": "V3_v0TikolhrJZLlgVhBN-dOfhbEH6nBrSbVbKU8750yZtJVEzcX_vJZugLLaLB4z_YaShLtlfOehy_BZCxUNvk8pfTDfxKOeW3XMDhnMs1cI0LX4FBqp1RY7HVusRdWwKc"], encoding: URLEncoding.default)
        case .getSceneListData:
            return .requestParameters(parameters: ["": ""], encoding: URLEncoding.default)
        case .testApi:
            return .requestPlain
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .getHomeListData:
            return ["User-Id": "1434926611", "Accept": "application/json"]
        default:
            return ["Accept": "application/json"]
        }
//        return ["Accept" : "application/json"]
    }

//    public var validationType: ValidationType {
//        switch self {
//        case .getHomeListData:
//            return .successAndRedirectCodes
//        case .getSceneListData:
//            return .successAndRedirectCodes
//        default:
//            return .none
//        }
//    }
}

class YYNetWorking: MoyaProvider<HttpRequest> {
    static let `default` = YYNetWorking()

    func getHome() {
        self.request(.apiWithParameters(pid: "pid")) { (_) in

        }
    }

}
