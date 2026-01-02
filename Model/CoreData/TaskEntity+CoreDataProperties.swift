//
//  TaskEntity+CoreDataProperties.swift
//  TODO-coredata
//
//  Created by iPHTech4 on 1/2/26.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: Date
    @NSManaged public var title: String

}

extension TaskEntity : Identifiable {

}
