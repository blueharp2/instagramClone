//
//  Filters.swift
//  instagramClone
//
//  Created by Lindsey on 6/21/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import UIKit

typealias FilterCompletion = (theImage:UIImage?)->()

class Filters{
    
    static var originalImage = UIImage()
    
    private class func filter(name:String, image:UIImage, completion:FilterCompletion){
        NSOperationQueue().addOperationWithBlock { 
            guard let filter = CIFilter(name: name) else { fatalError("Filter Failed")}
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            guard let outputImage = filter.outputImage else {fatalError("Error creating output image")}
                
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ 
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func vintage(image:UIImage, completion: FilterCompletion){
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    class func tonal(image:UIImage, completion: FilterCompletion){
        self.filter("CIPhotoEffectTonal", image: image, completion: completion)
    }
    class func process(image:UIImage, completion: FilterCompletion){
        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
    }
    
}