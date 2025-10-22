//
//  NotificationRepositoryProtocol.swift
//  DragonQuest
//
//  Domain Layer - Repository Protocol
//

import Foundation

/// Bildirim repository protokolü
protocol NotificationRepositoryProtocol {
    /// Bildirim izni iste
    func requestAuthorization() async throws -> Bool
    
    /// Bildirim izninin durumunu kontrol et
    func checkAuthorizationStatus() async -> Bool
    
    /// Günlük hatırlatma bildirimi planla
    func scheduleDailyReminder(at time: Date, message: String) async throws
    
    /// Belirli bir görev için bildirim planla
    func scheduleTaskReminder(taskId: UUID, title: String, body: String, date: Date) async throws
    
    /// Tüm bildirimleri iptal et
    func cancelAllNotifications() async
    
    /// Belirli bir bildirimi iptal et
    func cancelNotification(withId id: String) async
    
    /// Bekleyen bildirimleri listele
    func getPendingNotifications() async -> Int
}


