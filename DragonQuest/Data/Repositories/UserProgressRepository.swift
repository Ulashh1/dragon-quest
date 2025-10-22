//
//  UserProgressRepository.swift
//  DragonQuest
//
//  Data Layer - Repository Implementation
//

import Foundation
import CoreData
import Combine

/// User progress repository implementasyonu
final class UserProgressRepository: UserProgressRepositoryProtocol {
    private let coreDataManager: CoreDataManager
    private let progressSubject = CurrentValueSubject<UserProgress, Never>(UserProgress())
    
    var progressPublisher: AnyPublisher<UserProgress, Never> {
        progressSubject.eraseToAnyPublisher()
    }
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Fetch Operations
    
    func getUserProgress() async throws -> UserProgress {
        let context = coreDataManager.viewContext
        
        return try await context.perform {
            let fetchRequest = UserProgressEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            
            let entities = try self.coreDataManager.fetch(fetchRequest, context: context)
            
            let progress: UserProgress
            
            if let entity = entities.first {
                progress = UserProgressMapper.toDomain(entity)
            } else {
                // İlk kez açılıyor, varsayılan progress oluştur
                progress = UserProgress()
                _ = try await self.createInitialProgress(progress, context: context)
            }
            
            self.progressSubject.send(progress)
            return progress
        }
    }
    
    // MARK: - Update Operations
    
    func updateUserProgress(_ progress: UserProgress) async throws {
        let context = coreDataManager.viewContext
        
        try await context.perform {
            let fetchRequest = UserProgressEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            
            let entity: UserProgressEntity
            
            if let existingEntity = try self.coreDataManager.fetch(fetchRequest, context: context).first {
                entity = existingEntity
            } else {
                entity = UserProgressEntity(context: context)
                entity.id = UUID()
            }
            
            UserProgressMapper.toEntity(progress, entity: entity)
            try self.coreDataManager.saveContext(context)
            
            self.progressSubject.send(progress)
        }
    }
    
    func addXP(_ amount: Int) async throws -> UserProgress {
        var progress = try await getUserProgress()
        progress.addXP(amount)
        try await updateUserProgress(progress)
        return progress
    }
    
    func incrementTasksCompleted() async throws {
        var progress = try await getUserProgress()
        progress.totalTasksCompleted += 1
        try await updateUserProgress(progress)
    }
    
    func updateDailyStreak() async throws {
        var progress = try await getUserProgress()
        progress.updateStreak()
        try await updateUserProgress(progress)
    }
    
    func resetProgress() async throws {
        let newProgress = UserProgress()
        try await updateUserProgress(newProgress)
    }
    
    // MARK: - Private Helpers
    
    private func createInitialProgress(_ progress: UserProgress, context: NSManagedObjectContext) async throws -> UserProgress {
        let entity = UserProgressEntity(context: context)
        entity.id = UUID()
        UserProgressMapper.toEntity(progress, entity: entity)
        
        try coreDataManager.saveContext(context)
        return progress
    }
}


