//
//  main.swift
//  ControlFlows3
//
//  Created by iMac on 2017/12/19.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation


//Countable Range
let closeRange = 0...5

//Countable half-open range
let halfopenRange = 0..<5

//Loop && switch
let count = 10
var sum = 0
for i in 0...count {
    sum += i
}


//ignore constant
for _ in 1..<count{
    //do something
}

//odd
sum = 0
for i in 0...count where i % 2 == 1{
    sum += i
}

//continue
sum = 0
for row in 0...7{
    if row % 2 == 0{
        continue
    }
    for column in 0...7{
        sum += row*column
    }
}


//Label statement
sum = 0
rowLoop:for row in 0..<8{
    columnLoop:for column in 0..<8{
        if row == column {
            continue rowLoop
        }
        sum += row*column
    }
}


sum = 0
for row in 0...7 where row % 2 == 1{
    for column in 0...7{
        sum += row * column
    }
}


//:switch
let number = 10
switch number {
case 0:
    print("Zero")
default:
    print("No-Zero")
}

switch number {
case let x where x % 2 == 0:
    print("Even")
default:
    print("Odd")
}

switch number {
case _ where number % 2 == 0:
    print("Even")
default:
    print("Odd")
}


//more than one case
let horuOfDay = 12
var timeOfDay:String

switch horuOfDay {
case 0,1,2,3,4,5:
    timeOfDay = "early morning!"
case 6,7,8,9,10,11:
    timeOfDay = "Morning"
case 12,13,14,15,16:
    timeOfDay = "Afternoon"
case 17,18,19:
    timeOfDay = "Evening"
case 20,21,22,23:
    timeOfDay = "Late evening"
default:
    timeOfDay = "INVALID HOUR"
}
print(timeOfDay)

//use range
switch horuOfDay {
case 0...5:
    timeOfDay = "early morning!"
case 6...11:
    timeOfDay = "Morning"
case 12...16:
    timeOfDay = "Afternoon"
case 17...19:
    timeOfDay = "Evening"
case 20..<24:
    timeOfDay = "Late evening"
default:
    timeOfDay = "INVALID HOUR"
}

//partial matching
let coordinate = (x:4,y:4,z:5)

switch coordinate{
case (0,0,0):
    print("origin")
case (_,0,0):
    print("x")
case (0,_,0):
    print("y")
case (0,0,_):
    print("z")
default:
    print("Somewhere")
}

switch coordinate{
case (0,0,0):
    print("origin")
case (let x,0,0):
    print("x_axis x:\(x)")
case (0,let y,0):
    print("y_axis y:\(y)")
case (0,0,let z):
    print("z_axis z:\(z)")
case let (x,y,z):
    print("Somewhere x:\(x),y:\(y),z:\(z)")
}

switch coordinate{
case (let x,let y,_) where x == y:
    print("along the y == x line")
case let(x,y,_) where y == x * x:
    print("Along the y = x^2 line.")
default:
    break
}


//mini exercises
let age:UInt8 = 24
let stages:String

switch age{
case 0...2:
    stages = "Infant"
case 3...12:
    stages = "Child"
case 13...19:
    stages = "Teenager"
case 20...39:
    stages = "Adult"
case 40...60:
    stages = "Middle aged"
case _ where age >= 61:
    stages = "Elderly"
default:
    stages = "Invalid age"
}
print(stages)


let child = (name:"xiaoming",age:12)
let childStage:String
switch child{
case (let name,0...2):
    childStage = "\(name) is an Infant"
case (let name,3...12):
    childStage = "\(name) is an Child"
case (let name,13...19):
    childStage = "\(name) is an Teenager"
case (let name,20...39):
    childStage = "\(name) is an Adult"
case (let name,40...60):
    childStage = "\(name) is an Middle aged"
case let (name,age) where age > 60:
    childStage = "\(name) is an Elderly"
default:
    childStage = "INVALID AGE"
}
print(childStage)
