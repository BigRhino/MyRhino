//
//  main.swift
//  Enumator
//
//  Created by iMac on 2017/11/9.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

enum Movement{
    case Left,Right,Top,Bottom
}

let aMovement = Movement.Left

//模式匹配
switch aMovement{
case .Left:print("left")
default:
    print(aMovement)
}

//类型 自动推断
if case .Left = aMovement{
    print("Left!")
}

enum MovementInt:Int {
    case Left = 2
    case Right = 4
    case Top
    case Bottom
}

enum House:String {
    case Baratheon = "Ours is the Fury"
    case Greyjoy = "We Do Not Sow"
    case Martell = "Unbowed, Unbent, Unbroken"
    case Stark = "Winter is Coming"
    case Tully = "Family, Duty, Honor"
    case Tyrell
}


// 或者float double都可以(同时注意枚举中的花式unicode)
enum Constants: Double {
    case π = 3.14159
    case e = 2.71828
    case φ = 1.61803398874
    case λ = 1.30357
}
//整型(Integer) 浮点数(Float Point) 字符串(String) 布尔类型(Boolean)

let aConstants = Constants.λ
print(aConstants.rawValue)

//通过RawValue的构造函数
print(House.RawValue("Tyrell"))

//可失败的构造函数
print(House(rawValue: "We Do Not Sow") ?? .Tully)


//嵌套枚举

enum Character {
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    enum Helmet {
        case Wooden
        case Iron
        case Diamond
    }
    case Thief
    case Warrior
    case Knight
}

//通过层级结构来描述角色允许访问的项目条
let character = Character.Thief
let weapon = Character.Weapon.Bow
let helmet = Character.Helmet.Iron


//内嵌枚举
struct Characters {
    enum CharacterType {
        case Thief
        case Warrior
        case Knight
    }
    enum Weapon {
        case Bow
        case Sword
        case Lance
        case Dagger
    }
    let type: CharacterType
    let weapon: Weapon
}

let warrior = Characters(type: .Warrior, weapon: .Sword)













