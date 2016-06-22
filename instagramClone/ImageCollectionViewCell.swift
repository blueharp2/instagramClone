//
//  ImageCollectionViewCell.swift
//  instagramClone
//
//  Created by Lindsey on 6/22/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageVIew: UIImageView!
    
    class func id() ->String{
        return String(self)
    }
    
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
