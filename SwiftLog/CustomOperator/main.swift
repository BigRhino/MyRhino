//
//  main.swift
//  CustomOperator
//
//  Created by iMac on 2017/12/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//操作符
/*
运算符主要有三种类型：一元、二元和三元。

•一元运算符的工作只有一个操作数,被定义为后缀，如果他们出现在操作数，或前缀，如果他们出现在操作数。逻辑非操作符是一元运算符的前缀式操作符和强迫展开运算符是一元的后缀之一

•二进制操作的两个操作数和中缀因为他们之间出现的操作数。所有算术运算符（+，-，*，/，%），比较运算符（=），！=，<，>，< =、> =）和大部分的逻辑的（&，| |）是二进制的中缀。

•三元运算符用三个操作数工作。条件运算符,唯一的三元运算符。
*/





infix operator **

func **(base: Int, power: Int) -> Int {
    
    
    
    
    precondition(power >= 2)
    var result = base
    for _ in 2...power {
        result *= base
    }
    return result
}

infix operator **=
func **=(lhs: inout Int, rhs: Int) {
    lhs = lhs ** rhs
}


