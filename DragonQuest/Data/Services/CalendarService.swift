//
//  CalendarService.swift
//  DragonQuest
//
//  Data Layer - Calendar Service
//

import Foundation
import EventKit

/// Takvim entegrasyon servisi (opsiyonel özellik)
final class CalendarService {
    private let eventStore = EKEventStore()
    
    // MARK: - Authorization
    
    /// Takvim erişim izni iste
    func requestAccess() async throws -> Bool {
        if #available(iOS 17.0, *) {
            let granted = try await eventStore.requestFullAccessToEvents()
            return granted
        } else {
            return try await withCheckedThrowingContinuation { continuation in
                eventStore.requestAccess(to: .event) { granted, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: granted)
                    }
                }
            }
        }
    }
    
    /// Takvim erişim durumunu kontrol et
    func checkAuthorizationStatus() -> Bool {
        if #available(iOS 17.0, *) {
            return EKEventStore.authorizationStatus(for: .event) == .fullAccess
        } else {
            return EKEventStore.authorizationStatus(for: .event) == .authorized
        }
    }
    
    // MARK: - Create Events
    
    /// Görev için takvim eventi oluştur
    func createEvent(for task: Task) async throws {
        guard checkAuthorizationStatus() else {
            _ = try await requestAccess()
            return
        }
        
        guard let scheduledDate = task.scheduledDate else {
            throw CalendarError.invalidDate
        }
        
        let event = EKEvent(eventStore: eventStore)
        event.title = "📋 " + task.title
        event.notes = task.description
        event.startDate = scheduledDate
        event.endDate = scheduledDate.addingTimeInterval(3600) // 1 saat süre
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        // Alarm ekle (30 dakika önce)
        let alarm = EKAlarm(relativeOffset: -1800)
        event.addAlarm(alarm)
        
        try eventStore.save(event, span: .thisEvent)
    }
    
    // MARK: - Query Events
    
    /// Belirli tarih aralığındaki eventleri getir
    func getEvents(from startDate: Date, to endDate: Date) -> [EKEvent] {
        guard checkAuthorizationStatus() else {
            return []
        }
        
        let predicate = eventStore.predicateForEvents(
            withStart: startDate,
            end: endDate,
            calendars: nil
        )
        
        return eventStore.events(matching: predicate)
    }
}

// MARK: - Calendar Errors

enum CalendarError: LocalizedError {
    case authorizationDenied
    case invalidDate
    case saveFailed
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "Takvim erişim izni reddedildi"
        case .invalidDate:
            return "Geçersiz tarih"
        case .saveFailed:
            return "Takvim eventi kaydedilemedi"
        }
    }
}


