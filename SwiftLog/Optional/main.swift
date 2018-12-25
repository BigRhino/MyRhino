//
//  main.swift
//  Optional
//
//  Created by iMac on 2017/11/8.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

/*
var errorCodeString:String!
errorCodeString = "404"
print(errorCodeString)

errorCodeString = nil

//为nil将导致运行时错误
//errorCodeString.append("sss")
//print(errorCodeString)

//类型不匹配,如果errorCodeString为nil将会导致运行时错误
let anotherCodeString:String = errorCodeString

//编译器推断为 String? 类型
let yetAnotherString = errorCodeString
*/

var errorCodeString:String?
errorCodeString = "404"

var errorDescption:String?

if let theError = errorCodeString,let errorCodeInterger = Int(theError),errorCodeString == "404"{
    errorDescption = "\(errorCodeInterger + 200):resource was not found"
}

print(errorDescption ?? "nil")

