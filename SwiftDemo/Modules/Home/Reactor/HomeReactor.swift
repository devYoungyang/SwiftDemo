//
//  HomeReactor.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/7.
//
import NSObject_Rx
import ReactorKit
import UIKit

class HomeReactor: Reactor {
    var disposeBag = DisposeBag()
    var NetWork = NetWorking<HomeApi>()
    enum Action {
        case getGoodsList(Operation)
    }
    enum Mutation {
        case setGoodsList([GoodsModel], Operation)

        case setGoods([GoodsSection<GoodsModel>])

        case setLoading(Bool)

        case setRefreshing(Bool)
    }
    struct State {
        var goodsList: [GoodsModel] = []

        var goods: [GoodsSection<GoodsModel>] = []

        var isLoading: Bool = false
//
        var isRefreshing: Bool = false

        var refreshState: BaseRefreshState = .idle
    }
    var initialState: State
    init() {
        self.initialState = State()
    }

}

extension HomeReactor {
    func networkForList() -> Observable<BaseModel<GoodsModel>?> {
        return NetWork.request(.getGoodsList).filterSuccessfulStatusCodes().mapToData(GoodsModel.self)
    }
    func mutate(action: HomeReactor.Action) -> Observable<HomeReactor.Mutation> {
        switch action {
        case .getGoodsList(let operation):
            guard !self.currentState.isLoading else {
                return Observable.empty()
            }
            let request = networkForList().map { (model) -> Mutation in
                guard let data = model?.dataArr, data.count>0 else {
                    return Mutation.setGoodsList([], operation)
                }
                return Mutation.setGoodsList(data, operation)
            }.catchError { (error) -> Observable<HomeReactor.Mutation> in
                print(error)
                return Observable.just(Mutation.setGoodsList([], operation))
            }
            let start = Observable.just(Mutation.setLoading(true))
            let end = Observable.just(Mutation.setLoading(false))
            return Observable.concat([start, request, end])
        }
    }
    func uploadSection(data: [GoodsModel]) -> [GoodsSection<GoodsModel>] {
       return [GoodsSection<GoodsModel>(items: data)]
    }
    func refreshStateWithData(datas: [Any], operation: Operation) -> BaseRefreshState {
        if operation == .refresh {
            if datas.count == 0 {
                return .empty
            } else if datas.count < 20 {
                return .noMoreData
            } else {
                return .idle
            }
        } else {
            if datas.count < 20 {
                return .noMoreData
            } else {
                return .idle
            }
        }
    }
    func reduce(state: HomeReactor.State, mutation: HomeReactor.Mutation) -> State {
        var state = state
        switch mutation {
        case .setGoods(let data):
            state.goods = data
        case .setGoodsList(let data, let operation):
//            YYLog(data)
            if operation == .refresh {
                state.goods = self.uploadSection(data: data)
            } else {
                state.goods += self.uploadSection(data: data)
            }
            state.refreshState = refreshStateWithData(datas: data, operation: operation)
        case .setRefreshing(let refresh):
            state.isRefreshing = refresh
        case .setLoading(_):
            break
        }
        return state
    }
}
