//
//  FoundViewController.swift
//  SwiftDemo
//
//  Created by Yang on 2021/2/25.
//

import  NSObject_Rx
import RxCocoa
import RxSwift
import UIKit
import ReactorKit
class FoundViewController: BaseViewController, UICollectionViewDelegateFlowLayout {

    var disposeBag = DisposeBag()
    var dataArr: [Any] = ["2w", "1w", "3w", "4w", "5w", "6w", "3w", "4w", "5w", "6w", "6w", "7w"]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: CGRect(x: 0, y: NavBarHeight, width: ScreenWidth, height: ScreenHeight-NavBarHeight-SafeBottomHeight), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.register(UINib.init(nibName: "GoodsCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = UIColor.white

        layout.itemSize = CGSize(width: (ScreenWidth-30)/2, height: (ScreenWidth-30)/2+55)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return collectionView
    }()
//    override func hasHeaderRefresh() -> Bool {
//        return true
//    }
//    override func hasFooterRefresh() -> Bool {
//        return true
//    }
//    override func scrollViewInstance() -> UIScrollView? {
//        return self.collectionView
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        self.navigationItem.title = "商品列表"
        self.gk_navBackgroundColor = UIColor.green
    
        view.addSubview(collectionView)
        self.reactor = ProductReactor()

//        Observable.just(dataArr).bind(to: collectionView.rx.items(cellIdentifier: "cellId")){ (row, model,cell:GoodsCollectionViewCell) in
//            cell.productPic?.image = UIImage(named: "iphone")!
//            cell.goodsName?.text = "华为 HUAWEI Mate X2 麒麟9000旗舰芯片 无缝鹰翼折叠"
//            cell.priceLabel?.text = "6999"
//            cell.salesNumberLabel?.text = model as? String
//            cell.backgroundColor = UIColor.orange
//        }.disposed(by: rx.disposeBag)

//        Observable.just(dataArr).bind(to: collectionView.rx.items(cellIdentifier: ""))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FoundViewController: UICollectionViewDelegate {

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell: GoodsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! GoodsCollectionViewCell
//        cell.productPic?.image = UIImage(named: "iphone")!
//        cell.goodsName?.text = "华为 HUAWEI Mate X2 麒麟9000旗舰芯片 无缝鹰翼折叠"
//        cell.priceLabel?.text = "6999"
//        cell.salesNumberLabel?.text = "2w+"
//        cell.backgroundColor = UIColor.orange
//        return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        print(indexPath.row)
//    }
}
extension FoundViewController: View {
    func bind(reactor: ProductReactor) {
        rx.viewDidAppear.subscribe(onNext: { _ in
            reactor.action.onNext(.getProductList)
        }).disposed(by: rx.disposeBag)
        reactor.state.map {$0.productList}.bind(to: collectionView.rx.items(cellIdentifier: "cellId")) {(_, model, cell: GoodsCollectionViewCell) in
            cell.backgroundColor = .white
            cell.productPic.image = UIImage(named: "iphone")!
            cell.goodsName.text = model.name
            cell.priceLabel.text = model.price
            cell.salesNumberLabel.text = model.number
        }.disposed(by: disposeBag)

    }
}
