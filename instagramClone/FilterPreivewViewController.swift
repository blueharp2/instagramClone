//
//  FilterPreivewViewController.swift
//  instagramClone
//
//  Created by Lindsey on 6/25/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class FilterPreivewViewController: UIViewController, Identity{

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FiltersPreviewViewControllerDelegate?
    
    let filters = [Filters.original, Filters.process, Filters.tonal, Filters.vintage]
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()

    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }
}


extension FilterPreivewViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    func configureCellForIndexPath(indexPath:NSIndexPath) -> ImageCollectionViewCell {
     
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        self.filters[indexPath.row](post.image, completion: {imageCell.imageVIew.image = $0})
        
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let delegate = self.delegate else {return}
        let imageCell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
        
        if let image = imageCell.imageVIew.image{
            delegate.didFinishPickingImage(true, image: image)
        }else{
            delegate.didFinishPickingImage(false, image: nil)
        }
    }
    
}