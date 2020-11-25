//
//  Note.swift
//  day02
//
//  Created by Dremora Restless on 11/25/20.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//

import Foundation

struct Note {
    let name: String
    let date: Date
    let desc: String
    
    init(withName name: String, andDate date: Date, andDescription desc: String ) {
        self.name = name
        self.date = date
        self.desc = desc
    }
}
