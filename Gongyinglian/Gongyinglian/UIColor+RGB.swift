//
//  UIColor+RGB.swift
//  Gongyinglian
//
//  Created by Stephen Zhuang on 14-7-7.
//  Copyright (c) 2014年 udows. All rights reserved.
//

import Foundation

extension UIColor {
    class  func RGBColor(#red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}