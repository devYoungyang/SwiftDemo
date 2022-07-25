//
//  NetWorkMonitoring.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/20.
//
import Reachability
import Foundation

final class NetWorkMonitoring {
    static let shareMonitoring = NetWorkMonitoring()

    var reachability: Reachability?

    private var noReachability: ((_ net: Bool) -> Void)?

    private init() {
        do {
            reachability = try? Reachability.init(hostname: "www.baidu.com")
        }
        self.startRun()
    }
    func startRun() {
        do {
            try reachability?.startNotifier()
        } catch {
            printLog("Unable to start notifier")
        }
    }
    func stopRun() {
        reachability?.stopNotifier()
    }
    var currentNetState: Reachability.Connection? {
        return reachability?.connection
    }
    func monitoring(noReachability:((_ net: Bool) -> Void)? = nil) {
        reachability?.whenReachable = {
            reachability in
            if reachability.connection == .wifi {
                printLog("WIFI")

            } else if reachability.connection == .cellular {
                printLog("移动网络")

            } else {
                printLog("NoNetWorking")

            }
            self.noReachability = noReachability

            if self.noReachability != nil {
                self.noReachability!(true)
            }
            return
        }
        reachability?.whenUnreachable = { _ in
            printLog("Not reachable")
            self.noReachability = noReachability

            if self.noReachability != nil {
                self.noReachability!(false)
            }
            return
        }
    }
}
