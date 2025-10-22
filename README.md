# 📱 test123 - iOS Uygulaması

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-4.0-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

iOS test ve geliştirme projesi. SwiftUI, CoreData ve Clean Architecture kullanılarak geliştirilmiştir.

---

## 💻 Mac Kullanmıyorum!

**Windows/Linux kullanıcıları için**:
- ⚡ **[Hızlı Başlangıç (5 dk)](HIZLI_BASLANGIC.md)** - GitHub'a yükle ve test et
- 📖 **[Detaylı Kılavuz](WINDOWS_KULLANICILARI_ICIN.md)** - Tüm adımlar ve sorun giderme

GitHub Actions ile Mac olmadan projenizi test edebilirsiniz! 🚀

---

## ✨ Özellikler

### 🎯 Görev Yönetimi
- **Günlük Görevler**: Her gün tekrarlanan rutin görevler
- **Haftalık Görevler**: Haftalık hedefler ve planlar
- **Ana Görevler**: Büyük, uzun vadeli hedefler
- **Özelleştirilebilir XP**: Her görev için XP değeri ayarlama
- **Öncelik Sistemi**: Düşük, Orta, Yüksek, Kritik

### 🎮 Oyunlaştırma
- **XP Sistemi**: Görev tamamlayarak XP kazan
- **Level Sistemi**: Üstel zorluk eğrisi ile level atla
- **Ejderha Evrimi**: 6 farklı ejderha aşaması
- **Günlük Streak**: Ardışık gün bonusu
- **Progress Bar**: Görsel ilerleme takibi

### 📱 Kullanıcı Deneyimi
- **SwiftUI**: Modern, akıcı UI
- **Dark Mode**: Otomatik tema desteği
- **Animasyonlar**: Smooth geçişler ve feedback
- **Bildirimler**: Günlük hatırlatmalar
- **Pull to Refresh**: Anında güncelleme

### 🛠️ Admin Panel
- Görev oluşturma/düzenleme/silme
- XP değerlerini özelleştirme
- Preset görevler ekleme
- İstatistik görüntüleme

## 🏗️ Mimari

Proje **Clean Architecture** prensiplerine göre tasarlanmıştır:

```
┌─────────────────────────────────────┐
│     Presentation Layer              │
│  (Views, ViewModels, Coordinators)  │
└───────────────┬─────────────────────┘
                │
┌───────────────▼─────────────────────┐
│       Domain Layer                  │
│  (Entities, Use Cases, Protocols)   │
└───────────────┬─────────────────────┘
                │
┌───────────────▼─────────────────────┐
│        Data Layer                   │
│  (Repositories, Core Data, Services)│
└─────────────────────────────────────┘
```

### Kullanılan Tasarım Desenleri

- **MVVM (Model-View-ViewModel)**: UI logic ayrımı
- **Clean Architecture**: Katmanlı mimari
- **Repository Pattern**: Veri erişim soyutlaması
- **Use Case Pattern**: İş mantığı izolasyonu
- **Dependency Injection**: Bağımlılık yönetimi
- **Coordinator Pattern**: Navigation kontrolü

## 📁 Proje Yapısı

```
DragonQuest/
├── App/                        # Uygulama giriş noktası
│   ├── DragonQuestApp.swift   # Main app
│   ├── AppDelegate.swift       # Notification handling
│   └── DIContainer.swift       # Dependency injection
│
├── Domain/                     # İş mantığı katmanı
│   ├── Entities/               # Domain modelleri
│   │   ├── Task.swift
│   │   ├── UserProgress.swift
│   │   ├── Dragon.swift
│   │   └── TaskType.swift
│   │
│   ├── UseCases/               # Atomik iş operasyonları
│   │   ├── Task/
│   │   ├── Progress/
│   │   └── Notification/
│   │
│   └── RepositoryProtocols/    # Repository arayüzleri
│
├── Data/                       # Veri katmanı
│   ├── Repositories/           # Repository implementasyonları
│   ├── CoreData/              # Persistence
│   │   ├── DragonQuest.xcdatamodeld
│   │   ├── CoreDataManager.swift
│   │   ├── Entities/
│   │   └── Mappers/
│   │
│   └── Services/              # External servisler
│       ├── NotificationService.swift
│       └── CalendarService.swift
│
├── Presentation/              # UI katmanı
│   ├── Scenes/
│   │   ├── Main/              # Ana ekran
│   │   ├── Admin/             # Admin paneli
│   │   └── Settings/          # Ayarlar
│   │
│   └── Coordinators/          # Navigation
│
└── Resources/                 # Kaynaklar
    ├── Animations/
    └── Images.xcassets/
```

Detaylı mimari dokümantasyonu için: [ARCHITECTURE.md](ARCHITECTURE.md)

## 🚀 Kurulum

### Gereksinimler

- Xcode 15.0+
- iOS 16.0+
- Swift 5.9+
- macOS 13.0+ (geliştirme için)

### Mac Kullanıcıları İçin

