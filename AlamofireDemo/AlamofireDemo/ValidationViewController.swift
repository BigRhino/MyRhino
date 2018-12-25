//
//  ValidationViewController.swift
//  AlamofireDemo
//
//  Created by iMac on 2017/12/15.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
import Alamofire

class ValidationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       automaticValidation()
        
    }
   //验证
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        Alamofire.request("https://httpbin.org/get")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { (response) in
                switch response.result{
                case .success(let value):
                    print("Valutation Success")
                    print(String(data: value, encoding: .utf8) ?? "")
                case .failure(let error):
                    print("Error:\(error))")
                }
        }
    }
    
    func automaticValidation()  {
        
        Alamofire.request("https://httpbin.org/get").validate().responseJSON { (response) in
            switch response.result{
            case .success:
                print("Valutation Success")
                print(response.result.value ?? "")
            case .failure(let error):
                print("Error:\(error))")
            }
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
