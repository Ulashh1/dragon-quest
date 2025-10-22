# 🚀 Dragon Quest - Başlangıç Kılavuzu

Bu doküman, Dragon Quest projesini ilk defa kuran geliştiriciler için adım adım bir kılavuzdur.

## 📋 Ön Gereksinimler

### Donanım
- Mac (Apple Silicon veya Intel)
- En az 8GB RAM (16GB önerilir)
- 5GB boş disk alanı

### Yazılım
- **macOS**: 13.0 (Ventura) veya üzeri
- **Xcode**: 15.0 veya üzeri
- **iOS Deployment Target**: 16.0+
- **Git**: Proje klonlamak için

## 🛠️ Kurulum Adımları

### 1. Xcode Kurulumu

App Store'dan Xcode'u indirin:
```bash
# Terminal'de Xcode komut satırı araçlarını yükleyin
xcode-select --install
```

### 2. Projeyi Klonlayın

```bash
# HTTPS ile
git clone https://github.com/yourusername/dragon-quest.git

# veya SSH ile
git clone git@github.com:yourusername/dragon-quest.git

# Proje klasörüne girin
cd dragon-quest
```

### 3. Xcode'da Açın

```bash
open DragonQuest.xcodeproj
```

veya Xcode'u manuel olarak açıp File → Open → `DragonQuest.xcodeproj` seçin.

### 4. Swift Package Dependencies

Xcode otomatik olarak bağımlılıkları çözümler. Manuel çözümleme için:

1. Xcode → File → Packages → Resolve Package Versions
2. Bağımlılıklar indirilene kadar bekleyin

### 5. Build ve Run

1. Scheme olarak "DragonQuest" seçildiğinden emin olun
2. Simulatör seçin (örn: iPhone 15)
3. ⌘R (Command + R) tuşlarına basın

## 📱 İlk Çalıştırma

### Uygulama İlk Açıldığında

1. **Core Data İnit**: Otomatik olarak `DragonQuest.sqlite` oluşturulur
2. **UserProgress**: Varsayılan progress kaydı oluşturulur
3. **Bildirim İzni**: Sistem izin dialogu gösterilir
   - "Allow" seçin (test için)
   - İstemezseniz "Don't Allow" (bildirimler çalışmaz)

### İlk Görev Ekleme

1. Sağ üstteki ⚙️ (settings) ikonuna tıklayın
2. Admin panelinde ➕ butonuna basın
3. Örnek görev ekleyin:
   - **Başlık**: "30 Dakika Egzersiz"
   - **Tip**: Günlük
   - **XP**: 20
   - **Öncelik**: Yüksek
4. "Kaydet" butonuna basın
5. Ana ekrana geri dönün

### Görev Tamamlama

1. Eklediğiniz göreve tıklayın
2. ✓ işareti belirecek
3. XP kazanacaksınız
4. Progress bar güncellenecek

## 🧪 Geliştirme Ortamı

### Debug vs Release

**Debug Mode** (varsayılan):
```swift
#if DEBUG
print("Debug mode aktif")
#endif
```

**Release Mode**:
Product → Scheme → Edit Scheme → Run → Build Configuration → Release

### Simulatör Kısayolları

- **⌘R**: Run
- **⌘.**: Stop
- **⌘K**: Keyboard toggle
- **⌘⇧H**: Home button
- **Device → Rotate**: Ekran döndürme

### Core Data Debug

Core Data aktivitelerini görmek için:

1. Edit Scheme → Run → Arguments
2. Arguments Passed On Launch:
   ```
   -com.apple.CoreData.SQLDebug 1
   ```

## 🗂️ Klasör Yapısını Anlamak

```
DragonQuest/
├── App/              ← Başlangıç noktası (DragonQuestApp.swift)
├── Domain/           ← İş mantığı (entities, use cases)
├── Data/             ← Veri katmanı (repositories, Core Data)
├── Presentation/     ← UI (views, view models)
└── Resources/        ← Assets, animasyonlar
```

### Yeni Özellik Eklerken

1. **Domain**: Entity ve Use Case ekle
2. **Data**: Repository implementasyonu
3. **Presentation**: View ve ViewModel
4. **DI Container**: Bağımlılıkları kaydet

