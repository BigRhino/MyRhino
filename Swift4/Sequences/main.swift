//
//  main.swift
//  Sequences
//
//  Created by iMac on 2017/12/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation
/*
 
                              Sequence
                                  |
                             Collection
         |                        |                          |
 MutableCollection     RandomAccessCollection    RangeReplaceableCollection

 */


struct CountDown:Sequence{
    
    let start:Int
    
    //构造器
    func makeIterator() -> CountDownInterator {
        return CountDownInterator(self)
    }
}

struct CountDownInterator:IteratorProtocol {
    
    let countdown:CountDown
    var times = 0
    
    init(_ countdown:CountDown) {
        self.countdown = countdown
    }
    
    mutating func next() -> Int? {
        let nextNumber = countdown.start - times
        guard nextNumber > 0 else{
            return nil
        }
        times += 1
        return nextNumber
    }
    
}

var ct = CountDown(start: 5)
for item in ct{
    print(item)
}

