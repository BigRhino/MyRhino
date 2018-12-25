//
//  NotificationViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserverKeyboard()
    }
    
    func addObserverKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationViewController.keyboardShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(NotificationViewController.keyboardDimiss(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            //释放第一响应者
            textField.resignFirstResponder()
            return false
        }
        return true
    }
    //结束键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @objc func keyboardShow(_ notification:NSNotification) {
        print("keyboard will show!")
    }
    
    @objc func keyboardDimiss(_ notification:NSNotification) {
        print("keyboard will dimiss!")
    }
    
    deinit {
        
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
