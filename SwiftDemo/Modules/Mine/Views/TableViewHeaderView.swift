//
//  TableViewHeaderView.swift
//  SwiftDemo
//
//  Created by Yang on 2021/6/18.
//

import UIKit

class TableViewHeaderView: UIView {

    var imgView: UIImageView!

    var imgViewFrame: CGRect!
    override init(frame: CGRect) {
        super.init(frame: frame)

        imgView = UIImageView(image: ImageName("lufei"))
        imgView.clipsToBounds = true
//        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(imgView)
        imgViewFrame = imgView.frame

        let label = UILabel(frame: CGRect(x: 0, y: frame.size.height-30, width: 200, height: 30))
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Monkey·D·路飞"
        label.textColor = .green
        self.addSubview(label)

    }
    func scrollViewDidScroll(contentOffsetY: CGFloat) {
        var frame = imgViewFrame!
        frame.size.height -= contentOffsetY
        frame.origin.y = contentOffsetY
        imgView.frame = frame
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
