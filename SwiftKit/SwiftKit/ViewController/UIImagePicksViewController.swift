//
//  UIImagePicksViewController.swift
//  SwiftKit
//
//  Created by iMac on 2017/11/17.
//  Copyright © 2017年 iMac. All rights reserved.
//

import UIKit
import MediaPlayer
import MobileCoreServices



class UIImagePicksViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func buttonClick(_ sender: UIButton) {
        
        let imagePick:UIImagePickerController = UIImagePickerController()
        imagePick.sourceType = UIImagePickerControllerSourceType.camera
        imagePick.delegate = self
        
        imagePick.mediaTypes = [kUTTypeImage as String]
        imagePick.showsCameraControls = true
        imagePick.allowsEditing = false
        
        self.present(imagePick, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        let image:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imageData = UIImagePNGRepresentation(image)! as Data
        
        UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        let filePath = (documentsPath! as NSString).appendingPathComponent("Pic.png")
        try? imageData.write(to: URL(fileURLWithPath: filePath), options: [.atomic])
     
        imageView.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer?, contextInfo: UnsafeRawPointer){
        if(error != nil){
            print("ERROR IMAGE \(error.debugDescription)")
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
