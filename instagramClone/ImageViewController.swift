//
//  ViewController.swift
//  instagramClone
//
//  Created by Lindsey on 6/21/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate{

    @IBOutlet weak var imageView: UIImageView!
   
    
    lazy var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
        
       // presentActionSheet()
        
    }
    
    func setupAppearance(){
        self.imageView.layer.cornerRadius = 5.0
        
    }
    func setup(){
        self.tabBarItem.title = "Add Photo"
        
        
    }
    
    func presentActionSheet(){
        let actionSheet = UIAlertController(title: "Find Image", message: "Do you want to use your camera or photo library?", preferredStyle: .Alert)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            self.presentImagePicker(.Camera)
        }
        
        let photosAction = UIAlertAction(title: "Photos", style: .Default) { (action) in
            self.presentImagePicker(.PhotoLibrary)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(photosAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    
    func presentImagePicker(sourceType:UIImagePickerControllerSourceType){
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    @IBAction func AddButtonSelected(sender: AnyObject) {
        if UIImagePickerController .isSourceTypeAvailable(.Camera){
            self.presentActionSheet()
        }else{
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
//    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        if UIImagePickerController .isSourceTypeAvailable(.Camera){
//            self.presentActionSheet()
//            }else{
//                self.presentImagePicker(.PhotoLibrary)
//            }
//        }
}

