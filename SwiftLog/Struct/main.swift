//
//  main.swift
//  Struct
//
//  Created by iMac on 2017/11/7.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//Range 泛型Struct

//半开区间
let underFive =	0.0..<5.0

//检查是否包含某个值
print(underFive.contains(5.0))
print(underFive.contains(0.0))
print(underFive.contains(6))

//空区间
let empty = 0.0..<0.0
print(empty.isEmpty)


let company = Location(coordinateString: "189.00441 , 47.54444")
print(company.longitude,company.latitude)

