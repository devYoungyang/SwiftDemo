//
//  Scale.swift
//  SwiftDemo
//
//  Created by Yang on 2021/5/17.
//

import Foundation

extension CGFloat {
    var scale: CGFloat {
        return scaleV(self)
    }
}

extension Int {
    var scale: CGFloat {
        return scaleV(CGFloat(self))
    }
}

extension Double {
    var scale: CGFloat {
        return scaleV(CGFloat(self))
    }
}
