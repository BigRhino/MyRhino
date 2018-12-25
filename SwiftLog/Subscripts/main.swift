//
//  main.swift
//  Subscripts
//
//  Created by iMac on 2017/12/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation
//下标的原型
//可以看作是重载操作符 类似于函数或者计算型属性
/*
subscript(parameterList) -> ReturnType {
    get {
        // return someValue of ReturnType
    }
    set(newValue) {
        // set someValue of ReturnType to newValue
    }
}
 */
class Person{
    let name:String
    let age:Int
    
    init(name:String,age:Int) {
        self.name = name
        self.age = age
    }
}

let me = Person(name: "Me", age: 23)

//Type 'Person' has no subscript members
//print(me["name"])

extension Person{
    //省略参数
    subscript(key:String) -> String?{
        switch key{
        case "name":
            return self.name
        case "age":
            return String(self.age)
        default:
            return nil
        }
    }
    //扩展参数  直观
    subscript(property key:String) -> String?{
        switch key{
        case "name":
            return self.name
        case "age":
            return String(self.age)
        default:
            return nil
        }
    }
}

print(me["name"] ?? "nil")
print(me["age"] ?? "nil")



extension Array {
    
    subscript(index index: Int) -> (String, String)? {
        guard let value = self[index] as? Int else {
            return nil
        }
        switch (value >= 0, abs(value) % 2) {
        case (true, 0):
            return ("positive", "even")
        case (true, 1):
            return ("positive", "odd")
        case (false, 0):
            return ("negative", "even")
        case (false, 1):
            return ("negative", "odd")
        default:
            return nil
        }
        
    }
}

//let numbers = [-2, -1, 0, 1, 2]
//
//print(numbers[index: 0])
//print(numbers[index: 1])
//print(numbers[index: 2])
//print(numbers[index: 3])
//print(numbers[index: 4])


extension String{
    subscript(index:Int) -> Character?{
        guard (0..<count).contains(index) else{
            return nil
        }
        return characters[characters.index(startIndex, offsetBy: index)]
    }
}

print("Custom"[3] ?? "nil")

