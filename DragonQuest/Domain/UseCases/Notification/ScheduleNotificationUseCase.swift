//
//  ScheduleNotificationUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// Bildirim planlama use case
final class ScheduleNotificationUseCase {
    private let notificationRepository: NotificationRepositoryProtocol
    private let taskRepository: TaskRepositoryProtocol
    
    init(
        notificationRepository: NotificationRepositoryProtocol,
        taskRepository: TaskRepositoryProtocol
    ) {
        self.notificationRepository = notificationRepository
        self.taskRepository = taskRepository
    }
    
    /// Günlük hatırlatma bildirimi planlar
    /// - Parameter time: Bildirim zamanı
    func scheduleDailyReminder(at time: Date) async throws {
        // İzin kontrolü
        let isAuthorized = await notificationRepository.checkAuthorizationStatus()
        
        if !isAuthorized {
            let granted = try await notificationRepository.requestAuthorization()
            guard granted else {
                throw NotificationError.authorizationDenied
            }
        }
        
        // Tamamlanmamış görev sayısını al
        let incompleteTasks = try await taskRepository.getIncompleteTasks()
        let count = incompleteTasks.count
        
        let message: String
        if count == 0 {
            message = "Tüm görevlerin tamamlandı! 🎉 Yeni görevler ekle ve ejderhanı büyütmeye devam et!"
        } else {
            message = "\(count) adet tamamlanmamış görevin var! 🔥 Ejderhanı besleme zamanı!"
        }
        
        // Bildirimi planla
        try await notificationRepository.scheduleDailyReminder(at: time, message: message)
    }
    
    /// Belirli bir görev için hatırlatma planlar
    /// - Parameters:
    ///   - taskId: Görev ID'si
    ///   - date: Hatırlatma tarihi
    func scheduleTaskReminder(for taskId: UUID, at date: Date) async throws {
        // Görevi getir
        guard let task = try await taskRepository.getTask(byId: taskId) else {
            throw TaskError.taskNotFound
        }
        
        // İzin kontrolü
        let isAuthorized = await notificationRepository.checkAuthorizationStatus()
        if !isAuthorized {
            _ = try await notificationRepository.requestAuthorization()
        }
        
        // Bildirimi planla
        let title = "⏰ Görev Hatırlatması"
        let body = task.title
        
        try await notificationRepository.scheduleTaskReminder(
            taskId: taskId,
            title: title,
            body: body,
            date: date
        )
    }
    
    /// Tüm bildirimleri iptal eder
    func cancelAllNotifications() async {
        await notificationRepository.cancelAllNotifications()
    }
}

// MARK: - Notification Errors
enum NotificationError: LocalizedError {
    case authorizationDenied
    case schedulingFailed
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "Bildirim izni reddedildi. Lütfen Ayarlar'dan bildirimleri aktif edin."
        case .schedulingFailed:
            return "Bildirim planlanamadı"
        }
    }
}


