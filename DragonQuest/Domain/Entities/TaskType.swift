//
//  TaskType.swift
//  DragonQuest
//
//  Domain Layer - Entity
//

import Foundation

/// Görev tiplerini tanımlayan enum
enum TaskType: String, Codable {
    case daily = "daily"
    case weekly = "weekly"
    case main = "main"
    
    /// Her görev tipinin varsayılan XP değeri
    var defaultXP: Int {
        switch self {
        case .daily:
            return 10
        case .weekly:
            return 50
        case .main:
            return 100
        }
    }
    
    /// Görev tipinin kullanıcıya gösterilecek adı
    var displayName: String {
        switch self {
        case .daily:
            return "Günlük Görev"
        case .weekly:
            return "Haftalık Görev"
        case .main:
            return "Ana Görev"
        }
    }
    
    /// Görev tipinin ikonu
    var icon: String {
        switch self {
        case .daily:
            return "sun.max.fill"
        case .weekly:
            return "calendar.badge.clock"
        case .main:
            return "star.fill"
        }
    }
}

/// Görev öncelik seviyesi
enum TaskPriority: Int, Codable {
    case low = 0
    case medium = 1
    case high = 2
    case critical = 3
    
    var displayName: String {
        switch self {
        case .low:
            return "Düşük"
        case .medium:
            return "Orta"
        case .high:
            return "Yüksek"
        case .critical:
            return "Kritik"
        }
    }
    
    var color: String {
        switch self {
        case .low:
            return "gray"
        case .medium:
            return "blue"
        case .high:
            return "orange"
        case .critical:
            return "red"
        }
    }
}


