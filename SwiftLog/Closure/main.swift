//
//  main.swift
//  Closure
//
//  Created by iMac on 2017/11/8.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

let volunteerCounts = [1,340,32,2,53,77,14]

func sortAsending(_ i:Int,_ j:Int) -> Bool{
    return i < j
}

//print(volunteerCounts.sorted(by: sortAsending))


print(volunteerCounts.sorted(by: { (a, b) -> Bool in
    return a > b
}))

print(volunteerCounts.sorted(by: { i,j in
    i > j
}))

print(volunteerCounts.sorted(by: {$0 < $1}))

print(volunteerCounts.map({ (number) -> Int in
    return number * 10
})
)



func makeTownGrand() -> (Int,Int) ->Int{
    
    func buildRoads(byAddingLights lights:Int,
                    toExistingLights existingLights:Int)->Int{
        return lights + existingLights
    }
    
    return buildRoads
}

var stoplights = 4
let townPlanByAddingLightsToExistingLights = makeTownGrand()

stoplights = townPlanByAddingLightsToExistingLights(4, stoplights)

print("Knowhere has \(stoplights) stoplights.")

//逃匿闭包
//当一个闭包作为函数的参数,这个闭包在函数执行返回之后,才执行,就叫做逃匿闭包








