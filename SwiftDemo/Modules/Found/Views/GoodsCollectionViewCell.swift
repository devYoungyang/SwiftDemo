//
//  GoodsCollectionViewCell.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/26.
//

import UIKit

class GoodsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productPic: UIImageView!
    @IBOutlet weak var goodsName: UILabel!
    @IBOutlet weak var salesNumberLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

}
