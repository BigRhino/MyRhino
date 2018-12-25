//
//  Location.swift
//  Struct
//
//  Created by iMac on 2017/11/7.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation


struct Location {
    var latitude:Double
    var longitude:Double
    
    // 如果不声明自定义的构造函数，结构体会创建一个包含所有参数的默认构造函数
    
    //构造函数
//    init(coordinateString:String) {
//        let commaIndex = coordinateString.index(of: ",") ?? coordinateString.endIndex
//        let firstElement = coordinateString[..<commaIndex]
//        let secondElement = coordinateString[commaIndex..<coordinateString.endIndex]
//        
//        self.latitude = Double(firstElement)!
//        self.longitude = Double(secondElement)!
//    }
}

