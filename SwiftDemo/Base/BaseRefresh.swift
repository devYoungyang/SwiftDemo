//
//  BaseRefresh.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/18.
//
import MJRefresh
import Foundation

class BaseHeaderRefresh: MJRefreshStateHeader {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("下拉刷新...", for: .idle)
        self.setTitle("放开以刷新...", for: .pulling)
        self.setTitle("正在载入中...", for: .refreshing)
        self.lastUpdatedTimeLabel?.isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseFooterRefresh: MJRefreshAutoStateFooter {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setTitle("上拉加载更多...", for: .idle)
        self.setTitle("上拉加载更多...", for: .pulling)
        self.setTitle("正在载入...", for: .refreshing)
        self.setTitle("已经到底啦", for: .noMoreData)
        self.stateLabel?.textColor = UIColor(hexString: "#9b9b9b")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// extension MJRefreshFooter: ETExtensionCompatible {
//
// }
//
// extension ET where Base: MJRefreshFooter {
//    func setRefState(state: RefreshState) {
//        let refresh = base as? MJRefreshAutoStateFooter
//        switch state {
//        case .empty:
//            refresh?.setTitle("", for: .idle)
//            refresh?.state = .idle
//        case .idle:
//            refresh?.setTitle("上拉加载更多...", for: .idle)
//            refresh?.state = .idle
//        default:
//            refresh?.state = MJRefreshState.init(rawValue: state.rawValue)!
//        }
//    }
// }

enum BaseRefreshState: Int {
    case empty = 0, idle, pulling, refreshing, willRefresh, noMoreData
}

enum Operation {
    case refresh
    case more
}
