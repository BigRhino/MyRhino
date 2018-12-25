//
//  main.swift
//  Function
//
//  Created by iMac on 2017/11/8.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation


//关键字 函数名 外部参数名 内部参数名:参数类型 -> 返回值类型{}
//func printGreetingPersonal(to name:String) -> Void{
//    print("My name is \(name)")
//}

//省略(Void)返回值类型,
func printGreetingPersonal(name:String){
    print("My name is \(name)")
}
//省略外部参数名
func printGreetingPersonal(_ name:String){
    print("My name is \(name)")
}

//printGreetingPersonal(to: "张三")
printGreetingPersonal(name: "ss")

//可变参数 只能有一个,类似于数组


//默认参数 default

//可以任意放置,有默认参数的,不传值就使用默认参数
func divisionDescriptionFor(numerator:Double = 2.3,denominator:Double,withPunctation punctuation:String = "."){
    print("\(numerator):\(denominator):\(punctuation)")
}

divisionDescriptionFor(denominator: 3.444)

//inout 修改函数参数

//guard 提前退出函数
//guard 语句会根据某个表达式返回的布尔值结果来执行代码；但不同之处是，如果某些条件没有满足，可以用guard 语句来提前退出函数，这也是其名称的由来。可以把guard 语句想象成一种防止代码在某种不当条件下运行的方式。

func greetByMiddleName(fromFullName name:(first:String,middle:String?,last:String))  {
    
    guard let middleName = name.middle else{
        print("Hey there!")
        return
    }
    print("Hey \(middleName)")
}

greetByMiddleName(fromFullName: ("Matt","Danger","Mathias"))

//函数类型

