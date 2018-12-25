//
//  main.swift
//  SwiftLog
//
//  Created by iMac on 2017/10/30.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

print("Hello, World!")

let file = (#file as NSString).lastPathComponent
print(file)
print(#line)
print(#file)


func addName(_ one:String) -> Void{
    print(#function + one)
    
}

addName("haha")

// T是动态类型
func JQLog<T>(message: T, file : String = #file, funcName:String = #function, lineNum : Int = #line){
    
    #if DEBUG
        
        // Build Settings --> swift flags --> 在debug后点击 + --> -D 自己起的名字
        let fileName = (file as NSString).lastPathComponent
        
        // 打印函数名
        print("\(fileName):(第\(lineNum)行) - \(message)")
        
    #endif
}

JQLog(message: "sss")

