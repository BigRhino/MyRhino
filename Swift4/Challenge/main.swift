//
//  main.swift
//  Challenge
//
//  Created by iMac on 2017/12/25.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

/*
struct Spaceship:Codable{
    var name:String
    var crew:[Spaceman]
    
    enum CodeKeys:String,CodingKey {
        case name = "spaceship_name"
        case crew
    }
}

struct Spaceman:Codable{
    var name:String
    var race:String
}



let space = Spaceman(name: "SpaceMan", race: "32")
let space2 = Spaceman(name: "King", race: "22")
let spaceShip = Spaceship(name: "Ship", crew: [space,space2])

let jsonEncoder = JSONEncoder()
let data = try jsonEncoder.encode(spaceShip)

print(String(data: data, encoding: .utf8) ?? "nil")

let jsonDecoder = JSONDecoder()
let newSp = try jsonDecoder.decode(Spaceship.self, from: data)
print(newSp)
*/

struct Spaceship:Codable{
    var name:String
    var crew:[Spaceman]
    
    enum SpaceshipKeys:String,CodingKey {
        case name = "spaceship_name"
        case crew
    }
    enum CrewKeys:String,CodingKey{
        case captain
        case officer
    }
    
}

struct Spaceman:Codable{
    var name:String
    var race:String

}

let message = "{\"spaceship_name\":\"USS Enterprise\", \"captain\":{\"name\":\"Spock\",\"race\":\"Human\"}, \"officer\":{\"name\": \"Worf\", \"race\":\"Klingon\"}}"

extension Spaceship{
    init(from decoder: Decoder) throws{
    var container = try decoder.container(keyedBy: SpaceshipKeys.self)
       try container.decode(name, forKey: .name)
    var value = try decoder.container(keyedBy: CrewKeys.self)
        let captain = try value.decode(Spaceman.self, forKey: .captain)
    }
}


