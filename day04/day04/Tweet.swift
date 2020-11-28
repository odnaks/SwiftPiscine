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
    let date: Date
    
    var description: String {
        return "\(name): \(text)"
    }
    
    init(name: String, text: String, date: Date){
        self.name = name
        self.text = text
        self.date = date
    }
}

