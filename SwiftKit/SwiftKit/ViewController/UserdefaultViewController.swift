//
//  UserdefaultViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class UserdefaultViewController: UIViewController {

  
    let switchKey:String = "SwitchState"
    let userdefault = UserDefaults.standard
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //读取状态
       // if let isOn =  {
        //返回关联的值,不存在返回false
            mySwitch.isOn = userdefault.bool(forKey: switchKey)
      //  }
        
        addSubview()
        
    }

    @IBAction func MySwitch(_ sender: UISwitch) {
        
        if sender.isOn{
            userdefault.set(true, forKey: switchKey)
        }else{
            userdefault.set(false, forKey: switchKey)
        }
    }
    
    
    func addSubview() -> Void{
        let sw = UISwitch(frame: CGRect(x: 40, y: 100, width: 60, height: 30))
        self.view.addSubview(sw)
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
