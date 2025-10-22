# Dragon Quest - iOS Uygulaması Mimari Dokümantasyonu

## 🏗️ Genel Mimari

Bu proje **Clean Architecture** + **MVVM** + **Coordinator Pattern** kullanarak geliştirilmiştir.

### Katmanlar

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│  (SwiftUI Views, ViewModels, Coordinators)              │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                    Domain Layer                          │
│  (Entities, Use Cases, Repository Protocols)            │
└───────────────────────┬─────────────────────────────────┘
                        │
┌───────────────────────▼─────────────────────────────────┐
│                     Data Layer                           │
│  (Repository Implementations, Core Data, Services)      │
└─────────────────────────────────────────────────────────┘
```

## 📁 Klasör Yapısı

```
DragonQuest/
├── App/
│   ├── DragonQuestApp.swift          # Ana uygulama entry point
│   ├── AppDelegate.swift              # Bildirim ve lifecycle yönetimi
│   └── DIContainer.swift              # Dependency Injection container
│
├── Domain/
│   ├── Entities/
│   │   ├── Task.swift                 # Görev domain entity
│   │   ├── UserProgress.swift         # Kullanıcı ilerleme entity
│   │   ├── Dragon.swift               # Ejderha entity
│   │   └── TaskType.swift             # Görev tipleri enum
│   │
│   ├── UseCases/
│   │   ├── Task/
│   │   │   ├── CreateTaskUseCase.swift
│   │   │   ├── UpdateTaskUseCase.swift
│   │   │   ├── DeleteTaskUseCase.swift
│   │   │   ├── GetDailyTasksUseCase.swift
│   │   │   └── CompleteTaskUseCase.swift
│   │   │
│   │   ├── Progress/
│   │   │   ├── AddXPUseCase.swift
│   │   │   ├── GetUserProgressUseCase.swift
│   │   │   └── CalculateLevelUseCase.swift
│   │   │
│   │   └── Notification/
│   │       ├── ScheduleNotificationUseCase.swift
│   │       └── CancelNotificationUseCase.swift
│   │
│   └── RepositoryProtocols/
│       ├── TaskRepositoryProtocol.swift
│       ├── UserProgressRepositoryProtocol.swift
│       └── NotificationRepositoryProtocol.swift
│
├── Data/
│   ├── Repositories/
│   │   ├── TaskRepository.swift
│   │   ├── UserProgressRepository.swift
│   │   └── NotificationRepository.swift
│   │
│   ├── CoreData/
│   │   ├── DragonQuest.xcdatamodeld   # Core Data model
│   │   ├── CoreDataManager.swift      # Core Data stack yönetimi
│   │   ├── Entities/
│   │   │   ├── TaskEntity+CoreDataClass.swift
│   │   │   ├── TaskEntity+CoreDataProperties.swift
│   │   │   ├── UserProgressEntity+CoreDataClass.swift
│   │   │   └── UserProgressEntity+CoreDataProperties.swift
│   │   │
│   │   └── Mappers/
│   │       ├── TaskMapper.swift       # Entity <-> Domain mapping
│   │       └── UserProgressMapper.swift
│   │
│   └── Services/
│       ├── NotificationService.swift
│       └── CalendarService.swift
│
├── Presentation/
│   ├── Coordinators/
│   │   ├── AppCoordinator.swift
│   │   ├── MainCoordinator.swift
│   │   └── AdminCoordinator.swift
│   │
│   ├── Scenes/
│   │   ├── Main/
│   │   │   ├── MainView.swift
│   │   │   ├── MainViewModel.swift
│   │   │   └── Components/
│   │   │       ├── DragonView.swift
│   │   │       ├── TaskListView.swift
│   │   │       └── ProgressBar.swift
│   │   │
│   │   ├── TaskDetail/
│   │   │   ├── TaskDetailView.swift
│   │   │   └── TaskDetailViewModel.swift
│   │   │
│   │   ├── Admin/
│   │   │   ├── AdminView.swift
│   │   │   ├── AdminViewModel.swift
│   │   │   └── Components/
│   │   │       ├── TaskFormView.swift
│   │   │       └── XPConfigView.swift
│   │   │
│   │   └── Settings/
│   │       ├── SettingsView.swift
│   │       └── SettingsViewModel.swift
│   │
│   └── Common/
│       ├── ViewModifiers/
│       ├── Extensions/
│       └── Theme/
│           ├── Colors.swift
│           └── Fonts.swift
│
├── Resources/
│   ├── Animations/          # Lottie/Rive animasyon dosyaları
│   ├── Images.xcassets/
│   └── Localizable.strings
│
└── Tests/
    ├── DomainTests/
    │   └── UseCaseTests/
    ├── DataTests/
    │   └── RepositoryTests/
    └── PresentationTests/
        └── ViewModelTests/
```

## 🔄 Veri Akışı

### Görev Tamamlama Akışı Örneği:

1. **View** → Kullanıcı görevi tamamladı butonuna basar
2. **ViewModel** → `completeTask()` metodunu çağırır
3. **UseCase** → `CompleteTaskUseCase` çalışır
4. **Repository** → Core Data'yı günceller
5. **UseCase** → `AddXPUseCase` XP ekler
6. **Repository** → UserProgress güncellenir
7. **ViewModel** → State güncellenir
8. **View** → UI otomatik olarak güncellenir (SwiftUI binding)

## 🎯 Temel Prensipler

### Clean Architecture
- **Bağımlılık Kuralı**: İç katmanlar dış katmanları bilmez
- **Domain** katmanı hiçbir framework'e bağımlı değil
- **Data** ve **Presentation** katmanları Domain'e bağımlı

### MVVM
- **View**: Sadece görsel sunum (SwiftUI)
- **ViewModel**: Business logic ve state yönetimi
- **Model**: Domain entities

### Dependency Injection
- Protokol tabanlı tasarım
- Constructor injection
- Test edilebilirlik için mock'lar kolay

### Single Responsibility
- Her class tek bir sorumluluğa sahip
- Use Case'ler atomik operasyonlar

## 🔧 Teknoloji Stack

- **UI Framework**: SwiftUI
- **Database**: Core Data
- **Animation**: Lottie veya Rive
- **Notifications**: UNUserNotificationCenter
- **DI**: Manuel (Protocol-based)
- **Package Manager**: Swift Package Manager
- **Testing**: XCTest

## 📱 Özellikler

### XP ve Level Sistemi
- Her görev türü farklı XP değerine sahip
- XP biriktikçe level atlanır
- Level formülü: `level = floor(sqrt(totalXP / 100))`
- Ejderha görselliği level'a göre değişir

### Bildirim Sistemi
- Kullanıcı tarafından ayarlanabilir zaman
- Günlük hatırlatma (incomplete task count)
- Adaptive scheduling (uyku saati dikkate alınır)

### Görev Tipleri
- **Daily**: Her gün tekrar eden
- **Weekly**: Haftalık hedefler
- **Main**: Ana görevler (quest'ler)

### Admin Panel
- Görev oluştur/düzenle/sil
- XP değerlerini ayarla
- Preset görevler ekle

## 🧪 Test Stratejisi

- **Unit Tests**: Use Cases, ViewModels
- **Integration Tests**: Repository + Core Data
- **UI Tests**: Critical user flows (opsiyonel)

## 🚀 Gelecek Geliştirmeler

- Backend entegrasyonu (Firebase/Custom API)
- Sosyal özellikler (leaderboard, arkadaş sistemi)
- Daha fazla ejderha türü
- Achievement sistemi
- Widget desteği