1. **Repository'yi klonlayın:**
   ```bash
   git clone https://github.com/yourusername/dragon-quest.git
   cd dragon-quest
   ```

2. **Xcode'da açın:**
   ```bash
   open DragonQuest.xcodeproj
   ```

3. **Bağımlılıkları yükleyin (Swift Package Manager):**
   - Xcode otomatik olarak paketleri çözümler
   - İsterseniz manuel: File > Packages > Resolve Package Versions

4. **Çalıştırın:**
   - Simulatör veya gerçek cihaz seçin
   - ⌘R ile çalıştırın

### 💻 Mac Olmadan Proje Kontrolü (Windows/Linux)

Mac bilgisayarınız yoksa, GitHub Actions ile projeyi otomatik olarak derleyebilir ve kontrol edebilirsiniz:

#### 1. GitHub'a Yükleme

```bash
# Git kurulu değilse: https://git-scm.com/download/win
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADINIZ/dragon-quest.git
git push -u origin main
```

#### 2. GitHub Actions Otomatik Çalışır

Projeyi GitHub'a yüklediğinizde:
- ✅ `.github/workflows/ios-build.yml` dosyası otomatik çalışır
- ✅ GitHub'ın sunucularında macOS üzerinde derlenir
- ✅ Tüm Swift dosyaları kontrol edilir
- ✅ Build başarılı/başarısız durumunu görebilirsiniz

#### 3. Build Durumunu Kontrol Etme

1. GitHub repository sayfanıza gidin
2. **"Actions"** sekmesine tıklayın
3. Son commit'in yanında ✅ veya ❌ işareti göreceksiniz
4. Tıklayarak detaylı log'ları inceleyebilirsiniz

#### 4. Badge Ekleme (Opsiyonel)

README'ye build durumu badge'i ekleyin:

```markdown
![Build Status](https://github.com/KULLANICI_ADINIZ/dragon-quest/workflows/iOS%20Build%20%26%20Test/badge.svg)
```

#### 5. Projeyi Online Görüntüleme

- GitHub üzerinden tüm kod dosyalarını görebilirsiniz
- Kod arama yapabilirsiniz (sağ üstte arama kutusu)
- Dosya yapısını inceleyebilirsiniz
- GitHub Actions build log'larında çıktıları görebilirsiniz

#### 6. Alternatif: Online IDE'ler (Sınırlı)

**GitHub Codespaces** (ücretsiz kota var):
```
- Repository'de "Code" → "Codespaces" → "Create codespace on main"
- Browser'da VSCode açılır
- Swift kodlarını düzenleyebilirsiniz (derleme sınırlı)
```

**GitHub.dev** (sadece kod görüntüleme):
```
- Repository'de '.' (nokta) tuşuna basın
- Tarayıcı tabanlı kod editörü açılır
```

### İlk Kurulum

Uygulama ilk açıldığında:
1. Core Data otomatik oluşturulur
2. Varsayılan UserProgress kaydı oluşturulur
3. Bildirim izni istenir (opsiyonel)

## 📱 Kullanım

### Ana Ekran

1. **Dragon View**: Ejderhanızın mevcut durumu
2. **Progress Card**: Level ve XP göstergesi
3. **Task Sections**: Günlük, Haftalık, Ana görevler

### Görev Ekleme (Admin Panel)

1. Sağ üst köşedeki ⚙️ ikonuna tıklayın
2. ➕ butonuna basın
3. Görev bilgilerini doldurun:
   - Başlık (zorunlu)
   - Açıklama (opsiyonel)
   - Tip: Günlük/Haftalık/Ana
   - XP değeri: 5-200
   - Öncelik: Düşük/Orta/Yüksek/Kritik
4. "Kaydet" butonuna basın

### Görev Tamamlama

1. Görev satırına tıklayın
2. Otomatik olarak XP kazanılır
3. Progress bar güncellenir
4. Level atlanırsa "Level Up!" ekranı gösterilir

### Bildirim Ayarlama

1. Ayarlar → Bildirimler
2. Günlük hatırlatma saati seçin
3. Uygulama her gün belirlenen saatte bildirim gönderir

## 🎮 XP ve Level Sistemi

### XP Kazanma

| Görev Tipi | Varsayılan XP |
|-----------|--------------|
| Günlük | 10 XP |
| Haftalık | 50 XP |
| Ana Görev | 100 XP |

### Level Formülü

```
next_level_xp = 100 * (1.5 ^ (level - 1))
```

### Ejderha Evrimleri

| Level | Aşama | Emoji |
|-------|-------|-------|
| 1-5 | Yumurta | 🥚 |
| 6-10 | Çatlayan Yumurta | 🔨 |
| 11-15 | Yavru Ejderha | 🐲 |
| 16-25 | Genç Ejderha | 🐉 |
| 26-40 | Yetişkin Ejderha | 🐲 |
| 41+ | Efsanevi Ejderha | 🐉 |

