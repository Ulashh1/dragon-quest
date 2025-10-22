//
//  CreateTaskUseCase.swift
//  DragonQuest
//
//  Domain Layer - Use Case
//

import Foundation

/// Yeni görev oluşturma use case
final class CreateTaskUseCase {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    /// Yeni görev oluşturur
    /// - Parameter task: Oluşturulacak görev
    /// - Returns: Oluşturulan görev
    func execute(task: Task) async throws -> Task {
        // Validasyon
        guard !task.title.trimmingCharacters(in: .whitespaces).isEmpty else {
            throw TaskError.invalidTitle
        }
        
        guard task.xpValue > 0 else {
            throw TaskError.invalidXPValue
        }
        
        // Repository üzerinden görev oluştur
        return try await taskRepository.createTask(task)
    }
}

// MARK: - Task Errors
enum TaskError: LocalizedError {
    case invalidTitle
    case invalidXPValue
    case taskNotFound
    case alreadyCompleted
    
    var errorDescription: String? {
        switch self {
        case .invalidTitle:
            return "Görev başlığı boş olamaz"
        case .invalidXPValue:
            return "XP değeri 0'dan büyük olmalıdır"
        case .taskNotFound:
            return "Görev bulunamadı"
        case .alreadyCompleted:
            return "Bu görev zaten tamamlanmış"
        }
    }
}


