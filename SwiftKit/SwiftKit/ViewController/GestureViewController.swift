//
//  GestureViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/11.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit

class GestureViewController: UIViewController {

    var netRotation:CGFloat = 0
    var lastScaleFactor:CGFloat = 1
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGesture()
    }

    func addGesture() {
        
        //旋转
        let rotation = UIRotationGestureRecognizer(target: self, action: #selector(GestureViewController.rotatingGesture(_:)))
        imageView.addGestureRecognizer(rotation)
        
        //Swip
        let swipleft = UISwipeGestureRecognizer(target: self, action: #selector(GestureViewController.swipGesture(_:)))
        swipleft.direction = UISwipeGestureRecognizerDirection.left
        imageView.addGestureRecognizer(swipleft)
        
        let swipright = UISwipeGestureRecognizer(target: self, action: #selector(GestureViewController.swipGesture(_:)))
        swipright.direction = UISwipeGestureRecognizerDirection.right
        imageView.addGestureRecognizer(swipright)
        
        
        let swipdown = UISwipeGestureRecognizer(target: self, action: #selector(GestureViewController.swipGesture(_:)))
        swipdown.direction = .down
        imageView.addGestureRecognizer(swipdown)
        
        let swipup = UISwipeGestureRecognizer(target: self, action: #selector(GestureViewController.swipGesture(_:)))
        swipup.direction = .up
        imageView.addGestureRecognizer(swipup)
        
        //longPress
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(GestureViewController.longPressGesture(_:)))
        longPress.minimumPressDuration = 2.2
        imageView.addGestureRecognizer(longPress)
        
        //Double
        let tap = UITapGestureRecognizer(target: self, action: #selector(GestureViewController.tapGesture(_:)))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
        
        ///pinch
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GestureViewController.pinchGesture(_:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    @objc func pinchGesture(_ sender:UIPinchGestureRecognizer){
    
        let factor = sender.scale
        if factor > 1{
            sender.view?.transform = CGAffineTransform(scaleX: lastScaleFactor + (factor - 1), y: lastScaleFactor + (factor - 1))
        }else{
            sender.view?.transform = CGAffineTransform(scaleX: lastScaleFactor * factor, y: lastScaleFactor * factor)
        }
        
        if (sender.state == .ended) {
            if(factor > 1){
               lastScaleFactor += (factor-1)
            }else{
               lastScaleFactor *= factor
            }
        }
    }
    @objc func tapGesture(_ sender:UITapGestureRecognizer){
    
        if sender.view?.contentMode == UIViewContentMode.scaleAspectFit{
            sender.view?.contentMode = UIViewContentMode.center
        }else{
            sender.view?.contentMode = UIViewContentMode.scaleAspectFit
        }
    }
    
    
    
    @objc func rotatingGesture(_ sender:UIRotationGestureRecognizer)  {
        let rotation:CGFloat = sender.rotation
        let transform:CGAffineTransform = CGAffineTransform(rotationAngle: rotation + netRotation)
        sender.view?.transform = transform
        if sender.state == UIGestureRecognizerState.ended {
            netRotation += rotation
        }
    }
    
    @objc func swipGesture(_ sender:UISwipeGestureRecognizer){
        
        changeImage()
        switch sender.direction {
        case .left:
            print("left~")
        case .right:
            print("right~")
        case .up:
            print("up~")
        default:
            print("bottom~")
        }
        
    }
    func changeImage() {
        if imageView.image == UIImage(named:"image1.png"){
            imageView.image = UIImage(named: "image2.png")
        }else{
            imageView.image = UIImage(named: "image1.png")
        }
    }
    @objc func longPressGesture(_ sender:UILongPressGestureRecognizer){
     
        if (sender.state == UIGestureRecognizerState.began){
            let alertController = UIAlertController(title: "", message: "是否保存该图片到相册", preferredStyle: UIAlertControllerStyle.alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (_) in
                print("取消")
            }
            alertController.addAction(cancelAction)
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                print("保存")
            }
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true) {
                
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
