//
//  TaskRepositoryProtocol.swift
//  DragonQuest
//
//  Domain Layer - Repository Protocol
//

import Foundation
import Combine

/// Görev repository protokolü
/// Data katmanı bu protokolü implement eder
protocol TaskRepositoryProtocol {
    /// Tüm görevleri getirir
    func getAllTasks() async throws -> [Task]
    
    /// Belirli bir tarihteki görevleri getirir
    func getTasks(for date: Date) async throws -> [Task]
    
    /// Belirli bir tipteki görevleri getirir
    func getTasks(ofType type: TaskType) async throws -> [Task]
    
    /// Bugünün görevlerini getirir
    func getTodaysTasks() async throws -> [Task]
    
    /// Tamamlanmamış görevleri getirir
    func getIncompleteTasks() async throws -> [Task]
    
    /// ID'ye göre görev getirir
    func getTask(byId id: UUID) async throws -> Task?
    
    /// Yeni görev oluşturur
    func createTask(_ task: Task) async throws -> Task
    
    /// Görevi günceller
    func updateTask(_ task: Task) async throws -> Task
    
    /// Görevi siler
    func deleteTask(withId id: UUID) async throws
    
    /// Görevi tamamlar
    func completeTask(withId id: UUID) async throws -> Task
    
    /// Görev tamamlama durumunu değiştirir
    func toggleTaskCompletion(withId id: UUID) async throws -> Task
    
    /// Tüm görevleri siler (Admin için)
    func deleteAllTasks() async throws
    
    /// Görev değişikliklerini dinlemek için publisher
    var tasksPublisher: AnyPublisher<[Task], Never> { get }
}


