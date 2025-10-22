//
//  TaskMapper.swift
//  DragonQuest
//
//  Data Layer - Mapper
//

import Foundation

/// Core Data TaskEntity ile Domain Task arasında dönüşüm yapar
struct TaskMapper {
    
    /// Core Data entity'sini domain model'e dönüştürür
    static func toDomain(_ entity: TaskEntity) -> Task {
        let taskType = TaskType(rawValue: entity.type) ?? .daily
        let priority = TaskPriority(rawValue: Int(entity.priority)) ?? .medium
        
        return Task(
            id: entity.id,
            title: entity.title,
            description: entity.descriptionText,
            type: taskType,
            xpValue: Int(entity.xpValue),
            priority: priority,
            isCompleted: entity.isCompleted,
            completedAt: entity.completedAt,
            createdAt: entity.createdAt,
            scheduledDate: entity.scheduledDate,
            repeatDaily: entity.repeatDaily,
            repeatWeekly: entity.repeatWeekly,
            tags: entity.tags ?? []
        )
    }
    
    /// Domain model'i Core Data entity'sine dönüştürür
    static func toEntity(_ task: Task, entity: TaskEntity) {
        entity.id = task.id
        entity.title = task.title
        entity.descriptionText = task.description
        entity.type = task.type.rawValue
        entity.xpValue = Int32(task.xpValue)
        entity.priority = Int16(task.priority.rawValue)
        entity.isCompleted = task.isCompleted
        entity.completedAt = task.completedAt
        entity.createdAt = task.createdAt
        entity.scheduledDate = task.scheduledDate
        entity.repeatDaily = task.repeatDaily
        entity.repeatWeekly = task.repeatWeekly
        entity.tags = task.tags
    }
}


