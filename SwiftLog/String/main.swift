//
//  main.swift
//  String
//
//  Created by iMac on 2017/11/7.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

let greeting = "Guten Tag!"

print(greeting[greeting.startIndex])  //G

print(greeting[greeting.index(before: greeting.endIndex)])//!

print(greeting[greeting.index(after: greeting.startIndex)])//u

let index = greeting.index(greeting.startIndex, offsetBy: 7)
print(index) //Index(_compoundOffset: 28, _cache: Swift.String.Index._Cache.character(1))
print(greeting[index])//a

//访问越界
// runtime error
//print(greeting[greeting.endIndex])
//print(greeting[greeting.index(before: greeting.startIndex)])


//indices
for index in greeting.indices{
    print("\(greeting[index]) ", terminator:"")
}

//remove
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
print(welcome)

welcome.insert(contentsOf: "there", at: welcome.index(before:welcome.endIndex))
print(welcome)


welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)

let range = welcome.index(welcome.endIndex, offsetBy: -5)..<welcome.endIndex
welcome.removeSubrange(range)
print(welcome)


//
let greet = "Hello,world!"
let inde = greet.index(of: ",") ?? greet.endIndex
let begining = greet[..<index] //String.SubSequence
print(begining)

print(String(begining))

//比较字符串
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."

if quotation == sameQuotation {
    print("These two strings are considered equal")
}






