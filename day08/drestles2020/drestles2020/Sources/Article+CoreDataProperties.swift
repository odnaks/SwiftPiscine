//
//  Article+CoreDataProperties.swift
//  drestles2020
//
//  Created by Kseniya Lukoshkina on 04.12.2020.
//  Copyright © 2020 Dremora Restless. All rights reserved.
//
//

import Foundation
import CoreData

extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var language: String?
    @NSManaged public var image: String?
    @NSManaged public var creationDate: Date?
    @NSManaged public var modificationDate: Date?

}

extension Article : Identifiable {

}
