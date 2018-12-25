//
//  UIColor+Extesion.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/30.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    
    ///   十六进制颜色
    ///
    /// - Parameters:
    ///   - hexStr: #cccc34 or cccc34
    ///   - alpha: alpha
    /// - Returns: UIColor
    public convenience init(_ hex6:String,alpha:CGFloat = 1.0){
        var hexStr = hex6
        hexStr = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexStr)
        var color:UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let divisor:CGFloat = 255.0
            let r = CGFloat((color & 0xFF0000 >> 16)) / divisor
            let g = CGFloat((color & 0x00FF00 >> 8)) / divisor
            let b = CGFloat((color & 0x0000FF)) / divisor
            self.init(red: r, green: g, blue: b, alpha: alpha)
        }else{
            print("Invalid hexString ", terminator: "")
            self.init()
        }
    }
    
    
    /// 标准颜色
    ///
    /// - Parameters:
    ///   - r: 0 ~ 255
    ///   - g: 0 ~ 255
    ///   - b: 0 ~ 255
    ///   - alpha: 0 ~ 1.0
    public convenience init(_ r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat = 1.0){
        let divisor:CGFloat = 255.0
        self.init(red: r/divisor, green: g/divisor, blue: b/divisor, alpha: alpha)
    }
    
}
