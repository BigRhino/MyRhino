//
//  main.swift
//  Codable
//
//  Created by iMac on 2017/12/23.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//public typealias Codable = Decodable & Encodable

struct Employee:Codable{
    var name:String
    var id:Int
    
    //包含其他类型
    var favoriteToy:Toy
    
    //遵循CodingKey协议,允许你重命名属性在序列化时字段不匹配的情况
    enum CodingKeys:String,CodingKey {
        case id = "employeeId"
        case name
        case favoriteToy
    }
    
    /*/
     1.是嵌套枚举类型
     2.必须遵循CodingKey协议
     3.原始类型必须是String,因为属性的key是String
     4.在这个枚举中,必须包含所有的属性,尽管有的你不需要重命名
     5.默认情况下,这个枚举由编译器创建,当你需要重命名时需要自己实现
    */
}

struct Toy:Codable {
    var name:String
}

//MARK: JSONEncoder and JSONDecoder

let toy1 = Toy(name: "Teddy Bear")
let employee1 = Employee(name: "John Appleseed", id: 7, favoriteToy: toy1)

//编码
let jsonEncoder = JSONEncoder()
let jsonData = try jsonEncoder.encode(employee1)
print(jsonData)
//Data 只打印了其字节数. 可以转成字符串
let jsonString = String(data:jsonData,encoding:.utf8)
print(jsonString ?? "nil")


let jsonDecoder = JSONDecoder()
let employee2 = try jsonDecoder.decode(Employee.self, from: jsonData)
print(employee2)


//MARK:Renaming properties with CodingKeys 重命名属性

//{ "employeeId": 7, "name": "John Appleseed", "gift": "Teddy Bear" }

struct Employees{
    var name:String
    var id:Int
    
    //包含其他类型
    var favoriteToy:Toy
    
    //遵循CodingKey协议,允许你重命名属性在序列化时字段不匹配的情况
    enum CodingKeys:String,CodingKey {
        case id = "employeeId"
        case name
        case gift
    }
}

//结构改变时,需要自己编写编解码的逻辑
extension Employees: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(favoriteToy.name, forKey: .gift)
    }
}

extension Employees: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        id = try values.decode(Int.self, forKey: .id)
        let gift = try values.decode(String.self, forKey: .gift)
        favoriteToy = Toy(name: gift)
    } }

