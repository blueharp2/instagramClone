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
    @IBOutlet weak var addButton: UIButton!
   
    
    lazy var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAppearance()
        
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

    
    @IBAction func editButtonSelected(sender: AnyObject) {
        
        guard let image = self.imageView.image else {return}
        
        let actionSheet = UIAlertController(title: "Filters", message: "Choose Your Filter", preferredStyle: .ActionSheet)
        
        let filterOne = UIAlertAction(title: "Vintage", style: .Default) { (action) in
            Filters.shared.vintage(image) {(theImage) in
                self.imageView.image = theImage
            }
        }
        let filterTwo = UIAlertAction(title: "Tonal", style: .Default) { (action) in
            Filters.shared.tonal(image) {(theImage) in
                self.imageView.image = theImage
            }
        }
        
        let filterThree = UIAlertAction(title: "Process", style: .Default) { (action) in
            Filters.shared.process(image) {(theImage) in
                self.imageView.image = theImage
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
          // self.imageView.image = Filters.originalImage
           //self.imageView.image = image
            
        }
        
        actionSheet.addAction(filterOne)
        actionSheet.addAction(filterTwo)
        actionSheet.addAction(filterThree)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else {return}
        
        API.shared.write(Post(image: image)) { (success) in
            if success{
                print("Success")
            }
        }
    }
    
    
    //Mark:UIPickerController Delegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        self.addButton.alpha = 0
        
    }
    

}

