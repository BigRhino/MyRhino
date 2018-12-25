//
//  main.swift
//  MemoryManage
//
//  Created by iMac on 2017/12/26.
//  Copyright © 2017年 iMac. All rights reserved.
//

import Foundation

//1
//var capture = 0
//var closure = { print(capture) }
//capture = 1
//closure()

//capture list

//0
var capture = 0
//闭包现在将capture的值复制为具有相同名称的新本地变量。结果，原始值0被打印出来。
var closure = { [capture] in print(capture) }
capture = 1
closure()
//对于引用类型，捕获列表将导致闭包捕获并存储存储在捕获变量中的当前引用。通过此引用对对象所做的更改仍然可以在闭包外部可见。

//{
//    [unowned self] in
//    print(self)
//}

func log(message: String) {
    let thread = Thread.current.isMainThread ? "Main"
        : "Background"
    print("\(thread) thread: \(message)")
}
func addNumbers(upTo range: Int) -> Int {
    log(message: "Adding numbers...")
    return (1...range).reduce(0, +)
}

let queue = DispatchQueue(label: "queue")

//1.泛型函数 @escaping 可逃匿的
func execute<Result>(
    //后台任务
    backgroundWork: @escaping () -> Result,
    // 2  主线程任务closure
    mainWork: @escaping (Result) -> ()) {
    
    //异步执行
    queue.async {
        let result = backgroundWork()
        // 3
        DispatchQueue.main.async {
            //回到主线程
            mainWork(result)
        }
    }
}

//PlaygroundPage.current.needsIndefiniteExecution = true


execute(backgroundWork: { addNumbers(upTo: 100) },
            mainWork:       { log(message: "The sum is \($0)") }
)

while true {}

