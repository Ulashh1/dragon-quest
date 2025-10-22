//
//  AdminViewModel.swift
//  DragonQuest
//
//  Presentation Layer - Admin View Model
//

import Foundation
import Combine

/// Admin panel için ViewModel
@MainActor
final class AdminViewModel: ObservableObject {
    // MARK: - Published Properties
    
    @Published var tasks: [Task] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showingAddTask = false
    @Published var editingTask: Task?
    
    // MARK: - Form Properties
    
    @Published var taskTitle = ""
    @Published var taskDescription = ""
    @Published var selectedTaskType: TaskType = .daily
    @Published var xpValue = 10
    @Published var selectedPriority: TaskPriority = .medium
    @Published var scheduledDate: Date?
    @Published var repeatDaily = false
    @Published var repeatWeekly = false
    
    // MARK: - Use Cases
    
    private let createTaskUseCase: CreateTaskUseCase
    private let getDailyTasksUseCase: GetDailyTasksUseCase
    private let taskRepository: TaskRepositoryProtocol
    
    // MARK: - Initialization
    
    init(
        createTaskUseCase: CreateTaskUseCase,
        getDailyTasksUseCase: GetDailyTasksUseCase,
        taskRepository: TaskRepositoryProtocol
    ) {
        self.createTaskUseCase = createTaskUseCase
        self.getDailyTasksUseCase = getDailyTasksUseCase
        self.taskRepository = taskRepository
    }
    
    // MARK: - Public Methods
    
    func loadTasks() async {
        isLoading = true
        
        do {
            tasks = try await taskRepository.getAllTasks()
            isLoading = false
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func createTask() async {
        guard !taskTitle.isEmpty else {
            errorMessage = "Görev başlığı boş olamaz"
            return
        }
        
        let newTask = Task(
            title: taskTitle,
            description: taskDescription.isEmpty ? nil : taskDescription,
            type: selectedTaskType,
            xpValue: xpValue,
            priority: selectedPriority,
            scheduledDate: scheduledDate,
            repeatDaily: repeatDaily,
            repeatWeekly: repeatWeekly
        )
        
        do {
            _ = try await createTaskUseCase.execute(task: newTask)
            
            // Form'u temizle
            resetForm()
            
            // Görevleri yeniden yükle
            await loadTasks()
            
            showingAddTask = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteTask(_ task: Task) async {
        do {
            try await taskRepository.deleteTask(withId: task.id)
            await loadTasks()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func resetForm() {
        taskTitle = ""
        taskDescription = ""
        selectedTaskType = .daily
        xpValue = 10
        selectedPriority = .medium
        scheduledDate = nil
        repeatDaily = false
        repeatWeekly = false
    }
    
    func showAddTaskSheet() {
        resetForm()
        showingAddTask = true
    }
    
    func createPresetTasks() async {
        let presets: [Task] = [
            Task(title: "30 Dakika Egzersiz", type: .daily, xpValue: 20, priority: .high, repeatDaily: true),
            Task(title: "1 Litre Su İç", type: .daily, xpValue: 10, priority: .medium, repeatDaily: true),
            Task(title: "Kitap Oku (30 dk)", type: .daily, xpValue: 15, priority: .medium, repeatDaily: true),
            Task(title: "Meditasyon", type: .daily, xpValue: 10, priority: .low, repeatDaily: true),
            Task(title: "2 Saat Öğrenme", type: .weekly, xpValue: 50, priority: .high, repeatWeekly: true),
            Task(title: "Yeni Beceri Öğren", type: .main, xpValue: 100, priority: .critical)
        ]
        
        for task in presets {
            do {
                _ = try await createTaskUseCase.execute(task: task)
            } catch {
                print("Preset task creation failed: \(error)")
            }
        }
        
        await loadTasks()
    }
}

// MARK: - Mock for Previews
extension AdminViewModel {
    static var mock: AdminViewModel {
        let taskRepo = TaskRepository()
        let progressRepo = UserProgressRepository()
        
        return AdminViewModel(
            createTaskUseCase: CreateTaskUseCase(taskRepository: taskRepo),
            getDailyTasksUseCase: GetDailyTasksUseCase(taskRepository: taskRepo),
            taskRepository: taskRepo
        )
    }
}


