//
//  GetUserProgressUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// Kullanıcı ilerlemesini getirme use case
final class GetUserProgressUseCase {
    private let progressRepository: UserProgressRepositoryProtocol
    
    init(progressRepository: UserProgressRepositoryProtocol) {
        self.progressRepository = progressRepository
    }
    
    /// Kullanıcı ilerlemesini getirir
    func execute() async throws -> UserProgress {
        var progress = try await progressRepository.getUserProgress()
        
        // Streak kırıldıysa güncelle
        if progress.isStreakBroken() {
            progress.dailyStreak = 0
            try await progressRepository.updateUserProgress(progress)
        }
        
        return progress
    }
    
    /// İlerleme özeti döndürür
    func getProgressSummary() async throws -> ProgressSummary {
        let progress = try await execute()
        
        return ProgressSummary(
            level: progress.currentLevel,
            totalXP: progress.totalXP,
            currentLevelXP: progress.currentLevelXP,
            nextLevelXP: progress.nextLevelXP,
            progressPercentage: progress.progressPercentage,
            tasksCompleted: progress.totalTasksCompleted,
            currentStreak: progress.dailyStreak,
            dragonStage: progress.dragonStage
        )
    }
}

/// İlerleme özeti
struct ProgressSummary {
    let level: Int
    let totalXP: Int
    let currentLevelXP: Int
    let nextLevelXP: Int
    let progressPercentage: Double
    let tasksCompleted: Int
    let currentStreak: Int
    let dragonStage: DragonStage
    
    var xpRemainingToNextLevel: Int {
        nextLevelXP - currentLevelXP
    }
}


