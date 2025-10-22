//
//  UserProgressRepositoryProtocol.swift
//  DragonQuest
//
//  Domain Layer - Repository Protocol
//

import Foundation
import Combine

/// Kullanıcı ilerleme repository protokolü
protocol UserProgressRepositoryProtocol {
    /// Kullanıcı ilerlemesini getirir
    func getUserProgress() async throws -> UserProgress
    
    /// Kullanıcı ilerlemesini günceller
    func updateUserProgress(_ progress: UserProgress) async throws
    
    /// XP ekler
    func addXP(_ amount: Int) async throws -> UserProgress
    
    /// Görev tamamlama sayısını artırır
    func incrementTasksCompleted() async throws
    
    /// Günlük streak'i günceller
    func updateDailyStreak() async throws
    
    /// İlerlemeyi sıfırlar (Debug/Test için)
    func resetProgress() async throws
    
    /// İlerleme değişikliklerini dinlemek için publisher
    var progressPublisher: AnyPublisher<UserProgress, Never> { get }
}


