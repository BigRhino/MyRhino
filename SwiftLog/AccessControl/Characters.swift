//
//  Characters.swift
//  AccessControl
//
//  Created by iMac on 2017/12/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//角色类型
public enum GameCharacterType {
    case elf,giant,wizard
}

//协议
public protocol GameCharacter:class{
    //角色名称
    var name:String{get}
    //生命值
    var hitPoints:Int{get set}
    //攻击力
    var attackPoints:Int{get}
}

class Giant: GameCharacter {
    let name:String = "Giant"
    var hitPoints: Int = 10
    var attackPoints: Int = 3
}
class Elf: GameCharacter {
    
    let name:String = "Elf"
    var hitPoints: Int = 3
    var attackPoints: Int = 10
}

class Wizard: GameCharacter {
    
    let name:String = "Wizard"
    var hitPoints: Int = 5
    var attackPoints: Int = 5
}
//工厂类
public struct GameCharacterFactory {
    
    static public func make(ofType:GameCharacterType) -> GameCharacter {
        switch ofType {
        case .elf:
            return Elf()
        case .giant:
            return Giant()
        case .wizard:
            return Wizard()
        }
    }
}

public func battle(_ character1:GameCharacter,vs character2:GameCharacter) {
    character2.hitPoints -= character1.attackPoints
    if character2.hitPoints <= 0 {
        print("\(character2.name) defeated!")
        return
    }
    character1.hitPoints -= character2.attackPoints
    if character1.hitPoints <= 0 {
        print("\(character1.name) defeated!")
    }else{
        print("Both players still active!")
    }
}
