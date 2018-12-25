//
//  Monster.swift
//  Property
//
//  Created by iMac on 2017/11/6.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Monster{
    var town:Town?
    var name = "Monster"
    
    //存储类型属性
    static let isTerrifying = true
    //计算类型属性
    static var sex:String{
        return "男"
    }
    
    //计算类型属性
    class var spookyNoise: String {
        return "Grrr"
    }
// Class stored properties not supported in classes; did you mean 'static'?
    //不允许存储类型属性用class声明
//   class var weight:Double = 67.0
    
    //类型方法
    class func talk(){
        print("Hello,I'm sex is\(sex)")
    }
    
    static func say(){
        print("Hello")
    }
    
    var victimPool:Int {
        get{
            return town?.population ?? 0
        }
        set(newVictimPool){
            town?.population = newVictimPool
        }
    }
    
    func terrorizeTown()  {
        if town != nil {
            print("\(name) is terrorizing a town!")
        }else{
            print("\(name) hasn't found a town to terrorize yet...")
        }
    }
    
    
}
