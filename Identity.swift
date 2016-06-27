//
//  Identity.swift
//  instagramClone
//
//  Created by Lindsey on 6/27/16.
//  Copyright © 2016 Lindsey Boggio. All rights reserved.
//

import Foundation

protocol Identity:class{
    
    static func id() -> String
}

extension Identity{
    
    static func id() -> String{
        return String(self)
    }
}