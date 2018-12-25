//
//  Accountant.swift
//  Memory
//
//  Created by iMac on 2017/11/16.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Accountant{
    typealias NetWorthChanged = (Double)->Void
    
    var netWorthChangedHandler:NetWorthChanged? = nil
    
    var netWorth:Double = 0.0 {
        didSet{
            netWorthChangedHandler?(netWorth)
        }
    }
    
    func gained(_ asset:Asset,completion:()->Void) {
        netWorth += asset.value
        completion()
    }
    
    
}
