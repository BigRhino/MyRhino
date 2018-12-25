//
//  UIAlertViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/10.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class UIAlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor("ff22cc")
    }

    @IBAction func Alert(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (_) in
            print("你点击了取消~")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_) in
            print("你点击了确认")
        }
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    @IBAction func AlertSheet(_ sender: Any) {
        
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (_) in
            print("你点击了取消~")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_) in
            print("你点击了确认")
        }
        alertController.addAction(okAction)
        
        let desAction = UIAlertAction(title: "Destroy", style: .destructive) { (_) in
            print("点击了destructive~")
        }
        alertController.addAction(desAction)
        
        self.present(alertController, animated: true) {
            
        }
    }
    
    @IBAction func AalertConfirm(_ sender: Any) {
        
        let alertController = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel) { (_) in
            print("你点击了取消~")
        }
        alertController.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (_) in
            print("你点击了确认")
            
            let userName = alertController.textFields![0].text
            let password = alertController.textFields![1].text
            
            print("userName:\(userName ?? ""),password:\(password ?? "")")
        }
        
        alertController.addAction(okAction)
        
        
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = "User"
            textField.isSecureTextEntry = false
        }
        
        alertController.addTextField { (textField:UITextField) in
            textField.placeholder = "password"
            textField.isSecureTextEntry = true
        }
        
        
        self.present(alertController, animated: true) {
            
        }
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
