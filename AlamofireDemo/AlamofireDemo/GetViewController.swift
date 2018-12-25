//
//  GetViewController.swift
//  AlamofireDemo
//
//  Created by iMac on 2017/12/15.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
import Alamofire

class GetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        //网络请求并处理从服务器返回的JSON数据
//        Alamofire.request("https://httpbin.org/get").responseJSON { (response) in
//
//            //网络请求对象
//            print("response.request:" + String(describing: response.request))
//            //网络返回对象
//            print("response.response:" + String(describing: response.response))
//
//            //服务器返回的数据
//            print("response.data:" + String(describing: response.data))
//            //对象序列化后的结果
//            print("response.result:" + String(describing: response.result))
//
//            if let json = response.result.value{
//                print("JSON:\(json)")
//            }
//
//        }
//
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       responseHandler()
    }
    
    func responseHandler() -> Void {
        
        Alamofire.request("https://httpbin.org/get").response { (response) in
            print("Request: \(String(describing: response.request))")
            print("Response: \(String(describing: response.response))")
            print("Error: \(String(describing: response.error))")
            
            if let data = response.data,let utf8Text = String(data: data, encoding: .utf8){
                print("Data:\(utf8Text)")
            }
        }
    }
    
    func responseStringHandler() {
        Alamofire.request("https://httpbin.org/get").responseString { (response) in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(String(describing: response.result.value))")
        }
    }
    
    func responseDataHandler() {
        Alamofire.request("https://httpbin.org/get").responseData { (response) in
            debugPrint("All Response Info: \(response)")
            
            if let data = response.result.value,let utf8Text = String.init(data: data, encoding: .utf8){
                print("Data:\(utf8Text)")
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
