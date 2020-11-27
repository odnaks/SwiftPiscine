//
//  Tweet.swift
//  day04
//
//  Created by Dremora Restless on 11/27/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

struct Tweet: CustomStringConvertible {
    let name: String
    let text: String
    
    var description: String {
        return "\(name): \(text)"
    }
}

