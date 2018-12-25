//
//  URLSessionViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class URLSessionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let sessionConfiguration:URLSessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.allowsCellularAccess = false
        sessionConfiguration.httpAdditionalHeaders = ["Accept":"application/json"]
        
        sessionConfiguration.timeoutIntervalForRequest = 30.0
        sessionConfiguration.timeoutIntervalForResource = 60.0
        sessionConfiguration.httpMaximumConnectionsPerHost = 1
        
        let session = URLSession(configuration: sessionConfiguration)

        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Barcelona,es&appid=ac02dc102cc17b974cd84206048d97d8")!
        
        print(url.absoluteString) //网址
        print(url.scheme)  //http Optional("http")
        print(url.host)  //api.openweathermap Optional("api.openweathermap.org")
        print(url.path)  // /data/2.5/weather
        print(url.query) // 参数 Optional("q=Barcelona,es&appid=ac02dc102cc17b974cd84206048d97d8")
        print(url.baseURL) //nil
        
        session.dataTask(with:url) { (data, response, error) in
            if error != nil{
                return
            }
            let  json:NSDictionary = ((try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions(rawValue:0))) as? NSDictionary)! as NSDictionary
            if json.count == 0{
                return
            }
            
           // print(json)
            DispatchQueue.main.async {
                self.textView.text = json.description
            }
            
        }.resume()
        
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
