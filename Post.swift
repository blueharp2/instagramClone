//
//  Post.swift
//  instagramClone
//
//  Created by Lindsey on 6/21/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

class Post{
    var image: UIImage
    
    init(image:UIImage){
        self.image = image
    }
    convenience init(){
        self.init(image:UIImage())
    }
}
