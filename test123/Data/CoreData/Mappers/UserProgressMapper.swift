//
//  UserProgressMapper.swift
//  DragonQuest
//
//  Data Layer - Mapper
//

import Foundation

/// Core Data UserProgressEntity ile Domain UserProgress arasında dönüşüm yapar
struct UserProgressMapper {
    
    /// Core Data entity'sini domain model'e dönüştürür
    static func toDomain(_ entity: UserProgressEntity) -> UserProgress {
        let dragonStage = DragonStage(rawValue: Int(entity.dragonStage)) ?? .egg
        
        return UserProgress(
            totalXP: Int(entity.totalXP),
            currentLevel: Int(entity.currentLevel),
            currentLevelXP: Int(entity.currentLevelXP),
            nextLevelXP: Int(entity.nextLevelXP),
            totalTasksCompleted: Int(entity.totalTasksCompleted),
            dailyStreak: Int(entity.dailyStreak),
            lastActiveDate: entity.lastActiveDate,
            dragonStage: dragonStage
        )
    }
    
    /// Domain model'i Core Data entity'sine dönüştürür
    static func toEntity(_ progress: UserProgress, entity: UserProgressEntity) {
        entity.totalXP = Int32(progress.totalXP)
        entity.currentLevel = Int32(progress.currentLevel)
        entity.currentLevelXP = Int32(progress.currentLevelXP)
        entity.nextLevelXP = Int32(progress.nextLevelXP)
        entity.totalTasksCompleted = Int32(progress.totalTasksCompleted)
        entity.dailyStreak = Int32(progress.dailyStreak)
        entity.lastActiveDate = progress.lastActiveDate
        entity.dragonStage = Int16(progress.dragonStage.rawValue)
    }
}


