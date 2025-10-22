//
//  NotificationService.swift
//  DragonQuest
//
//  Data Layer - Notification Service
//

import Foundation
import UserNotifications

/// Notification repository implementasyonu
final class NotificationService: NotificationRepositoryProtocol {
    private let center = UNUserNotificationCenter.current()
    
    // MARK: - Authorization
    
    func requestAuthorization() async throws -> Bool {
        do {
            let granted = try await center.requestAuthorization(options: [.alert, .badge, .sound])
            return granted
        } catch {
            throw NotificationError.authorizationDenied
        }
    }
    
    func checkAuthorizationStatus() async -> Bool {
        let settings = await center.notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    // MARK: - Schedule Notifications
    
    func scheduleDailyReminder(at time: Date, message: String) async throws {
        // Önce mevcut günlük hatırlatmaları iptal et
        await cancelNotification(withId: "daily_reminder")
        
        // Zaman bileşenlerini al
        let components = Calendar.current.dateComponents([.hour, .minute], from: time)
        
        // Bildirim içeriği
        let content = UNMutableNotificationContent()
        content.title = "🐉 Görev Hatırlatması"
        content.body = message
        content.sound = .default
        content.badge = 1
        
        // Trigger oluştur (her gün aynı saatte)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        // Request oluştur
        let request = UNNotificationRequest(
            identifier: "daily_reminder",
            content: content,
            trigger: trigger
        )
        
        // Bildirimi planla
        try await center.add(request)
    }
    
    func scheduleTaskReminder(taskId: UUID, title: String, body: String, date: Date) async throws {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = ["taskId": taskId.uuidString]
        
        // Belirli bir tarihte tetiklenmesi için trigger
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // Request oluştur
        let request = UNNotificationRequest(
            identifier: "task_\(taskId.uuidString)",
            content: content,
            trigger: trigger
        )
        
        // Bildirimi planla
        try await center.add(request)
    }
    
    // MARK: - Cancel Notifications
    
    func cancelAllNotifications() async {
        center.removeAllPendingNotificationRequests()
        center.removeAllDeliveredNotifications()
    }
    
    func cancelNotification(withId id: String) async {
        center.removePendingNotificationRequests(withIdentifiers: [id])
        center.removeDeliveredNotifications(withIdentifiers: [id])
    }
    
    // MARK: - Query Notifications
    
    func getPendingNotifications() async -> Int {
        let requests = await center.pendingNotificationRequests()
        return requests.count
    }
}


