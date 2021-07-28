//
//  Entity+CoreDataProperties.swift
//  My Photos
//
//  Created by Pars arge on 28.07.2021.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var titletext: String?
    @NSManaged public var desctext: String?
    @NSManaged public var image: Data?

}

extension Entity : Identifiable {

}
