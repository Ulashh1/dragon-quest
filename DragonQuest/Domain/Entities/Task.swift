//
//  Task.swift
//  DragonQuest
//
//  Domain Layer - Entity
//

import Foundation

/// Görev domain entity
struct Task: Identifiable, Equatable {
    let id: UUID
    var title: String
    var description: String?
    var type: TaskType
    var xpValue: Int
    var priority: TaskPriority
    var isCompleted: Bool
    var completedAt: Date?
    var createdAt: Date
    var scheduledDate: Date?
    var repeatDaily: Bool
    var repeatWeekly: Bool
    var tags: [String]
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String? = nil,
        type: TaskType,
        xpValue: Int? = nil,
        priority: TaskPriority = .medium,
        isCompleted: Bool = false,
        completedAt: Date? = nil,
        createdAt: Date = Date(),
        scheduledDate: Date? = nil,
        repeatDaily: Bool = false,
        repeatWeekly: Bool = false,
        tags: [String] = []
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.type = type
        self.xpValue = xpValue ?? type.defaultXP
        self.priority = priority
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.createdAt = createdAt
        self.scheduledDate = scheduledDate
        self.repeatDaily = repeatDaily
        self.repeatWeekly = repeatWeekly
        self.tags = tags
    }
    
    /// Görevin bugün için geçerli olup olmadığını kontrol eder
    func isValidForToday() -> Bool {
        guard let scheduledDate = scheduledDate else {
            return true // Planlanmamış görevler her zaman geçerli
        }
        
        return Calendar.current.isDateInToday(scheduledDate)
    }
    
    /// Görevin süresi dolmuş mu kontrol eder
    func isOverdue() -> Bool {
        guard let scheduledDate = scheduledDate, !isCompleted else {
            return false
        }
        
        return scheduledDate < Date()
    }
}

// MARK: - Mock Data (Development ve Test için)
extension Task {
    static var mockDaily: Task {
        Task(
            title: "30 Dakika Egzersiz",
            description: "Günlük spor rutini",
            type: .daily,
            priority: .high,
            scheduledDate: Date(),
            repeatDaily: true
        )
    }
    
    static var mockWeekly: Task {
        Task(
            title: "2 Kitap Oku",
            description: "Bu hafta en az 2 kitap bitir",
            type: .weekly,
            priority: .medium,
            repeatWeekly: true
        )
    }
    
    static var mockMain: Task {
        Task(
            title: "Yeni Beceri Öğren",
            description: "SwiftUI ile uygulama geliştirmeyi öğren",
            type: .main,
            priority: .critical
        )
    }
}


