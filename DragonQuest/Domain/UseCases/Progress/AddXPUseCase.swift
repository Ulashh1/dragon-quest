//
//  AddXPUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// XP ekleme use case
final class AddXPUseCase {
    private let progressRepository: UserProgressRepositoryProtocol
    
    init(progressRepository: UserProgressRepositoryProtocol) {
        self.progressRepository = progressRepository
    }
    
    /// Kullanıcıya XP ekler
    /// - Parameter amount: Eklenecek XP miktarı
    /// - Returns: Güncellenmiş progress ve level atlama bilgisi
    func execute(amount: Int) async throws -> (progress: UserProgress, leveledUp: Bool, newLevel: Int?) {
        guard amount > 0 else {
            throw ProgressError.invalidXPAmount
        }
        
        // Mevcut progress'i al
        let oldProgress = try await progressRepository.getUserProgress()
        let oldLevel = oldProgress.currentLevel
        
        // XP ekle
        let newProgress = try await progressRepository.addXP(amount)
        
        // Level atlama kontrolü
        let leveledUp = newProgress.currentLevel > oldLevel
        let newLevel = leveledUp ? newProgress.currentLevel : nil
        
        return (newProgress, leveledUp, newLevel)
    }
}

// MARK: - Progress Errors
enum ProgressError: LocalizedError {
    case invalidXPAmount
    case progressNotFound
    
    var errorDescription: String? {
        switch self {
        case .invalidXPAmount:
            return "XP miktarı 0'dan büyük olmalıdır"
        case .progressNotFound:
            return "Kullanıcı ilerlemesi bulunamadı"
        }
    }
}


