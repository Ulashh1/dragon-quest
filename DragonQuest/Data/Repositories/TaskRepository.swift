//
//  TaskRepository.swift
//  DragonQuest
//
//  Data Layer - Repository Implementation
//

import Foundation
import CoreData
import Combine

/// Task repository implementasyonu
final class TaskRepository: TaskRepositoryProtocol {
    private let coreDataManager: CoreDataManager
    private let tasksSubject = CurrentValueSubject<[Task], Never>([])
    
    var tasksPublisher: AnyPublisher<[Task], Never> {
        tasksSubject.eraseToAnyPublisher()
    }
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Fetch Operations
    
    func getAllTasks() async throws -> [Task] {
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.createdAt, ascending: false)]
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        let tasks = entities.map { TaskMapper.toDomain($0) }
        
        tasksSubject.send(tasks)
        return tasks
    }
    
    func getTasks(for date: Date) async throws -> [Task] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "scheduledDate >= %@ AND scheduledDate < %@",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.createdAt, ascending: false)]
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        return entities.map { TaskMapper.toDomain($0) }
    }
    
    func getTasks(ofType type: TaskType) async throws -> [Task] {
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "type == %@", type.rawValue)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.createdAt, ascending: false)]
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        return entities.map { TaskMapper.toDomain($0) }
    }
    
    func getTodaysTasks() async throws -> [Task] {
        let today = Date()
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: today)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        
        // Bugün için planlanmış görevler VEYA tekrarlanan görevler
        fetchRequest.predicate = NSPredicate(
            format: "(scheduledDate >= %@ AND scheduledDate < %@) OR scheduledDate == nil OR repeatDaily == YES",
            startOfDay as NSDate,
            endOfDay as NSDate
        )
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.priority, ascending: false)]
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        return entities.map { TaskMapper.toDomain($0) }
    }
    
    func getIncompleteTasks() async throws -> [Task] {
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == NO")
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \TaskEntity.priority, ascending: false)]
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        return entities.map { TaskMapper.toDomain($0) }
    }
    
    func getTask(byId id: UUID) async throws -> Task? {
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        let entities = try coreDataManager.fetch(fetchRequest, context: context)
        return entities.first.map { TaskMapper.toDomain($0) }
    }
    
    // MARK: - Create/Update/Delete Operations
    
    func createTask(_ task: Task) async throws -> Task {
        let context = coreDataManager.viewContext
        
        return try await context.perform {
            let entity = TaskEntity(context: context)
            TaskMapper.toEntity(task, entity: entity)
            
            try self.coreDataManager.saveContext(context)
            
            // Publisher'ı güncelle
            Task {
                _ = try? await self.getAllTasks()
            }
            
            return TaskMapper.toDomain(entity)
        }
    }
    
    func updateTask(_ task: Task) async throws -> Task {
        let context = coreDataManager.viewContext
        
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
            fetchRequest.fetchLimit = 1
            
            guard let entity = try self.coreDataManager.fetch(fetchRequest, context: context).first else {
                throw CoreDataError.entityNotFound
            }
            
            TaskMapper.toEntity(task, entity: entity)
            try self.coreDataManager.saveContext(context)
            
            // Publisher'ı güncelle
            Task {
                _ = try? await self.getAllTasks()
            }
            
            return TaskMapper.toDomain(entity)
        }
    }
    
    func deleteTask(withId id: UUID) async throws {
        let context = coreDataManager.viewContext
        
        try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1
            
            guard let entity = try self.coreDataManager.fetch(fetchRequest, context: context).first else {
                throw CoreDataError.entityNotFound
            }
            
            try self.coreDataManager.delete(entity, context: context)
            
            // Publisher'ı güncelle
            Task {
                _ = try? await self.getAllTasks()
            }
        }
    }
    
    func completeTask(withId id: UUID) async throws -> Task {
        let context = coreDataManager.viewContext
        
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1
            
            guard let entity = try self.coreDataManager.fetch(fetchRequest, context: context).first else {
                throw CoreDataError.entityNotFound
            }
            
            entity.isCompleted = true
            entity.completedAt = Date()
            
            try self.coreDataManager.saveContext(context)
            
            // Publisher'ı güncelle
            Task {
                _ = try? await self.getAllTasks()
            }
            
            return TaskMapper.toDomain(entity)
        }
    }
    
    func toggleTaskCompletion(withId id: UUID) async throws -> Task {
        let context = coreDataManager.viewContext
        
        return try await context.perform {
            let fetchRequest = TaskEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            fetchRequest.fetchLimit = 1
            
            guard let entity = try self.coreDataManager.fetch(fetchRequest, context: context).first else {
                throw CoreDataError.entityNotFound
            }
            
            entity.isCompleted.toggle()
            entity.completedAt = entity.isCompleted ? Date() : nil
            
            try self.coreDataManager.saveContext(context)
            
            // Publisher'ı güncelle
            Task {
                _ = try? await self.getAllTasks()
            }
            
            return TaskMapper.toDomain(entity)
        }
    }
    
    func deleteAllTasks() async throws {
        let context = coreDataManager.viewContext
        let fetchRequest = TaskEntity.fetchRequest()
        
        try coreDataManager.batchDelete(fetchRequest, context: context)
        
        // Publisher'ı güncelle
        tasksSubject.send([])
    }
}


