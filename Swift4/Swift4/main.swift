//
//  main.swift
//  Swift4
//
//  Created by iMac on 2017/12/22.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//Error Handing
/*
 非正式:
 1.可失败的构造方法
 2.可选型的强制解包,可选链条
 3.map与flatMap
 正式:
 1.Error Protocol
 2.抛出异常
*/

//糕点
class Pastry {
    //味道
    let flavor:String
    //数量
    var numberOnHand:Int
    
    init(flavor:String,numberOnHand:Int) {
        self.flavor = flavor
        self.numberOnHand = numberOnHand
    }
}

//Error协议告诉编译器,这个枚举可以用来表示抛出的错误
//面包店错误
enum BakeryError:Error {
    //太少
    case tooFew(numberOnHand:Int)
    //不全部出售
    case doNotSell
    //口味不适合
    case wrongFlavor
}

//面包店
class Bakery {
    //出售的商品
    var itemsForSale = ["Cookie":Pastry(flavor: "ChocolateChip", numberOnHand: 20),
                        "PopTart":Pastry(flavor: "WildBerry", numberOnHand: 13),
                        "Donut":Pastry(flavor: "Sprinkles", numberOnHand: 24),
                        "Handpie":Pastry(flavor: "Cherry", numberOnHand: 6)
                        ]
    //甜甜圈 -
    //手饺馅(xian)饼   - 樱桃
    //出售糕点 (糕点名字,需求数量,口味)
    func orderPastry(item:String,
                     amountRequested:Int,
                     flavor:String) throws -> Int {
        //检查是否有该糕点
        guard let pastry = itemsForSale[item] else {
            throw BakeryError.doNotSell
        }
        //检查口味是否相同
        guard flavor == pastry.flavor else {
            throw BakeryError.wrongFlavor
        }
        //检查库存
        guard amountRequested <= pastry.numberOnHand else {
            throw BakeryError.tooFew(numberOnHand: pastry.numberOnHand)
        }
        
        pastry.numberOnHand -= amountRequested
        return pastry.numberOnHand
    }
    
}

let bakery = Bakery()
//抛出错误的方法,必须捕捉异常
//bakery.orderPastry(item: "Albatross", amountRequested: 1, flavor: "AlbatrossFlavor")
do{
  try bakery.orderPastry(item: "Albatross",
                       amountRequested: 1,
                       flavor: "AlbatrossFlavor")
}catch BakeryError.doNotSell{
    print("Sorry,but we don't sell this item")
}catch BakeryError.wrongFlavor{
    print("Sorry, but we don't carry this flavor")
}catch BakeryError.tooFew{
    print("Sorry, we don't have enough items to fulfill your order")
}

//不关心错误
let remaining = try? bakery.orderPastry(item: "Albatross",
                                        amountRequested: 1,
                                        flavor: "AlbatrossFlavor")
//optional
print(remaining)


//fatalError()
//try? try!
let number = try! bakery.orderPastry(item: "Cookie",
                           amountRequested: 1,
                           flavor: "ChocolateChip")
print(number)





enum Direction {
    case left,right,forward
}

enum PugBotError:Error {
    case invalidMove(found:Direction,expected:Direction)
    case endOfPath
}

class PugBot {
    let name:String
    let correctPath:[Direction]
    private var currentStepInPath = 0
    
    init(name:String,correctPath:[Direction]) {
        self.correctPath = correctPath
        self.name = name
    }
    
    func turnLeft() throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == .left  else {
            throw PugBotError.invalidMove(found: .left, expected: nextDirection)
        }
        currentStepInPath += 1
    }
    func turnRight() throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == .right else {
            throw PugBotError.invalidMove(found: .right,
                                          expected: nextDirection)
        }
        currentStepInPath += 1
    }
    func moveForward() throws {
        guard currentStepInPath < correctPath.count else {
            throw PugBotError.endOfPath
        }
        let nextDirection = correctPath[currentStepInPath]
        guard nextDirection == .forward else {
            throw PugBotError.invalidMove(found: .forward,
                                          expected: nextDirection)
        }
        currentStepInPath += 1
    }
    func reset() {
        currentStepInPath = 0
    }
}
let pug = PugBot(name: "Pug",
                 correctPath: [.forward, .left, .forward, .right])

func goHome() throws {
    try pug.turnLeft()
    try pug.moveForward()
    try pug.moveForward()
    try pug.turnRight()
}

do {
    try goHome()
} catch {
    print("PugBot failed to get home.")
}

func moveSafely(_ movement: () throws -> ()) -> String {
    do {
        try movement()
        return "Completed operation successfully."
    } catch PugBotError.invalidMove(let found, let expected) {
        return "The PugBot was supposed to move \(expected), but moved \(found) instead."
    } catch PugBotError.endOfPath {
        return "The PugBot tried to move past the end of the path."
    } catch {
        return "An unknown error occurred"
    }
}

pug.reset()
print(moveSafely(goHome))



pug.reset()
print(moveSafely {
    try pug.moveForward()
    try pug.turnLeft()
    try pug.moveForward()
    try pug.turnRight()
})

//以抛出闭包作为参数的函数必须做出选择：要么捕获每个错误，要么抛出函数本身。

//假设您希望实用函数在一行中执行多次运动或一组运动。您可以将此函数定义如下：
func perform(times: Int, movement: () throws -> ()) rethrows {
    for _ in 1...times {
        try movement()
    }
}
///这个函数表明，只会引发错误的功能被传递到它，但从来没有自己的错误。
//rethrows这个函数如果抛出异常，仅可能是因为传递给它的闭包的调用导致了异常。如果闭包的调用没有导致异常，编译器就知道这个函数不会抛出异常。那么我们也就不用去处理异常了。

//@noescape 专门用于修饰函数闭包这种参数类型的，当出现这个参数时，它表示该闭包不会跳出这个函数调用的生命期：即函数调用完之后，这个闭包的生命期也结束了
//@autoclosure

//throws 关键字表示：这个函数（闭包）可能抛出异常。而 rethrows 关键字表示：这个函数如果抛出异常，仅可能是因为传递给它的闭包的调用导致了异常。

//throws 关键字的存在大家都应该能理解，因为总有一些异常可能在设计的时候希望暴露给上层，throws 关键字的存在使得这种设计成为可能。
//
//那么为什么会有 rethrows 关键字呢？在我看来，这是为了简化很多代码的书写。因为一旦一个函数会抛出异常，按 Swift 类型安全的写法，我们就需要使用 try 语法。但是如果很多地方都需要写 try 的话，会造成代码非常啰嗦。 rethrows 关键字使得一些情况下，如果你传进去的闭包不会抛出异常，那么你的调用代码就不需要写 try。













