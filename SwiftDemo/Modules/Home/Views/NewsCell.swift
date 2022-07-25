//
//  NewsCell.swift
//  SwiftDemo
//
//  Created by Yang on 2021/3/1.
//
import ReactorKit
import SnapKit
import UIKit

class NewsCell: UITableViewCell, View {
    var disposeBag: DisposeBag = DisposeBag()
    let titleLabel = UILabel()
    let contentLabel = UILabel()

    typealias Reactor = GoodsReactor

    var sourceLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()

    }
    func setUpUI() {
        contentView.backgroundColor = UIColor.orange
        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.leftMargin.equalTo(15)
            make.rightMargin.equalTo(15)
            make.height.equalTo(20)
            make.topMargin.equalTo(10)
        }
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.leftMargin.equalTo(15)
            make.topMargin.equalTo(40)
            make.height.equalTo(20)
            make.width.equalTo(UIScreen.main.bounds.size.width-30)
        }
    }
    func setValueForCell(_ model: GoodsModel) {
        titleLabel.text = model.productName
        contentLabel.text = model.price
    }

}
extension NewsCell {

    func bind(reactor: Reactor) {
        reactor.state.map { $0.mode?.productName }.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        reactor.state.map { $0.mode?.price }.bind(to: contentLabel.rx.text).disposed(by: disposeBag)
    }
}
