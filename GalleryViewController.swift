//
//  GalleryViewController.swift
//  instagramClone
//
//  Created by Lindsey on 6/22/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var posts = [Post](){
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.setup()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.update()
    }
    
    func update(){
        
        self.activityIndicator.startAnimating()
        
        API.shared.GET { (post) in
            print(post)
            if let post = post{
                self.posts = post
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = 0
            }
        }
    }
    
    func setup(){
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    func setupCollectionView(){
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(GalleryViewController.pinchedCollectionView(_:)))
        
        self.collectionView.addGestureRecognizer(pinchGesture)
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 3)
    }
    
    func pinchedCollectionView(sender: UIPinchGestureRecognizer){
        let layout = self.collectionView.collectionViewLayout as! GalleryCustomFlowLayout
        var columns = layout.columns
        
        if sender.state == .Ended{
            if sender.scale > 1.0{
                columns += 1
            }
            else if sender.scale < 1.0{
                if columns > 1{
                    columns -= 1
                }
            }
        }
        self.collectionView.setCollectionViewLayout(GalleryCustomFlowLayout(columns:columns), animated: true)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    //MARK: CollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        cell.post = self.posts[indexPath.row]
        
        return cell
    }

}
