//
//  main.swift
//  Memory
//
//  Created by iMac on 2017/11/16.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

///1
var bob:Person? = Person(name: "Bob")
print("created \(bob)")


var laptop:Asset? = Asset(name: "Shiny Laptop", value: 1_500.0)
var hat:Asset? = Asset(name: "Cowboy Hat", value: 175.0)
var backpack:Asset? = Asset(name: "Blue Backpack", value: 45.0)

bob?.takeOwnership(of: laptop!)
bob?.takeOwnership(of: hat!)

bob = nil

laptop = nil
hat = nil
backpack = nil




