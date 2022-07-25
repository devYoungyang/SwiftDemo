//
//  GoodsTableViewCell.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/14.
//
import  Kingfisher
import ReactorKit
import Then
import UIKit

class GoodsTableViewCell: UITableViewCell, View {
    var disposeBag: DisposeBag = DisposeBag()
    typealias Reactor = GoodsReactor
    var goodsPic: UIImageView = UIImageView()
    var goodsName: UILabel = UILabel()
    var price: UILabel = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        contentView.sd_addSubviews([goodsPic, goodsName, price])

        goodsPic.sd_layout()
            .leftSpaceToView(contentView, 15)?
            .topSpaceToView(contentView, 10)?
            .widthIs(90)?
            .heightEqualToWidth()
        goodsName.sd_layout()
            .leftSpaceToView(goodsPic, 10)?
            .topEqualToView(goodsPic)?
            .rightSpaceToView(contentView, 15)?
            .autoHeightRatio(0)
        goodsName.numberOfLines = 2
        goodsName.textColor = .gray
        price.sd_layout()
            .leftEqualToView(goodsName)?
            .topSpaceToView(goodsName, 10)?
            .rightSpaceToView(contentView, 15)?
            .heightIs(20)
        price.textColor = .gray

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension GoodsTableViewCell {
    func bind(reactor: Reactor) {
//        reactor.state.map { $0.mode.pic }.bind(to: goodsPic.rx.image).disposed(by: disposeBag)
//        Observable.just(UIImage.init(named: "iphone")).bind(to: goodsPic.rx.image).disposed(by: disposeBag)
        Observable.just("http://mvimg2.meitudata.com/55fe3d94efbc12843jpg").subscribe(onNext: { [self] img in
            goodsPic.kf.setImage(with: URL.init(string: img), placeholder: UIImage.init(named: "iphone"))
        }).disposed(by: rx.disposeBag)
        reactor.state.map {$0.mode?.productName}.bind(to: goodsName.rx.text).disposed(by: disposeBag)
        reactor.state.map {$0.mode?.price}.bind(to: price.rx.text).disposed(by: disposeBag)
    }
}
