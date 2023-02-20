//
//  NetWorking.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/15.
//
import HandyJSON
import Foundation
import Moya
import Alamofire
import RxSwift

var baseUrlConfig: BaseUrlType = .dev

enum BaseUrlType: String {
    case dev = "http://192.168.31.224"    /**     开发环境     */
    case pub = "pub.com"    /**     线上环境    */
    case local = "localhost"    /**     本地      */
}

struct EmptyModel: HandyJSON {
   
}

public struct BaseModel<T: HandyJSON>: HandyJSON {
    public typealias ModelType = T
    var code: Int?
    var message: String?
    var data: ModelType?
    var dataArr: [ModelType]?
    var isSuccess: Bool = false

    public init() { }

    mutating public func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.dataArr <-- "data"
        mapper <<<
          self.data <-- "data"
    }

    mutating public func didFinishMapping() {
        if code == 200 {
            isSuccess = true
        }
    }

}

public protocol BaseTargetType: TargetType {
    var parameters: [String: Any] { get }
}

extension BaseTargetType {
    public var task: Task {
        let encoding: ParameterEncoding = URLEncoding.default
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    public var method: Moya.Method {
        return .get
    }
    public var validationType: ValidationType {
        return .successCodes
    }
    public var stubBehavior: StubBehavior {
        return .never
    }
    public var sampleData: Data {
        return Data()
    }
    public var sampleResponse: EndpointSampleResponse {
        return .networkResponse(200, self.sampleData)
    }
    public var headers: [String: String]? {
        return [ : ]
    }
    public var baseURL: URL {
        return URL(string: baseUrlConfig.rawValue)!
    }

}

final class NetWorking<T: BaseTargetType>: MoyaProvider<T> {
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        configuration.requestCachePolicy = .useProtocolCachePolicy

//        let pathStr = "http://test123.cn.utools.club"
//        let domain = "http://test123.cn.utools.club"
//        let path: String = Bundle.main.path(forResource: pathStr, ofType: "cer") ?? ""
//        let certificationData = try? Data(contentsOf: URL(fileURLWithPath: path)) as CFData
//
//        let certificate = SecCertificateCreateWithData(nil, certificationData!)
//        let certificates: [SecCertificate] = [certificate!]

//        let trusPolicy = PinnedCertificatesTrustEvaluator(certificates: certificates, acceptSelfSignedCertificates: false, performDefaultValidation: true, validateHost: true)
//        let trustManager = ServerTrustManager(evaluators: [domain : trusPolicy])

//        let session = Alamofire.Session.init(configuration: configuration, delegate: SessionDelegate.init(), rootQueue: DispatchQueue.main,serverTrustManager: nil)
//
//        super.init(callbackQueue: DispatchQueue.main, session: session, plugins: [])
    }

    func request(_ target: T, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) -> Single<Response> {
        printLog("😀😀😀 beginRequest: \(target.baseURL)\(target.path) ---- \(target.method) --- \(target.parameters)")
        return self.rx.request(target).filterSuccessfulStatusCodes().do(onSuccess: {(response) in
            printLog("🥳🥳🥳 Success: \(response.statusCode)")
        }, onError: {(error) in
            let err = error as! MoyaError
            if let baseModel = err.response?.mapToModel(EmptyModel.self), baseModel.code == 401 {

            }
            printLog("☹️☹️☹️ Error: \(target.baseURL)\(target.path) ---- \(err.response?.statusCode ?? 0)")
        })
    }

}

extension ObservableType where Element == Response {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Observable<BaseModel<T>?> {
        return flatMap { (response) -> Observable<BaseModel<T>?> in
            return Observable.just(response.mapToModel(T.self))
        }
    }
}

extension Response {
    public func mapToModel<T: HandyJSON>(_ type: T.Type) -> BaseModel<T>? {
        let jsonString = String.init(data: data, encoding: .utf8)
        return JSONDeserializer<BaseModel<T>>.deserializeFrom(json: jsonString)
    }
}

extension Single where Element == Any {
    public func mapModel<T: HandyJSON>(_ type: T.Type) -> Single<BaseModel<T>?> {
        let obj = self.asObservable().flatMap { (data) -> Observable<BaseModel<T>?> in
            let json = data as! [String: Any]
            let response = JSONDeserializer<BaseModel<T>>.deserializeFrom(dict: json)
            return Observable.just(response)
        }
        return obj.asSingle()
    }
}

extension Single where Element == Response {
    public func mapToData<T: HandyJSON>(_ type: T.Type) -> Observable<BaseModel<T>?> {
        return self.asObservable().flatMap { (response) -> Observable<BaseModel<T>?> in
            return Observable.just(response.mapToModel(T.self))
        }
    }
}
