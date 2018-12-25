//
//  MyObject.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit


protocol MyDelegate {
    func printLog() -> Void
    func endPrint() -> Void
}


class MyObject: NSObject {
    
    var delegate:MyDelegate?
    
    func start() {
        print("开始执行打印!")
        self.delegate?.printLog()
    }
    func end() {
        print("结束打印!")
        self.delegate?.endPrint()
    }
}
