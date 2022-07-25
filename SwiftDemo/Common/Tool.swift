//
//  Tool.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/16.
//

import UIKit

public enum Direction: Int {
    case East = 0

    case West

    case South

    case North

}

public struct Dog {
    var name: String

    var weight: Int

    func bark() {

    }
    var height: Int {
        return 50
    }
}
extension Direction {
    var count: Int {
        return 4
    }
}

class Tool: NSObject {

    static let shared = Tool()
    private override init() { } /**     私有化     */
    override class func copy() -> Any { /**     继承NSObject 需要重写*/
        return self
    }
    override class func mutableCopy() -> Any {
        return self
    }
    func getTextHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let normalText: NSString = text as NSString
        let size = CGSize(width: ceil(width), height: CGFloat(MAXFLOAT))
        let dic = NSDictionary(object: font, forKey: kCTFontAttributeName as! NSCopying)
        let stringSize = normalText.boundingRect(with: size, options: .usesFontLeading, attributes: dic as? [NSAttributedString.Key: Any], context: nil).size
        return ceil(stringSize.height)
    }

    func getTimeStamp() -> Int {
        let now = NSDate()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        return Int(timeInterval)
    }

}
