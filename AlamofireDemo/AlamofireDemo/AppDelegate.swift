//
//  AppDelegate.swift
//  AlamofireDemo
//
//  Created by iMac on 2017/12/15.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
import Alamofire


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        networkingObersver()
        
        
        return true
    }

    //网络监测
    func networkingObersver(){
        //创建网络监听对象
        let manage = NetworkReachabilityManager(host: "www.apple.com")
        //开启监听
        manage?.startListening()
        
        //闭包 (status 枚举)
        manage?.listener = { status in
            print(">>>>> Network Status Changed: \(status)")
            print("isReachable:\(String(describing: manage?.isReachable))")
            print("isReachableOnWWAN:\(String(describing: manage?.isReachableOnWWAN))")
            print("isReachableOnEthernetOrWiFi:\(String(describing: manage?.isReachableOnEthernetOrWiFi))")
            print("networkReachabilityStatus:\(String(describing: manage?.networkReachabilityStatus))")

            switch status {
            case .reachable(.wwan):
                print("你正在使用移动网络")
            case .reachable(.ethernetOrWiFi):
                print("WiFi")
            case .notReachable:
                print("断网了,包租婆")
            case .unknown:
                print("你是火星来的吧~")
            }
        }
        //停止监听
//        manage?.stopListening()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

