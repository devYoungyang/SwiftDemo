//
//  GoodsReactor.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/12.
//
import ReactorKit
import UIKit

class GoodsReactor: Reactor {
    enum Action {

    }
    enum Mutation {

    }
    struct State {
        var mode: GoodsModel?
        var clickedBtnBlock: ((Int, GoodsModel) -> Void )?
    }
    var initialState: State = State()

    init(model: GoodsModel, clickedBtnBlock: ((Int, GoodsModel) -> Void)? = nil  ) {
        initialState.mode = model
        initialState.clickedBtnBlock = clickedBtnBlock
    }

}
