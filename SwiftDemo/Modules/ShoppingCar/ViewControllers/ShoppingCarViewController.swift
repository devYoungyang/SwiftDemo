//
//  ShoppingCarViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/27.
//

import ReactorKit
import RxSwift
import UIKit
import RxCocoa
import ZLPhotoBrowser
class ShoppingCarViewController: BaseViewController {

    var disposeBag = DisposeBag()
    
    var dataArr = NSMutableArray()

    lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.backgroundColor = .orange
        label.textAlignment = .center
        return label
    }()
    lazy var plusBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(" + ", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    lazy var minusBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle(" - ", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "购物车"

        self.reactor = ViewReactor()

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.topMargin.equalTo(150)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        view.addSubview(plusBtn)
        plusBtn.snp.makeConstraints { make in
            make.leftMargin.equalTo(30)
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.topMargin.equalTo(titleLabel).offset(140)
        }
        view.addSubview(minusBtn)
        minusBtn.sd_layout()
            .rightSpaceToView(view, 30)?
            .topSpaceToView(titleLabel, 100)?
            .widthIs(100)?
            .heightIs(40)

        let headerImg = UIImageView()
        view.addSubview(headerImg)
         _ = headerImg.sd_layout()
            .centerXEqualToView(view)?
            .centerYEqualToView(view)?
            .widthIs(100)?
            .heightIs(40)
        headerImg.image = UIImage(named: "huawei")
        let tap = UITapGestureRecognizer(target: self, action: #selector(clicked))
        headerImg.isUserInteractionEnabled = true
        headerImg.addGestureRecognizer(tap)
        dataArr.addObjects(from: ["AAA","BBB","CCC","DDD","EEE"])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: " + ", style: .done, target: self, action: #selector(btnClicked))
        /**
        let myObs = Observable<Any>.create { (observe) -> Disposable in
            observe.onNext("发送消息")
            observe.onCompleted()
            return Disposables.create()
        }
        myObs.subscribe(onNext: { (res) in   // 订阅事件
            print(res)
        }).disposed(by: disposeBag)
        
        Observable.just("HAHAH").subscribe(onNext: { (res) in  //传入一个值初始化
            print(res)
        }).disposed(by: disposeBag)
        
        Observable.of("A","B","C","D").subscribe(onNext: { (res) in
            print(res)
        }).disposed(by: disposeBag)
        
        Observable.from(["E","F","G","H"]).subscribe(onNext: { (res) in
            print(res)
        }).disposed(by: disposeBag)
        
        Observable<Int>.never().subscribe(onNext: { (i) in
            print(i)
        }).disposed(by: disposeBag)
        
        Observable<Int>.empty().subscribe(onNext: { (i) in
            print(i)
        }).disposed(by: disposeBag)
        
        Observable.range(start: 0, count: 10).subscribe(onNext: { (i) in
            print(i)
        }).disposed(by: disposeBag)
        
        
//        Observable<Int>.generate(initialState: 3) { (i) -> Bool in
//            i > 0
//        } iterate: { (i) -> Int in
//            return 4
//        }.subscribe(onNext: { (i) in
//            print(i)
//        }).disposed(by: disposeBag)
        
//        Observable<Int>.timer(1, scheduler: MainScheduler.instance).subscribe(onNext: { (i) in
//            print(i)
//        }).disposed(by: disposeBag)
        
//        Observable<Int>.timer(1, period: 1, scheduler: MainScheduler.instance).subscribe(onNext: { (i) in
//            print(i)
//        }).disposed(by: disposeBag)
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        titleLabel.textColor = .orange
        
        titleLabel.backgroundColor = .gray
        Observable<String>.just("WUWUWU").map { (str) -> String in
            return str + "1234567890"
        }.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        
        let subject = BehaviorSubject.init(value: "cooci")
//        subject.subscribe(onNext: { (res) in
//            print(res)
//        }).disposed(by: disposeBag)
        
//        subject.onNext("HAHAHA1234321")
        subject.onNext("WUWUWUW123134")
        subject.subscribe(onNext: { (res) in
            print(res)
        }, onError: { (e) in
            print(e)
        }, onCompleted: {
            
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
        
        let publishSubject = PublishSubject<String>()
        
        publishSubject.subscribe(onNext: { (res) in
            print(res)
        }).disposed(by: disposeBag)
        publishSubject.onNext("TOM")
        */
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @objc func btnClicked(){
        self.navigationController?.pushViewController(SecondViewController())
    }
    @objc func clicked() {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = 1
        config.maxPreviewCount = 0
        let ps = ZLPhotoPreviewSheet()
//        ps.selectImageBlock = {(images, assets, original) in
//            
//        }
//        ps.showPreview(sender: self)
        
        
    }

}

extension ShoppingCarViewController: View {
    func bind(reactor: ViewReactor) {
        plusBtn.rx.tap.map { ViewReactor.Action.increase }.bind(to: reactor.action).disposed(by: disposeBag)

        minusBtn.rx.tap.map { ViewReactor.Action.decrease}.bind(to: reactor.action).disposed(by: disposeBag)

        reactor.state.map {$0.value }.distinctUntilChanged().map {"\($0)"}.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
    }
}
