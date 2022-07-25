//
//  TabBarItemContentView.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/15.
//

import ESTabBarController_swift
import UIKit

class TabBarItemContentView: ESTabBarItemContentView {

    public var duration = 0.2
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.red
        highlightTextColor = UIColor.green
        iconColor = UIColor.red
        highlightIconColor = UIColor.green
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func selectAnimation(animated: Bool, completion: (() -> Void)?) {
        bounceAnimation()
        completion?()
    }
    override func reselectAnimation(animated: Bool, completion: (() -> Void)?) {
        bounceAnimation()
        completion?()
    }
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0, 1.02, 0.95, 1.02, 0.95, 1.02, 1.0]
        impliesAnimation.duration = duration * 2
        impliesAnimation.calculationMode = .cubic
        imageView.layer.add(impliesAnimation, forKey: nil)
    }

}
