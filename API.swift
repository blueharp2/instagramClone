//
//  API.swift
//  instagramClone
//
//  Created by Lindsey on 6/21/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//
import UIKit
import CloudKit

typealias APICompletion = (success:Bool) ->()

class API{
    static let shared = API()
    
    let container:CKContainer
    let database:CKDatabase
    
    private init(){
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func write(post:Post, completion:APICompletion){
        do{
            if let record = try Post.recordWith(post){
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil{
                        print(record)
                        completion(success: true)
                    }
                })
            }
            
        }catch let error {print(error)}
    }
    
    func GET(completion: (post:[Post]?) ->()){
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        self.database.performQuery(query, inZoneWithID: nil) { (record, error) in
            if let records = record{
                var posts = [Post]()
                
                for record in records{
                    guard let asset = record["image"] as? CKAsset else {return}
                    guard let path = asset.fileURL.path else {return}
                    guard let image = UIImage(contentsOfFile: path) else {return}
                    
                    posts.append(Post(image: image))
                }
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    completion(post:posts)
                })
            }
            completion(post: nil)
        }
    }
    
}
