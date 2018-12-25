//
//  Zombie.swift
//  SwiftLog
//
//  Created by iMac on 2017/11/7.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Zombie:Monster{
    
    //子类覆写
    override class var spookyNoise: String {
        return "xx"
    }
    //不可以覆写
    //static let isTerrifying = false
    
    override class func talk() {
        super.talk()
        print("xx")
    }
    //Cannot override static method
//    override static func say(){
//    }
    
}
