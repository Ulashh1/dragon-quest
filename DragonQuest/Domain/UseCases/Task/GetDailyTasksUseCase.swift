//
//  GetDailyTasksUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// Günlük görevleri getirme use case
final class GetDailyTasksUseCase {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    /// Bugünün görevlerini getirir
    /// - Returns: Bugünün görev listesi
    func execute() async throws -> [Task] {
        let todaysTasks = try await taskRepository.getTodaysTasks()
        
        // Öncelik ve tamamlanma durumuna göre sırala
        return todaysTasks.sorted { task1, task2 in
            // Önce tamamlanmamışlar
            if task1.isCompleted != task2.isCompleted {
                return !task1.isCompleted
            }
            
            // Sonra önceliğe göre
            if task1.priority != task2.priority {
                return task1.priority.rawValue > task2.priority.rawValue
            }
            
            // Son olarak oluşturulma tarihine göre
            return task1.createdAt < task2.createdAt
        }
    }
    
    /// Belirli bir tipteki bugünkü görevleri getirir
    /// - Parameter type: Görev tipi
    /// - Returns: Filtrelenmiş görev listesi
    func execute(type: TaskType) async throws -> [Task] {
        let allTasks = try await execute()
        return allTasks.filter { $0.type == type }
    }
    
    /// Tamamlanmamış görevlerin sayısını döndürür
    func getIncompleteCount() async throws -> Int {
        let tasks = try await execute()
        return tasks.filter { !$0.isCompleted }.count
    }
}