Detaylı XP sistemi dokümantasyonu: [XP_LEVEL_SYSTEM.md](XP_LEVEL_SYSTEM.md)

## 🧪 Test

### Unit Tests

```bash
# Tüm testleri çalıştır
⌘U

# Belirli test suite'i çalıştır
xcodebuild test -scheme DragonQuest -destination 'platform=iOS Simulator,name=iPhone 15'
```

### Test Kapsamı

- ✅ Domain Layer Use Cases
- ✅ Data Layer Repositories
- ✅ Presentation Layer ViewModels
- ⏳ UI Tests (gelecekte)

## 📦 Bağımlılıklar

Bu proje tamamen **ücretsiz** teknolojiler kullanır:

- **SwiftUI**: Apple'ın modern UI framework'ü
- **Core Data**: Offline veri persistence
- **Combine**: Reactive programming
- **UserNotifications**: Local bildirimler
- **EventKit**: Takvim entegrasyonu (opsiyonel)

### Gelecek Entegrasyonlar (Opsiyonel)

- **Lottie**: Gelişmiş animasyonlar
- **Rive**: İnteraktif animasyonlar
- **Firebase**: Backend & Analytics
- **CloudKit**: iCloud senkronizasyonu

## 🔧 Konfigürasyon

### Info.plist Ayarları

```xml
<!-- Bildirim izni -->
<key>NSUserNotificationUsageDescription</key>
<string>Günlük görev hatırlatmaları için bildirim izni gereklidir.</string>

<!-- Takvim izni (opsiyonel) -->
<key>NSCalendarsUsageDescription</key>
<string>Görevlerinizi takviminize ekleyebilmek için izin gereklidir.</string>
```

### Build Configuration

- **Debug**: Development ve testing
- **Release**: Production build

## 🎨 Özelleştirme

### Tema Renkleri

`DragonQuest/Presentation/Common/Theme/Colors.swift`:

```swift
struct AppColors {
    static let primary = Color.blue
    static let secondary = Color.purple
    static let accent = Color.orange
    static let success = Color.green
    static let danger = Color.red
}
```

### XP Değerleri

Admin panelinden veya kod içinde değiştirilebilir:

```swift
// TaskType.swift
var defaultXP: Int {
    switch self {
    case .daily: return 10      // Değiştir
    case .weekly: return 50     // Değiştir
    case .main: return 100      // Değiştir
    }
}
```

### Ejderha Animasyonları

`DragonQuest/Resources/Animations/` klasörüne Lottie/Rive dosyaları ekleyin:

- `dragon_egg.json`
- `dragon_hatchling.json`
- `dragon_adult.json`

## 🐛 Bilinen Sorunlar

- [ ] Lottie animasyonları henüz entegre edilmedi (placeholder emoji kullanılıyor)
- [ ] Offline mode'da bildirimler test edilmedi
- [ ] iPad layout optimizasyonu eksik

## 🗺️ Roadmap

### v1.0 (Mevcut)
- ✅ Temel görev yönetimi
- ✅ XP ve Level sistemi
- ✅ Ejderha evrimi
- ✅ Local bildirimler
- ✅ Admin panel

### v1.1 (Planlanan)
- [ ] Lottie/Rive animasyonları
- [ ] Widget desteği
- [ ] Apple Watch uygulaması
- [ ] Shortcuts entegrasyonu

### v2.0 (Gelecek)
- [ ] iCloud senkronizasyonu
- [ ] Sosyal özellikler (arkadaş ekleme)
- [ ] Leaderboard sistemi
- [ ] Achievement/Badge sistemi
- [ ] Özelleştirilebilir ejderhalar

### v3.0 (Uzun Vadeli)
- [ ] Multiplayer görevler
- [ ] Team/Family mode
- [ ] AI görev önerileri
- [ ] Gamification genişletmeleri

## 🤝 Katkıda Bulunma

Katkılarınızı bekliyoruz! Lütfen şu adımları izleyin:

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

### Kod Standartları

- Swift style guide: [raywenderlich.com/swift-style-guide](https://github.com/raywenderlich/swift-style-guide)
- SwiftLint kullanın
- Clean code prensiplerine uyun
- Unit test yazın

## 📄 Lisans

Bu proje MIT Lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## 👨‍💻 Yazar

**test123 Project**

- GitHub: https://github.com/Ulashh1/dragon-quest

## 🙏 Teşekkürler

- Apple SwiftUI dokümantasyonu
- Clean Architecture - Robert C. Martin
- iOS development community
- Tüm beta test kullanıcıları

## 📚 Ek Kaynaklar

- [Mimari Dokümantasyonu](ARCHITECTURE.md)
- [XP Sistemi Detayları](XP_LEVEL_SYSTEM.md)
- [API Dokümantasyonu](docs/API.md) (gelecekte)
- [Tasarım Sistemi](docs/DESIGN.md) (gelecekte)

---

**test123 - iOS Projesi**

Eğer bu projeyi beğendiyseniz ⭐ vermeyi unutmayın!


