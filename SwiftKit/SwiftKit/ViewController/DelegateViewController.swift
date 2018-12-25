//
//  DelegateViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class DelegateViewController: UIViewController,MyDelegate {

 //   lazy var object:MyObject = MyObject()
    
    lazy var object: MyObject = {
        let o = MyObject()
        o.delegate = self
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.object.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.object.start()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.object.end()
    }
    
    
    func printLog() {
        print("#########################")
        print("@@@@@@@@@@@@@@@@@@@@@@@@@")
    }
    
    func endPrint() {
        print("~~~~~~~~~~~~~~~~")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
