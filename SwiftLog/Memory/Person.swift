//
//  File.swift
//  Memory
//
//  Created by iMac on 2017/11/16.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Person:CustomStringConvertible{
    
    let name:String
    var assets = [Asset]()
    let account = Accountant()
    
    init(name:String) {
        self.name = name
        //解决闭包的循环引用
        account.netWorthChangedHandler = {
            [weak self] netWorth in self?.netWorthDidChange(to: netWorth)
            return
        }
    }
    var description: String{
        return "Person:\(name)"
    }
    func takeOwnership(of asset:Asset) {
        //可逃匿的闭包
        account.gained(asset) {
            asset.owner = self
            assets.append(asset)
        }
    }
    func useNetWorthChangedHander(handler:(Double) -> Void) {
        account.netWorthChangedHandler = handler
    }
    
    func netWorthDidChange(to netWorth:Double)  {
        print("The net worth of \(self) is now \(netWorth)")
    }
    deinit {
        print("\(self) is being deallocated")
    }
}


