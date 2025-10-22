//
//  UserProgressEntity+CoreDataProperties.swift
//  DragonQuest
//
//  Data Layer - Core Data Entity Properties
//

import Foundation
import CoreData

extension UserProgressEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProgressEntity> {
        return NSFetchRequest<UserProgressEntity>(entityName: "UserProgressEntity")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var totalXP: Int32
    @NSManaged public var currentLevel: Int32
    @NSManaged public var currentLevelXP: Int32
    @NSManaged public var nextLevelXP: Int32
    @NSManaged public var totalTasksCompleted: Int32
    @NSManaged public var dailyStreak: Int32
    @NSManaged public var lastActiveDate: Date
    @NSManaged public var dragonStage: Int16
}

extension UserProgressEntity: Identifiable {
    
}


