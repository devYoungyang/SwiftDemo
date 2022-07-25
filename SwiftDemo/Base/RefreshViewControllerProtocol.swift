//
//  RefreshViewControllerProtocal.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/18.
//

import Foundation

protocol RefreshViewControllerProtocol {
    /**是否有刷新头部刷新组件*/
    func hasHeaderRefresh() -> Bool

    func hasFooterRefresh() -> Bool
    /**重新请求数据*/
    func retryNewData()

    func refreshNetworking(operation: Operation)

}
