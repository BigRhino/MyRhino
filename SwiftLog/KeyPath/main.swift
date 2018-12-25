//
//  main.swift
//  KeyPath
//
//  Created by iMac on 2017/12/21.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

class Person{
    let name:String
    let age:Int
    
    init(name:String,age:Int) {
        self.name = name
        self.age = age
    }
}

class Tutorial {
    
    let title:String
    let author:Person
    let type:String
    let publishDate:Date
    init(title:String,author:Person,type:String,publishDate:Date) {
        self.title = title
        self.author = author
        self.type = type
        self.publishDate = publishDate
    }
    
}
let me = Person(name: "Me", age: 24)
let tuto:Tutorial = Tutorial(title: "Object Oriented Programming in Swift", author: me, type: "Swift", publishDate: Date())
//MARK:获取相关
//其实就是OC的KVC,只不过OC是使用字符串,不会进行相关检查和智能提示
//实现通过下标subscripts访问

//使用keypath
let title = \Tutorial.title
let tutorialTitle = tuto[keyPath:title]
print(tutorialTitle)

//多层次访问
print(tuto[keyPath:\Tutorial.author.name])

//Appending keypaths 拼接keypath appending(path:)
let authorPath = \Tutorial.author
let authorNamePath = authorPath.appending(path: \Person.name)
print(tuto[keyPath:authorNamePath])


//MARK:设置属性

class Jukebox:CustomStringConvertible{
    var song:String
    init(song:String) {
        self.song = song
    }
    var description: String{
        return "[Jukebox]{song : \(song)}"
    }
}

let jukebox = Jukebox(song: "Nothing else matters")
jukebox[keyPath:\Jukebox.song] = "Hello"

print(jukebox)

