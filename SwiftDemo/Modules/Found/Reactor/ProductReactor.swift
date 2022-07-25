//
//  ProductReactor.swift
//  SwiftDemo
//
//  Created by Yang on 2021/6/17.
//

import Foundation
import ReactorKit

class ProductReactor: Reactor {

    enum Action {
        case getProductList
    }

    enum Mutation {
        case setProductList([Product])
        case setLoading(Bool)
    }
    struct State {
        var isLoading: Bool = false
        var productList: [Product] = []
    }
    var initialState: State
    init() {
        self.initialState = State()
    }

}

extension ProductReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getProductList:
            guard !self.currentState.isLoading else {
                return Observable.empty()
            }
            let p = Product()
            p.name = "华为MATE 40"
            p.price = "7999"
            p.number = "2w+"
            return Observable.concat([Observable.just(Mutation.setLoading(true)), Observable.just(Mutation.setProductList([p, p,p,p,p,p,p,p, p, p, p, p, p])), Observable.just(Mutation.setLoading(false))])
        }
    }
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .setLoading(let loading):
            state.isLoading = loading
        case .setProductList(let list):
            state.productList = list
        }
        return state
    }
}
