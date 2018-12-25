//
//  Person.swift
//  AccessControl
//
//  Created by iMac on 2017/12/20.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

public struct Person {
    
    public private(set) var first:String
    public private(set) var last:String
    
    public init(first:String,last:String){
        self.first = first
        self.last = last
    }
    
    public var fullName:String{
        return first + " " + last
    }
}

open class ClassPerson{
    
    public private(set) var first:String
    public private(set) var last:String
    
    public init(first:String,last:String){
        self.first = first
        self.last = last
    }
    
    open var fullName:String{
        return first + " " + last
    }
}


