# 🎮 Dragon Quest - Kullanım Örnekleri

Bu dosya, Dragon Quest kodlarının nasıl kullanılacağını gösteren pratik örnekler içerir.

## 📋 İçindekiler

1. [Yeni Görev Oluşturma](#yeni-görev-oluşturma)
2. [Görev Tamamlama](#görev-tamamlama)
3. [XP Ekleme](#xp-ekleme)
4. [Bildirim Planlama](#bildirim-planlama)
5. [Custom ViewModel Oluşturma](#custom-viewmodel-oluşturma)
6. [Repository Kullanımı](#repository-kullanımı)

---

## Yeni Görev Oluşturma

### Basit Örnek

```swift
// ViewModel içinde
class MyViewModel: ObservableObject {
    private let createTaskUseCase: CreateTaskUseCase
    
    func createDailyTask() async {
        let task = Task(
            title: "Sabah Egzersizi",
            description: "30 dakika koşu",
            type: .daily,
            xpValue: 20,
            priority: .high,
            repeatDaily: true
        )
        
        do {
            let createdTask = try await createTaskUseCase.execute(task: task)
            print("Görev oluşturuldu: \(createdTask.title)")
        } catch {
            print("Hata: \(error)")
        }
    }
}
```

### Planlı Görev

```swift
func createScheduledTask() async {
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    let task = Task(
        title: "Doktor Randevusu",
        description: "Saat 14:00'te",
        type: .main,
        xpValue: 50,
        priority: .critical,
        scheduledDate: tomorrow
    )
    
    do {
        _ = try await createTaskUseCase.execute(task: task)
    } catch {
        handleError(error)
    }
}
```

### Haftalık Tekrarlanan Görev

```swift
func createWeeklyGoal() async {
    let task = Task(
        title: "3 Kitap Oku",
        type: .weekly,
        xpValue: 100,
        priority: .medium,
        repeatWeekly: true,
        tags: ["okuma", "gelişim"]
    )
    
    _ = try? await createTaskUseCase.execute(task: task)
}
```

---

## Görev Tamamlama

### Temel Kullanım

```swift
class TaskViewModel: ObservableObject {
    @Published var showLevelUp = false
    private let completeTaskUseCase: CompleteTaskUseCase
    
    func complete(task: Task) async {
        do {
            let result = try await completeTaskUseCase.execute(taskId: task.id)
            
            // Tamamlanan görev
            print("Görev: \(result.task.title)")
            
            // Kazanılan XP
            print("XP: +\(result.task.xpValue)")
            
            // Güncel progress
            print("Level: \(result.progress.currentLevel)")
            print("XP: \(result.progress.currentLevelXP)/\(result.progress.nextLevelXP)")
            
            // Level atlama kontrolü
            if result.progress.currentLevel > oldLevel {
                showLevelUp = true
            }
        } catch {
            handleError(error)
        }
    }
}
```

### Toplu Tamamlama

```swift
func completeAllDailyTasks(_ tasks: [Task]) async {
    for task in tasks where !task.isCompleted {
        try? await completeTaskUseCase.execute(taskId: task.id)
    }
    
    // Tüm görevler tamamlandı
    await refreshTasks()
}
```

---

## XP Ekleme

### Manuel XP Ekleme

```swift
class ProgressViewModel: ObservableObject {
    private let addXPUseCase: AddXPUseCase
    
    func awardBonus(amount: Int) async {
        do {
            let result = try await addXPUseCase.execute(amount: amount)
            
            if result.leveledUp {
                print("🎉 Level Up! Yeni level: \(result.newLevel!)")
                celebrateLevelUp(level: result.newLevel!)
            }
            
            print("Total XP: \(result.progress.totalXP)")
        } catch {
            print("XP eklenemedi: \(error)")
        }
    }
}
```

### Bonus XP Sistemi

```swift
func giveStreakBonus() async {
    let progress = try? await getUserProgressUseCase.execute()
    
    if let streak = progress?.dailyStreak, streak >= 7 {
        // 7 günlük streak bonusu
        let bonusXP = 50
        _ = try? await addXPUseCase.execute(amount: bonusXP)
        
        showNotification("🔥 \(streak) günlük seri! +\(bonusXP) bonus XP")
    }
}
```

---

## Bildirim Planlama

### Günlük Hatırlatma

```swift
class SettingsViewModel: ObservableObject {
    private let scheduleNotificationUseCase: ScheduleNotificationUseCase
    
    func setupDailyReminder(at time: Date) async {
        do {
            try await scheduleNotificationUseCase.scheduleDailyReminder(at: time)
            print("Günlük hatırlatma ayarlandı: \(time)")
        } catch {
            print("Bildirim ayarlanamadı: \(error)")
        }
    }
}
```

### Görev Bazlı Hatırlatma

```swift
func scheduleTaskReminder(for task: Task, date: Date) async {
    do {
        try await scheduleNotificationUseCase.scheduleTaskReminder(
            for: task.id,
            at: date
        )
        
        print("Hatırlatma: \(task.title) - \(date)")
    } catch NotificationError.authorizationDenied {
        showAlert("Bildirim izni gerekli!")
    } catch {
        print("Hata: \(error)")
    }
}
```

---

## Custom ViewModel Oluşturma

### Yeni Ekran için ViewModel

```swift
@MainActor
final class StatisticsViewModel: ObservableObject {
    // Published properties
    @Published var totalXP: Int = 0
    @Published var totalTasks: Int = 0
    @Published var currentStreak: Int = 0
    @Published var isLoading = false
    
    // Dependencies
    private let getUserProgressUseCase: GetUserProgressUseCase
    private let taskRepository: TaskRepositoryProtocol
    
    init(
        getUserProgressUseCase: GetUserProgressUseCase,
        taskRepository: TaskRepositoryProtocol
    ) {
        self.getUserProgressUseCase = getUserProgressUseCase
        self.taskRepository = taskRepository
    }
    
    func loadStatistics() async {
        isLoading = true
        
        do {
            let progress = try await getUserProgressUseCase.execute()
            totalXP = progress.totalXP
            totalTasks = progress.totalTasksCompleted
            currentStreak = progress.dailyStreak
            
            isLoading = false
        } catch {
            print("İstatistikler yüklenemedi: \(error)")
            isLoading = false
        }
    }
}
```

### View Entegrasyonu

```swift
struct StatisticsView: View {
    @StateObject var viewModel: StatisticsViewModel
    
    var body: some View {
        VStack {
            Text("Total XP: \(viewModel.totalXP)")
            Text("Tasks: \(viewModel.totalTasks)")
            Text("Streak: \(viewModel.currentStreak) 🔥")
        }
        .task {
            await viewModel.loadStatistics()
        }
    }
}
```

---

## Repository Kullanımı

### Direct Repository Access (Nadiren kullanılır)

```swift
class AdvancedTaskManager {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    // Tüm tamamlanmış görevleri getir
    func getCompletedTasks() async throws -> [Task] {
        let allTasks = try await taskRepository.getAllTasks()
        return allTasks.filter { $0.isCompleted }
    }
    
    // Yüksek öncelikli görevleri getir
    func getHighPriorityTasks() async throws -> [Task] {
        let allTasks = try await taskRepository.getAllTasks()
        return allTasks.filter { 
            $0.priority == .high || $0.priority == .critical 
        }
    }
    
    // Bu haftanın görevlerini getir
    func getWeeklyTasks() async throws -> [Task] {
        return try await taskRepository.getTasks(ofType: .weekly)
    }
}
```

### Repository ile Reaktif Dinleme

```swift
class TaskObserver: ObservableObject {
    @Published var tasks: [Task] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(taskRepository: TaskRepositoryProtocol) {
        // Task değişikliklerini dinle
        taskRepository.tasksPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newTasks in
                self?.tasks = newTasks
                print("Görevler güncellendi: \(newTasks.count)")
            }
            .store(in: &cancellables)
    }
}
```

---

## Gelişmiş Örnekler

### Custom Use Case Oluşturma

```swift
// Yeni bir use case
final class GetWeeklyStatsUseCase {
    private let taskRepository: TaskRepositoryProtocol
    
    init(taskRepository: TaskRepositoryProtocol) {
        self.taskRepository = taskRepository
    }
    
    func execute() async throws -> WeeklyStats {
        let allTasks = try await taskRepository.getAllTasks()
        
        let weekStart = Calendar.current.startOfWeek(for: Date())
        let weekTasks = allTasks.filter { task in
            guard let completedAt = task.completedAt else { return false }
            return completedAt >= weekStart
        }
        
        return WeeklyStats(
            totalCompleted: weekTasks.count,
            totalXP: weekTasks.reduce(0) { $0 + $1.xpValue },
            averagePerDay: weekTasks.count / 7
        )
    }
}

struct WeeklyStats {
    let totalCompleted: Int
    let totalXP: Int
    let averagePerDay: Int
}
```

### Dependency Injection ile Custom Flow

```swift
// DIContainer'a yeni dependency ekle
extension DIContainer {
    func makeStatisticsViewModel() -> StatisticsViewModel {
        StatisticsViewModel(
            getUserProgressUseCase: getUserProgressUseCase,
            taskRepository: taskRepository
        )
    }
}

// Kullanımı
struct StatisticsScreen: View {
    @StateObject var viewModel = DIContainer.shared.makeStatisticsViewModel()
    
    var body: some View {
        StatisticsView(viewModel: viewModel)
    }
}
```

### Error Handling Patterns

```swift
extension MainViewModel {
    func handleTaskCompletion(_ task: Task) async {
        do {
            let result = try await completeTaskUseCase.execute(taskId: task.id)
            
            // Success
            await onTaskCompleted(result)
            
        } catch TaskError.taskNotFound {
            errorMessage = "Görev bulunamadı"
        } catch TaskError.alreadyCompleted {
            errorMessage = "Bu görev zaten tamamlanmış"
        } catch {
            errorMessage = "Beklenmeyen hata: \(error.localizedDescription)"
        }
    }
    
    private func onTaskCompleted(_ result: (task: Task, progress: UserProgress)) async {
        // XP animasyonu göster
        showXPAnimation(amount: result.task.xpValue)
        
        // Level atlama kontrolü
        if result.progress.currentLevel > oldLevel {
            showLevelUpAnimation = true
        }
        
        // Görevleri yenile
        await loadTasks()
    }
}
```

---

## Test Örnekleri

### Use Case Test

```swift
import XCTest

class CompleteTaskUseCaseTests: XCTestCase {
    var sut: CompleteTaskUseCase!
    var mockTaskRepo: MockTaskRepository!
    var mockProgressRepo: MockUserProgressRepository!
    
    override func setUp() {
        mockTaskRepo = MockTaskRepository()
        mockProgressRepo = MockUserProgressRepository()
        sut = CompleteTaskUseCase(
            taskRepository: mockTaskRepo,
            progressRepository: mockProgressRepo
        )
    }
    
    func testCompleteTask_Success() async throws {
        // Given
        let task = Task.mockDaily
        mockTaskRepo.tasks = [task]
        
        // When
        let result = try await sut.execute(taskId: task.id)
        
        // Then
        XCTAssertTrue(result.task.isCompleted)
        XCTAssertNotNil(result.task.completedAt)
        XCTAssertEqual(mockProgressRepo.addedXP, task.xpValue)
    }
}
```

---

## 💡 Best Practices

### 1. Async/Await Kullanımı

```swift
// ✅ Good
func loadData() async {
    do {
        let tasks = try await taskRepository.getAllTasks()
        self.tasks = tasks
    } catch {
        handleError(error)
    }
}

// ❌ Bad
func loadData() {
    Task {
        let tasks = try? await taskRepository.getAllTasks()
        DispatchQueue.main.async {
            self.tasks = tasks ?? []
        }
    }
}
```

### 2. Dependency Injection

```swift
// ✅ Good - Constructor injection
class MyViewModel {
    private let useCase: MyUseCase
    
    init(useCase: MyUseCase) {
        self.useCase = useCase
    }
}

// ❌ Bad - Singleton dependency
class MyViewModel {
    private let useCase = DIContainer.shared.myUseCase
}
```

### 3. Error Handling

```swift
// ✅ Good - Specific error handling
do {
    try await createTask(task)
} catch TaskError.invalidTitle {
    showError("Başlık boş olamaz")
} catch {
    showError("Genel hata")
}

// ❌ Bad - Silent failure
try? await createTask(task)
```

---

**Daha fazla örnek için kod dosyalarına bakın! 🐉**


