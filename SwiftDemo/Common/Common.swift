//
//  Macro.swift
//  SwiftDemo
//
//  Created by Yang on 2021/4/14.
//
import UIKit
import Foundation

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

func isXSeries() -> Bool {
    guard let window = UIApplication.shared.delegate?.window else {
        return false
    }
    if #available(iOS 11.0, *) {
        return (window?.safeAreaInsets.bottom)! > 0
    } else {
        return false
    }
}

func ImageName(_ name: String) -> UIImage? {
    return UIImage(named: name)
}

func ImageColor(_ color: String) -> UIImage? {
    return UIImage(color: HexStringColor(color)!, size: CGSize(width: ScreenWidth, height: ScreenHeight))
}

func HexStringColor(_ hexString: String) -> UIColor? {
    return UIColor.init(hexString: hexString)
}

let SafeBottomHeight: CGFloat = isXSeries() ? 34.0 : 0.0
let StatusBarHeight: CGFloat = isXSeries() ? 44.0 : 20.0
let NavBarHeight: CGFloat =  StatusBarHeight + 44.0

func scaleW(_ width: CGFloat, fit: CGFloat = 375.0) -> CGFloat {
    return ScreenWidth / fit * width
}

func scaleH(_ height: CGFloat, fit: CGFloat = 812.0) -> CGFloat {
    return ScreenHeight / fit * height
}

func scaleV(_ value: CGFloat) -> CGFloat {
    return scaleW(value)
}

func printLog<N>(_ message: N, fileName: String = #file, methodName: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    print("message:\(message)\nway:\(fileName as NSString) methods:\(methodName) line:\(lineNumber)")
    #endif
}
func YYLog(_ items: Any..., separator: String = " ", terminator: String = "\n", file: String = #file, line: Int = #line, method: String = #function)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method)", terminator: separator)
    var i = 0
    let j = items.count
    for a in items {
        i += 1
        print(" ", a, terminator: i == j ? terminator: separator)
    }
    #endif
}

func iPhoneX() -> Bool {
    if #available(iOS 11, *) {
          guard let w = UIApplication.shared.delegate?.window, let unwrapedWindow = w else {
              return false
          }
          if unwrapedWindow.safeAreaInsets.left > 0 || unwrapedWindow.safeAreaInsets.bottom > 0 {
              print(unwrapedWindow.safeAreaInsets)
              return true
          }
    }
    return false
}
