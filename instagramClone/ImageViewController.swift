//
//  ViewController.swift
//  instagramClone
//
//  Created by Lindsey on 6/21/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate, FiltersPreviewViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addButton: UIButton!
   
    
    lazy var imagePicker = UIImagePickerController()
    var post = Post()
    
    
    
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
        let actionSheet = UIAlertController(title: "Source", message: "Do you want to use your camera or photo library?", preferredStyle: .Alert)
        
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
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo: UnsafePointer<Void>){
        if error == nil{
            let alertController = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alertController, animated: true, completion: nil)
        }
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
        
        self.post = Post(image: image)
        self.performSegueWithIdentifier("FilterPreviewViewController", sender: nil)
        
    }
    
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else {return}
        
        self.post = Post(image: image)
        
        API.shared.write(self.post) { (success) in
            if success{
                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(ImageViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            }
        }
        
//        API.shared.write(Post(image: image)) { (success) in
//            if success{
//                print("Success")
//            }
//        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == FilterPreivewViewController.id(){
            guard let filtersPreviewViewController = segue.destinationViewController as? FilterPreivewViewController else {return}
            
            filtersPreviewViewController.delegate = self
            filtersPreviewViewController.post = self.post
        }
    }
    
    //Mark:FiltersPreviewViewControllerDelegate
    
    func didFinishPickingImage(sucess: Bool, image: UIImage?) {
        if sucess{
            guard let image = image else {return}
            self.imageView.image = image
        }else{
            print("Error")
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Mark:UIPickerController Delegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        Filters.original = image
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        self.addButton.alpha = 0
    }
    

}

