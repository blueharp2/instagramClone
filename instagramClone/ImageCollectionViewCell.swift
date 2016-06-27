//
//  ImageCollectionViewCell.swift
//  instagramClone
//
//  Created by Lindsey on 6/22/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, Identity {
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    var post:Post?{
        didSet{
            self.imageVIew.image = post?.image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageVIew.image = nil
    }
    
    
}
