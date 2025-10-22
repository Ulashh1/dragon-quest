//
//  DIContainer.swift
//  DragonQuest
//
//  App Layer - Dependency Injection Container
//

import Foundation

/// Dependency Injection Container
/// Tüm bağımlılıkları yönetir ve sağlar
final class DIContainer {
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Core Data
    
    lazy var coreDataManager: CoreDataManager = {
        CoreDataManager.shared
    }()
    
    // MARK: - Repositories
    
    lazy var taskRepository: TaskRepositoryProtocol = {
        TaskRepository(coreDataManager: coreDataManager)
    }()
    
    lazy var userProgressRepository: UserProgressRepositoryProtocol = {
        UserProgressRepository(coreDataManager: coreDataManager)
    }()
    
    lazy var notificationRepository: NotificationRepositoryProtocol = {
        NotificationService()
    }()
    
    // MARK: - Use Cases - Task
    
    lazy var createTaskUseCase: CreateTaskUseCase = {
        CreateTaskUseCase(taskRepository: taskRepository)
    }()
    
    lazy var getDailyTasksUseCase: GetDailyTasksUseCase = {
        GetDailyTasksUseCase(taskRepository: taskRepository)
    }()
    
    lazy var completeTaskUseCase: CompleteTaskUseCase = {
        CompleteTaskUseCase(
            taskRepository: taskRepository,
            progressRepository: userProgressRepository
        )
    }()
    
    // MARK: - Use Cases - Progress
    
    lazy var getUserProgressUseCase: GetUserProgressUseCase = {
        GetUserProgressUseCase(progressRepository: userProgressRepository)
    }()
    
    lazy var addXPUseCase: AddXPUseCase = {
        AddXPUseCase(progressRepository: userProgressRepository)
    }()
    
    // MARK: - Use Cases - Notification
    
    lazy var scheduleNotificationUseCase: ScheduleNotificationUseCase = {
        ScheduleNotificationUseCase(
            notificationRepository: notificationRepository,
            taskRepository: taskRepository
        )
    }()
    
    // MARK: - View Models
    
    func makeMainViewModel() -> MainViewModel {
        MainViewModel(
            getDailyTasksUseCase: getDailyTasksUseCase,
            completeTaskUseCase: completeTaskUseCase,
            getUserProgressUseCase: getUserProgressUseCase,
            scheduleNotificationUseCase: scheduleNotificationUseCase
        )
    }
    
    func makeAdminViewModel() -> AdminViewModel {
        AdminViewModel(
            createTaskUseCase: createTaskUseCase,
            getDailyTasksUseCase: getDailyTasksUseCase,
            taskRepository: taskRepository
        )
    }
    
    // MARK: - Coordinator
    
    lazy var appCoordinator: AppCoordinator = {
        AppCoordinator()
    }()
}


