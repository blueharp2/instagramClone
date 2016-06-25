//
//  FiltersPreviewViewControllerProtocol.swift
//  instagramClone
//
//  Created by Lindsey on 6/25/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerDelegate:class {
    func didFinishPickingImage(sucess:Bool, image:UIImage?) ->()
}

