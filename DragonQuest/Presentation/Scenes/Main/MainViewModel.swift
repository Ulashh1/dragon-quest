//
//  MainViewModel.swift
//  DragonQuest
//
//  Presentation Layer - Main View Model
//

import Foundation
import Combine

/// Ana ekran için ViewModel
@MainActor
final class MainViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var dailyTasks: [Task] = []
    @Published var weeklyTasks: [Task] = []
    @Published var mainTasks: [Task] = []
    @Published var userProgress: UserProgress = UserProgress()
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showLevelUpAnimation = false
    @Published var selectedTask: Task?
    
    // MARK: - Use Cases
    
    private let getDailyTasksUseCase: GetDailyTasksUseCase
    private let completeTaskUseCase: CompleteTaskUseCase
    private let getUserProgressUseCase: GetUserProgressUseCase
    private let scheduleNotificationUseCase: ScheduleNotificationUseCase
    
    // MARK: - Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Computed Properties
    
    var incompleteDailyTasksCount: Int {
        dailyTasks.filter { !$0.isCompleted }.count
    }
    
    var incompleteWeeklyTasksCount: Int {
        weeklyTasks.filter { !$0.isCompleted }.count
    }
    
    var incompleteMainTasksCount: Int {
        mainTasks.filter { !$0.isCompleted }.count
    }
    
    var totalIncompleteTasksCount: Int {
        incompleteDailyTasksCount + incompleteWeeklyTasksCount + incompleteMainTasksCount
    }
    
    var progressPercentage: Double {
        userProgress.progressPercentage
    }
    
    var currentDragonStage: DragonStage {
        userProgress.dragonStage
    }
    
    // MARK: - Initialization
    
    init(
        getDailyTasksUseCase: GetDailyTasksUseCase,
        completeTaskUseCase: CompleteTaskUseCase,
        getUserProgressUseCase: GetUserProgressUseCase,
        scheduleNotificationUseCase: ScheduleNotificationUseCase
    ) {
        self.getDailyTasksUseCase = getDailyTasksUseCase
        self.completeTaskUseCase = completeTaskUseCase
        self.getUserProgressUseCase = getUserProgressUseCase
        self.scheduleNotificationUseCase = scheduleNotificationUseCase
    }
    
    // MARK: - Public Methods
    
    func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Progress'i yükle
            let progress = try await getUserProgressUseCase.execute()
            userProgress = progress
            
            // Görevleri yükle
            await loadTasks()
            
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func loadTasks() async {
        do {
            let allDailyTasks = try await getDailyTasksUseCase.execute()
            
            // Tiplere göre ayır
            dailyTasks = allDailyTasks.filter { $0.type == .daily }
            weeklyTasks = allDailyTasks.filter { $0.type == .weekly }
            mainTasks = allDailyTasks.filter { $0.type == .main }
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func completeTask(_ task: Task) async {
        do {
            let oldLevel = userProgress.currentLevel
            
            // Görevi tamamla ve XP kazan
            let result = try await completeTaskUseCase.execute(taskId: task.id)
            
            // Progress'i güncelle
            userProgress = result.progress
            
            // Level atlandı mı kontrol et
            if result.progress.currentLevel > oldLevel {
                showLevelUpAnimation = true
            }
            
            // Görevleri yeniden yükle
            await loadTasks()
            
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func toggleTaskCompletion(_ task: Task) async {
        if task.isCompleted {
            // Zaten tamamlanmışsa, bu işlem tersine çevrilemez (business rule)
            errorMessage = "Tamamlanmış görevler geri alınamaz"
            return
        }
        
        await completeTask(task)
    }
    
    func dismissLevelUpAnimation() {
        showLevelUpAnimation = false
    }
    
    func scheduleDailyNotification(at time: Date) async {
        do {
            try await scheduleNotificationUseCase.scheduleDailyReminder(at: time)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func refresh() async {
        await loadData()
    }
}

// MARK: - Mock for Previews
extension MainViewModel {
    static var mock: MainViewModel {
        let taskRepo = TaskRepository()
        let progressRepo = UserProgressRepository()
        let notificationRepo = NotificationService()
        
        return MainViewModel(
            getDailyTasksUseCase: GetDailyTasksUseCase(taskRepository: taskRepo),
            completeTaskUseCase: CompleteTaskUseCase(
                taskRepository: taskRepo,
                progressRepository: progressRepo
            ),
            getUserProgressUseCase: GetUserProgressUseCase(progressRepository: progressRepo),
            scheduleNotificationUseCase: ScheduleNotificationUseCase(
                notificationRepository: notificationRepo,
                taskRepository: taskRepo
            )
        )
    }
}


