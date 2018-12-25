//
//  main.swift
//  AccessControl
//
//  Created by iMac on 2017/12/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//访问控制
//在属性、方法或类型声明前面放置修饰符关键字来添加访问控制



protocol Account {
    
    associatedtype Currency
    //余额
    var balance:Currency{get}
    //充值
    func deposit(amount:Currency)
    //提现
    func withdraw(amount:Currency)
}

class BasicAccount: Account {
    typealias Currency = Double
    private(set) var balance: Double = 0.0
    
    func deposit(amount: Double) {
       balance += amount
    }
    func withdraw(amount: Double) {
        if amount <= balance {
            balance -= amount
        }else{
            balance = 0
        }
    }
}

let account = BasicAccount()
account.deposit(amount: 20000.0)
account.withdraw(amount: 5000.0)
//外部私有
//account.balance = 10000.0

typealias Dollars = Double

class CheckingAccount: BasicAccount {
    
    private let accountNumber = UUID().uuidString
    
    //嵌套类
    class Check {
        let account: String
        var amount: Dollars
        //只能在当前作用域访问
        private(set) var cashed = false
        func cash() {
            cashed = true
        }
        init(amount: Dollars, from account: CheckingAccount) {
            self.amount = amount
            self.account = account.accountNumber
        }
    }
    
    func writeCheck(amount: Dollars) -> Check? {
        guard balance > amount else {
            return nil
        }
        let check = Check(amount: amount, from: self)
        withdraw(amount: check.amount)
        return check
    }
    func deposit(_ check: Check) {
        guard !check.cashed else {
            return
        }
        deposit(amount: check.amount)
        check.cash()
    }
}


//单例

class Logger {
    //构造器私有,外部不能访问
    private init(){}
    //单例
    static let sharedInstance = Logger()
    func log(_ text:String) {
        print(text)
    }
}

Logger.sharedInstance.log("Singleton")

//Logger()
//'Logger' initializer is inaccessible due to 'private' protection level


//栈 FIFO
struct Stack<Element> {
    
    private var array:[Element] = []
    
     func peek() -> Element? {
      return array.last
    }
    
    mutating func push(_ element:Element) {
       array.append(element)
    }
    mutating func pop() ->Element? {
        if array.isEmpty {
            return nil
        }
        return array.removeLast()
    }
    func count() -> Int {
        return array.count
    }
}

var strings = Stack<String>()

strings.push("Great!")
strings.push("is")
strings.push("Swift")

//strings.elements.removeAll() // The implementation details of `Stack` are hidden.

print(strings.peek() ?? "nil")

while let string = strings.pop() {
    Logger.sharedInstance.log(string)
}


//3.
let elf = GameCharacterFactory.make(ofType: .elf)
let giant = GameCharacterFactory.make(ofType: .giant)
let wizard = GameCharacterFactory.make(ofType: .wizard)

battle(elf, vs: giant)
battle(wizard, vs: giant)
battle(wizard, vs: elf)


//4.
let p = Person(first: "张", last: "红波")
print(p.fullName())

class Doctor:ClassPerson{
    
}
