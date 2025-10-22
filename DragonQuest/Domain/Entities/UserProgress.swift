//
//  UserProgress.swift
//  DragonQuest
//
//  Domain Layer - Entity
//

import Foundation

/// Kullanıcı ilerleme domain entity
struct UserProgress: Equatable {
    var totalXP: Int
    var currentLevel: Int
    var currentLevelXP: Int
    var nextLevelXP: Int
    var totalTasksCompleted: Int
    var dailyStreak: Int
    var lastActiveDate: Date
    var dragonStage: DragonStage
    
    init(
        totalXP: Int = 0,
        currentLevel: Int = 1,
        currentLevelXP: Int = 0,
        nextLevelXP: Int = 100,
        totalTasksCompleted: Int = 0,
        dailyStreak: Int = 0,
        lastActiveDate: Date = Date(),
        dragonStage: DragonStage = .egg
    ) {
        self.totalXP = totalXP
        self.currentLevel = currentLevel
        self.currentLevelXP = currentLevelXP
        self.nextLevelXP = nextLevelXP
        self.totalTasksCompleted = totalTasksCompleted
        self.dailyStreak = dailyStreak
        self.lastActiveDate = lastActiveDate
        self.dragonStage = dragonStage
    }
    
    /// XP ekler ve gerekirse level atlar
    mutating func addXP(_ amount: Int) {
        totalXP += amount
        currentLevelXP += amount
        
        // Level atlama kontrolü
        while currentLevelXP >= nextLevelXP {
            levelUp()
        }
        
        // Ejderha evrim kontrolü
        updateDragonStage()
    }
    
    /// Level atlama işlemi
    private mutating func levelUp() {
        currentLevelXP -= nextLevelXP
        currentLevel += 1
        nextLevelXP = calculateNextLevelXP()
    }
    
    /// Sonraki level için gereken XP'yi hesaplar
    /// Formül: 100 * (1.5 ^ (level - 1))
    private func calculateNextLevelXP() -> Int {
        return Int(100 * pow(1.5, Double(currentLevel - 1)))
    }
    
    /// Level'a göre ejderha aşamasını günceller
    private mutating func updateDragonStage() {
        switch currentLevel {
        case 1...5:
            dragonStage = .egg
        case 6...10:
            dragonStage = .cracking
        case 11...15:
            dragonStage = .hatchling
        case 16...25:
            dragonStage = .juvenile
        case 26...40:
            dragonStage = .adult
        default:
            dragonStage = .elder
        }
    }
    
    /// İlerleme yüzdesini hesaplar (0.0 - 1.0)
    var progressPercentage: Double {
        guard nextLevelXP > 0 else { return 0.0 }
        return Double(currentLevelXP) / Double(nextLevelXP)
    }
    
    /// Günlük streak güncellemesi
    mutating func updateStreak() {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(lastActiveDate) {
            // Bugün zaten aktif
            return
        } else if calendar.isDateInYesterday(lastActiveDate) {
            // Dün aktif - streak devam ediyor
            dailyStreak += 1
        } else {
            // Streak kırıldı
            dailyStreak = 1
        }
        
        lastActiveDate = Date()
    }
    
    /// Streak kırıldı mı kontrolü
    func isStreakBroken() -> Bool {
        let calendar = Calendar.current
        return !calendar.isDateInToday(lastActiveDate) && !calendar.isDateInYesterday(lastActiveDate)
    }
}


