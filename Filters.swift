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
    
    
    private class func filter(name:String, image:UIImage, completion:FilterCompletion){
        
        NSOperationQueue().addOperationWithBlock { () -> Void in
            guard let filter = CIFilter(name: name) else { fatalError("Filter Failed")}
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            //GPU Context
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let GPUContext = CIContext(EAGLContext: eAGLContext, options: options)
            
            // Get final Image using GPU Rendering
            guard let outputImage = filter.outputImage else { return /*fatalError("Error creating output image")*/}
            let cgImage = GPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    static var original = UIImage()
    
    class func original(image: UIImage, completion: FilterCompletion){
        completion(theImage: self.original)
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

    
//    static var originalImage = UIImage()
//
//    
//    static let shared = Filters()
//    private let context: CIContext
//    
//    private init(){
//        
//        let options = [kCIContextWorkingColorSpace: NSNull()]
//        let eAGLContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//        self.context = CIContext(EAGLContext: eAGLContext, options: options)
//        
//    }
//    
//    private func filter(name:String, image:UIImage, completion:FilterCompletion){
//        
//        NSOperationQueue().addOperationWithBlock { 
//            guard let filter = CIFilter(name: name) else { fatalError("Filter Failed")}
//            
//            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
//            
//            guard let outputImage = filter.outputImage else {fatalError("Error creating output image")}
//                
//            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
//            
//            NSOperationQueue.mainQueue().addOperationWithBlock({ 
//                completion(theImage: UIImage(CGImage: cgImage))
//            })
//        }
//    }
//    
//    func vintage(image:UIImage, completion: FilterCompletion){
//        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
//    }
//    func tonal(image:UIImage, completion: FilterCompletion){
//        self.filter("CIPhotoEffectTonal", image: image, completion: completion)
//    }
//    func process(image:UIImage, completion: FilterCompletion){
//        self.filter("CIPhotoEffectProcess", image: image, completion: completion)
//    }
    
}