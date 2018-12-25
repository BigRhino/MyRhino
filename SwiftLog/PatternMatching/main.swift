//
//  main.swift
//  PatternMatching
//
//  Created by iMac on 2017/12/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

//1.
import Foundation

enum FormField {
    case firstName(String)
    case lastName(String)
    case emailAddress(String)
    case age(Int)
}
let minimumAge = 21
let submittedAge = FormField.age(22)

if case .age(let x) = submittedAge, x == minimumAge{
    print("YES is 21 old")
}else{
    print("Error")
}

//2.
enum CelestialBody {
    case star
    case planet(liquidWater: Bool)
    case comet
}
let telescopeCensus = [
    CelestialBody.star,
    CelestialBody.planet(liquidWater: false),
    CelestialBody.planet(liquidWater: true),
    CelestialBody.planet(liquidWater: true),
    CelestialBody.comet
]

for case .planet(let water) in telescopeCensus where water{
     print("Found a potentially habitable planet!")
}

//3.
let queenAlbums = [
    ("A Night at the Opera", 1974),
    ("Sheer Heart Attack", 1974),
    ("Jazz", 1978),
    ("The Game", 1980)
]

for case (let album,1974) in queenAlbums{
    print("Queen's album \(album) was released in 1974")
}

//4.
let coordinates = (lat: 192.89483, long: -68.887463)

switch coordinates {
case (let lat, _) where lat < 0:
    print("In the Southern hemisphere!")
case (let lat, _) where lat == 0:
    print("Its on the equator!")
case (let lat, _) where lat > 0:
    print("In the Northern hemisphere!")
default:
    break
}

//可选型的本质是一个枚举类型 .some() .none
let names: [String?] = ["Michelle", nil, "Brandon", "Christine", nil, "David"]

for case .some(let name) in names {
    print(name) // 4 times
}



let population = 3

switch population {
case 1:
    print("single")
case 2...3:
    print("a few")  // Printed!
case 4..<6:
    print("several")
default:
    print("many")
}











let coordinate = (x:1,y:0,z:0)

if(coordinate.y == 0 && coordinate.z == 0){
    print("1:point in x-axis")
}

//pattern matching
//concise readable 简洁易读
if case (_,0,0) = coordinate{
    print("2:point in x-axis")
}


//Basic pattern matching
// if guard
func process(point:(x:Int,y:Int,z:Int)) -> String {
    if case (0,0,0) = point {
        return "Origin"
    }
    return "Not origin"
}

let point = (0,0,0)
print(process(point: point))

func guardProcess(point:(x:Int,y:Int,z:Int)) -> String {
    guard case (0,0,0) = point else{
        return "Not origin"
    }
    return "Origin"
}
print(guardProcess(point: point))

//switch
//switch 可以允许多个实例匹配模式,且可以匹配范围(range)
func switchProcess(point:(x:Int,y:Int,z:Int)) -> String {
    let closeRange = -2...2
    let midRange = -5...5
    
    switch point {
    case (0,0,0):
        return "At origin"
    case (closeRange,closeRange,closeRange):
        return "Very close to origin"
    case (midRange,midRange,midRange):
        return "Nearby origin"
    default:
        return "Not near origin"
    }
}

//==========
//WiladCard pattern 通配符模式
if case (_,0,0) = coordinate{
    print("x-axis")
}

//value-binding pattern 值绑定模式
if case (let x,0,0) = coordinate{
    print("x-axis:\(x)")
}
//绑定多个值
if case let(x,y,0) = coordinate{
    print("x:\(x),y:\(y)")
}

//identifier pattern 标识符匹配
let coordinate1 = (x:8,y:0,z:0)
let xValue:Int = 8
if case let(xValue,0,0) = coordinate1{
    print(xValue)
}

enum Direction {
    case north,south,east,west
}

let heading = Direction.south
if case .north = heading{
    print("North")
}else if case .south = heading{
    print("South")
}

enum Organism {
    case plant
    case animal(legs:Int)
}

