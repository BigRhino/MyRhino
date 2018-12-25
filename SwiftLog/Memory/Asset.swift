//
//  Asset.swift
//  Memory
//
//  Created by iMac on 2017/11/16.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Asset: CustomStringConvertible {
    
    let name:String
    let value:Double
    //弱引用
    //弱引用必须用var声明,不能有let
    //弱引用必须声明为可空类型
    weak var owner:Person?
    
    var description: String{
        if let actualOwner = owner {
            return "Asset:\(name),worth:\(value),owned by \(actualOwner)"
        }else{
            return "Asset:\(name),worth:\(value),not by anyone"
        }
    }
    
    init(name:String,value:Double) {
        self.name = name
        self.value = value
    }
    
    
    deinit {
        print("\(self) is being dealloced")
    }
}