## 🎨 Tasarım Sistemi

Tema renkleri ve stilleri için:

```swift
// Renkler
AppColors.primary        // Mavi
AppColors.secondary      // Mor
AppColors.accent         // Turuncu

// Fontlar
AppFonts.largeTitle
AppFonts.headline
AppFonts.body

// Spacing
AppSpacing.small    // 8pt
AppSpacing.medium   // 16pt
AppSpacing.large    // 24pt
```

## 🧩 Önemli Dosyalar

### Uygulama Giriş Noktası
```swift
// DragonQuest/App/DragonQuestApp.swift
@main
struct DragonQuestApp: App {
    var body: some Scene { ... }
}
```

### Core Data Model
```
DragonQuest/Data/CoreData/DragonQuest.xcdatamodeld
```

### Ana View
```swift
// DragonQuest/Presentation/Scenes/Main/MainView.swift
struct MainView: View { ... }
```

### Dependency Injection
```swift
// DragonQuest/App/DIContainer.swift
let container = DIContainer.shared
```

## 🐛 Sık Karşılaşılan Sorunlar

### Problem: Build Failed - "Cannot find module"

**Çözüm**:
```bash
# Clean build folder
⌘⇧K (Command + Shift + K)

# Packages'ı sıfırla
File → Packages → Reset Package Caches
```

### Problem: Core Data hatası

**Çözüm**:
```bash
# Simulator'ı sıfırla
Device → Erase All Content and Settings...
```

### Problem: Simulatör çok yavaş

**Çözüm**:
- Hardware → Graphics → Metal kullanın
- Daha az kaynak tüketen simulatör seçin (iPhone SE)
- Xcode → Preferences → Components → eski iOS versiyonları silin

### Problem: Live Preview çalışmıyor

**Çözüm**:
```bash
# Xcode'u yeniden başlatın
# Derived Data'yı silin:
rm -rf ~/Library/Developer/Xcode/DerivedData
```

## 📚 Öğrenme Kaynakları

### SwiftUI
- [Apple SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Hacking with Swift](https://www.hackingwithswift.com/100/swiftui)

### Clean Architecture
- [Clean Architecture - Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [iOS Clean Architecture](https://tech.olx.com/clean-architecture-and-mvvm-on-ios-c9d167d9f5b3)

### Core Data
- [Apple Core Data Programming Guide](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/)
- [Ray Wenderlich Core Data Tutorial](https://www.raywenderlich.com/books/core-data-by-tutorials)

## 🔧 Geliştirme Araçları

### Önerilen Xcode Extensions
- SwiftLint (kod kalitesi)
- SwiftFormat (kod formatlama)

### Debugging Tools
- LLDB (Xcode debugger)
- Instruments (performance profiling)
- Network Link Conditioner (network testing)

## 📝 Kod Yazma Kuralları

### Swift Style Guide
```swift
// ✅ Good
func calculateNextLevelXP() -> Int {
    return Int(100 * pow(1.5, Double(currentLevel - 1)))
}

// ❌ Bad
func calc_next_lvl_xp()->Int{return Int(100*pow(1.5,Double(currentLevel-1)))}
```

### MVVM Pattern
```swift
// ✅ Good - ViewModel
class MainViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func loadTasks() async { ... }
}

// ✅ Good - View
struct MainView: View {
    @StateObject var viewModel: MainViewModel
    
    var body: some View { ... }
}
```

## 🎯 Sonraki Adımlar

1. ✅ Projeyi çalıştırın
2. ✅ İlk görev ekleyin ve tamamlayın
3. ✅ Level atlayın
4. 📖 [ARCHITECTURE.md](ARCHITECTURE.md) dosyasını okuyun
5. 📖 [XP_LEVEL_SYSTEM.md](XP_LEVEL_SYSTEM.md) dosyasını okuyun
6. 🚀 Yeni özellik ekleyin

## ❓ Yardım

Sorunlarla karşılaşırsanız:

1. **Dokümantasyonu kontrol edin**: README.md, ARCHITECTURE.md
2. **Issue açın**: GitHub Issues
3. **Email**: contact@dragonquest.app

## 🎉 Tebrikler!

Dragon Quest geliştirme ortamınız hazır. İyi kodlamalar! 🐉✨