let pet:Organism = .animal(legs: 4)

switch pet{
case .animal(let legs):
    print("Potentially cuddly with \(legs) legs") // Printed: 4
default:
    print("No chance for cuddles")
}


//is
let array: [Any] = [15, "George", 2.0]
for element in array {
    switch element {
    case is String:
        print("Found a string") // 1 time
    default:
        print("Found something else") // 2 times
    }
}

//as
for element in array {
    switch element {
    case let text as String:
        print("Found a string: \(text)") // 1 time
    default:
        print("Found something else") // 2 times
    }
}


enum LevelStatus {
    case complete
    case inProgress(percent: Double)
    case notStarted
}
let levels: [LevelStatus] = [.complete, .inProgress(percent:
    0.9), .notStarted]
for level in levels {
    switch level {
    case .inProgress(let percent) where percent > 0.8 :
        print("Almost there!")
    case .inProgress(let percent) where percent > 0.5 :
        print("Halfway there!")
    case .inProgress(let percent) where percent > 0.2 :
        print("Made it through the beginning!")
    default:
        break
    } }

if case .animal(let legs) = pet, case 2...4 = legs {
    print("potentially cuddly") // Printed!
} else {
    print("no chance for cuddles")
}


enum Number {
    case integerValue(Int)
    case doubleValue(Double)
    case booleanValue(Bool)
}
let a = 5
let b = 6
let c: Number? = .integerValue(7)
let d: Number? = .integerValue(8)
if a != b {
    if let c = c {
        if let d = d {
            if case .integerValue(let cValue) = c {
                if case .integerValue(let dValue) = d {
                    if dValue > cValue {
                        print("a and b are different") // Printed!
                        print("d is greater than c") // Printed!
                        print("sum: \(a + b + cValue + dValue)") // 26
                    } }
            } }
    } }



if a != b,
    let c = c,
    let d = d,
    case .integerValue(let cValue) = c,
    case .integerValue(let dValue) = d,
    dValue > cValue {
    print("a and b are different") // Printed!
    print("d is greater than c") // Printed!
    print("sum: \(a + b + cValue + dValue)") // Printed: 26
}

//if a != b && c != nil && d != nil{
//
//}


var username: String?
var password: String?

switch (username, password) {
case let (username?, password?):
    print("Success! User: \(username) Pass: \(password)")
case let (username?, nil):
    print("Password is missing. User: \(username)")
case let (nil, password?):
    print("Username is missing. Pass: \(password)")
case (nil, nil):
    print("Both username and password are missing")  // Printed!
}

struct Rectangle {
    let width: Int
    let height: Int
    let color: String
}
let view = Rectangle(width: 15, height: 60, color: "Green")
switch view {
case _ where view.height < 50:
    print("Shorter than 50 units")
case _ where view.width > 20:
    print("Over 50 tall, & over 20 wide")
case _ where view.color == "Green":
    print("Over 50 tall, at most 20 wide, & green") // Printed!
default:
    print("This view can't be described by this example")
}

func fibonacci(position: Int) -> Int {
    switch position {
    // 1
    case let n where n <= 1:
        return 0 // 2
    case 2:
        return 1
    // 3
    case let n:
        return fibonacci(position: n - 1) + fibonacci(position: n - 2)
    }
}
let fib15 = fibonacci(position: 15) // 377

//从1到100，打印数量：•除了在三的倍数，打印“嘶嘶”而不是数量。
//以倍数为五，打印“嗡嗡”而不是数字。
//•对三和五的倍数，打印“FizzBuzz”而不是数量。
for i in 1...100 {
    // 1
    switch (i % 3, i % 5) {
    // 2
    case (0, 0):
        print("FizzBuzz", terminator: " ")
    case (0, _):
        print("Fizz", terminator: " ")
    case (_, 0):
        print("Buzz", terminator: " ")
    // 3
    case (_, _):
        print(i, terminator: " ")
    }
}
print("")


