//
//  Article+CoreDataClass.swift
//  drestles2020
//
//  Created by Kseniya Lukoshkina on 04.12.2020.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {
    override public var description: String {
        guard let title = title, content = content else { return }
        return "title: \(title)\ncontent: \(content)"
    }

}
