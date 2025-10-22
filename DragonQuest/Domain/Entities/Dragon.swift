//
//  Dragon.swift
//  DragonQuest
//
//  Domain Layer - Entity
//

import Foundation

/// Ejderha evrim aşamaları
enum DragonStage: Int, Codable, CaseIterable {
    case egg = 0          // Yumurta (Level 1-5)
    case cracking = 1     // Çatlayan yumurta (Level 6-10)
    case hatchling = 2    // Yavru ejderha (Level 11-15)
    case juvenile = 3     // Genç ejderha (Level 16-25)
    case adult = 4        // Yetişkin ejderha (Level 26-40)
    case elder = 5        // Yaşlı/Efsanevi ejderha (Level 41+)
    
    /// Aşamanın görsel adı
    var displayName: String {
        switch self {
        case .egg:
            return "Gizemli Yumurta"
        case .cracking:
            return "Çatlayan Yumurta"
        case .hatchling:
            return "Yavru Ejderha"
        case .juvenile:
            return "Genç Ejderha"
        case .adult:
            return "Yetişkin Ejderha"
        case .elder:
            return "Efsanevi Ejderha"
        }
    }
    
    /// Aşamanın açıklaması
    var description: String {
        switch self {
        case .egg:
            return "Gizemli bir enerji yumurtanın içinde nabız gibi atıyor..."
        case .cracking:
            return "Yumurta çatlamaya başladı! İçindeki varlık dışarı çıkmak istiyor!"
        case .hatchling:
            return "Küçük bir ejderha dünyaya geldi! Henüz çok zayıf ama potansiyeli sınırsız."
        case .juvenile:
            return "Ejderhan büyüyor ve güçleniyor. Artık kanatlarını açabiliyor!"
        case .adult:
            return "Muhteşem bir yaratık! Ejderhan tam gücüne ulaştı."
        case .elder:
            return "Efsanevi bir varlık! Bu ejderha zamanın ötesinde bir güce sahip."
        }
    }
    
    /// Animasyon dosya adı (Lottie/Rive)
    var animationName: String {
        switch self {
        case .egg:
            return "dragon_egg"
        case .cracking:
            return "dragon_egg_cracking"
        case .hatchling:
            return "dragon_hatchling"
        case .juvenile:
            return "dragon_juvenile"
        case .adult:
            return "dragon_adult"
        case .elder:
            return "dragon_elder"
        }
    }
    
    /// Minimum level gerekliliği
    var minimumLevel: Int {
        switch self {
        case .egg: return 1
        case .cracking: return 6
        case .hatchling: return 11
        case .juvenile: return 16
        case .adult: return 26
        case .elder: return 41
        }
    }
    
    /// Sonraki aşama varsa döndürür
    var nextStage: DragonStage? {
        DragonStage(rawValue: self.rawValue + 1)
    }
    
    /// Önceki aşama varsa döndürür
    var previousStage: DragonStage? {
        DragonStage(rawValue: self.rawValue - 1)
    }
}

/// Ejderha entity
struct Dragon: Equatable {
    var stage: DragonStage
    var name: String
    var level: Int
    
    init(stage: DragonStage = .egg, name: String = "Drakonis", level: Int = 1) {
        self.stage = stage
        self.name = name
        self.level = level
    }
    
    /// Level'a göre aşamayı günceller
    mutating func updateStage(basedOnLevel level: Int) {
        self.level = level
        
        switch level {
        case 1...5:
            stage = .egg
        case 6...10:
            stage = .cracking
        case 11...15:
            stage = .hatchling
        case 16...25:
            stage = .juvenile
        case 26...40:
            stage = .adult
        default:
            stage = .elder
        }
    }
    
    /// Sonraki evrime ne kadar kaldığını hesaplar
    func levelsUntilNextEvolution() -> Int? {
        guard let nextStage = stage.nextStage else {
            return nil // Zaten son aşamada
        }
        
        return max(0, nextStage.minimumLevel - level)
    }
    
    /// Ejderhanın güç seviyesini hesaplar
    var powerLevel: Int {
        return level * 10 + stage.rawValue * 50
    }
}

// MARK: - Mock Data
extension Dragon {
    static var mock: Dragon {
        Dragon(stage: .hatchling, name: "Drakonis", level: 12)
    }
}


