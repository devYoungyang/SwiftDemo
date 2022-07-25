//
//  ViewReactor.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/30.
//
import ReactorKit
import Foundation

final class ViewReactor: Reactor {
    enum Action {
        case increase

        case decrease
    }
    enum Mutation {
        case increaseValue

        case decreaseValue

        case setLoading(Bool)
    }
    struct State {
        var value: Int
        var isLoading: Bool
    }
    let initialState: State = State(value: 0, isLoading: false)

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            guard !self.currentState.isLoading else {
                return Observable.empty()
            }
            let start = Observable.just(Mutation.setLoading(true))
            let request = Observable.just(Mutation.increaseValue).delay(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            let end = Observable.just(Mutation.setLoading(false))
            return Observable.concat(start, request, end)
        case .decrease:
            guard !self.currentState.isLoading else {
                return Observable.empty()
            }
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue)
                    .delay(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance),  // 数字改变延迟1秒钟
                Observable.just(Mutation.setLoading(false))
                ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
            case .increaseValue:
                state.value += 1
            case .decreaseValue:
                state.value -= 1
            case .setLoading(_):
                break
            }
        return state
    }
}
