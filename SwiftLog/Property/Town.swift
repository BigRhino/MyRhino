//
//  Town.swift
//  Property
//
//  Created by iMac on 2017/11/6.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//计算属性不会像之前的属性那样存储值，而是提供一个读取方法 （getter）来获取属性的值，并可选地提供一个写入方法 （setter）设置属性的值
struct Town {
    static let region = "South"
    var population = 5_422{
        didSet(oldPopulation){
            print("The population has changed to \(population) from \(oldPopulation).")
        }
        willSet(newPopulation){
            print("The population will changed to \(newPopulation) from \(population).")
        }
    }
    
    var numberOfStoplights = 4
    
    enum Size {
        case small
        case medium
        case large
    }
    
    //惰性加载
    //延迟把属性的值的计算推迟到实例初始化后,必须声明为var,因为它的值会发生变化
    //1.lazy 2.var 3.()
    
    //圆括号和lazy确保编译器会在我们第一次访问这个属性的时候调用闭包并将结果赋值给它
    //闭包必须引用self
    //lazy告诉编译器这个属性不是创建self所必须的,如果它不存在,就应该在它被第一次访问的时候创建
    //当闭包被调用时,self肯定已经可用了
    
    //lazy 只会被执行一次
//    lazy var townSize:Size  = {
//        switch self.population {
//        case 0...10_000:
//            return Size.small
//        case 10_001...100_000:
//            return Size.medium
//        default:
//            return Size.large
//        }
//    }()

    //计算型属性
    //计算型属性必须有类型信息,提供读取方法来获取属性的值,可选的提供一个写入方法(setter)来设置属性的值
    var townSize:Size{
        get{
            switch self.population {
            case 0...10_000:
                return Size.small
            case 10_001...100_000:
                return Size.medium
            default:
                return Size.large
            }
        }
    }
    
    func printDescription() -> Void {
        print("Population:\(population);number of stoplights:\(numberOfStoplights)")
    }
    
    mutating func changePopulation(by amount:Int){
        population += amount
    }
    
}



class Person1{
    var name:String = "Lili"
    let age:Int = 10
    lazy var p1:Person1 = Person1()
}
//存储型属性用来存储值的
//计算性属性:不直接存储值,而是用get/set来取值和赋值的,可以操作其它属性的变化 //get用来取值,set用来赋值

class Person2:CustomStringConvertible{
    var height = 67
    //计算型属性必须有明确的类型
    //get-only property只读计算型属性 get可以省略,没有实现set方法不能进行赋值
    var weight:Int{
        return height * 3
    }
    
    var age:Int{
        get{
            return height/2
        }
        set(newAge){
            height = newAge * 2
        }
    }
    
    var description: String{
        return "height:\(height),weight:\(weight),age:\(age)"
    }
    //死循环
//    var size:Int{
//        get{
//            //将会调用get方法
//            return size
//        }
//        set{
//            //将会调用set方法
//            size = newValue
//        }
//    }
    
    
}



