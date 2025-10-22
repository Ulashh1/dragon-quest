//
//  CompleteTaskUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// Görev tamamlama use case
final class CompleteTaskUseCase {
    private let taskRepository: TaskRepositoryProtocol
    private let progressRepository: UserProgressRepositoryProtocol
    
    init(
        taskRepository: TaskRepositoryProtocol,
        progressRepository: UserProgressRepositoryProtocol
    ) {
        self.taskRepository = taskRepository
        self.progressRepository = progressRepository
    }
    
    /// Görevi tamamlar ve XP ekler
    /// - Parameter taskId: Tamamlanacak görevin ID'si
    /// - Returns: (Tamamlanan görev, Güncellenmiş progress)
    func execute(taskId: UUID) async throws -> (task: Task, progress: UserProgress) {
        // Görevi getir
        guard let task = try await taskRepository.getTask(byId: taskId) else {
            throw TaskError.taskNotFound
        }
        
        // Zaten tamamlanmış mı kontrol et
        guard !task.isCompleted else {
            throw TaskError.alreadyCompleted
        }
        
        // Görevi tamamla
        let completedTask = try await taskRepository.completeTask(withId: taskId)
        
        // XP ekle
        let updatedProgress = try await progressRepository.addXP(completedTask.xpValue)
        
        // Görev sayacını artır
        try await progressRepository.incrementTasksCompleted()
        
        // Streak'i güncelle
        try await progressRepository.updateDailyStreak()
        
        return (completedTask, updatedProgress)
    }
}


