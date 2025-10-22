//
//  TaskEntity+CoreDataProperties.swift
//  DragonQuest
//
//  Data Layer - Core Data Entity Properties
//

import Foundation
import CoreData

extension TaskEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var descriptionText: String?
    @NSManaged public var type: String
    @NSManaged public var xpValue: Int32
    @NSManaged public var priority: Int16
    @NSManaged public var isCompleted: Bool
    @NSManaged public var completedAt: Date?
    @NSManaged public var createdAt: Date
    @NSManaged public var scheduledDate: Date?
    @NSManaged public var repeatDaily: Bool
    @NSManaged public var repeatWeekly: Bool
    @NSManaged public var tags: [String]?
}

extension TaskEntity: Identifiable {
    
}


