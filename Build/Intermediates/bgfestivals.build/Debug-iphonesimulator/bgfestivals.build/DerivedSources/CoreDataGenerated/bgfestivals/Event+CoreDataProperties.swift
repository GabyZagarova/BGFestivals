//
//  Event+CoreDataProperties.swift
//  
//
//  Created by Siyana Slavova on 3/21/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var contactEmail: String?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var eventDescription: String?
    @NSManaged public var id: Int64
    @NSManaged public var isSelected: Bool
    @NSManaged public var location: String?
    @NSManaged public var rating: Double
    @NSManaged public var startDate: NSDate?
    @NSManaged public var status: Int16
    @NSManaged public var title: String?

}
