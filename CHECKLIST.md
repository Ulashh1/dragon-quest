# ✅ Dragon Quest - Proje Kontrol Listesi

Bu dosya, projenin Xcode'da çalıştırılması için gerekli adımları içerir.

## 📋 Xcode Projesi Oluşturma

### 1️⃣ Yeni Xcode Projesi Oluştur

```
[ ] Xcode'u aç
[ ] File → New → Project
[ ] iOS → App seçeneğini seç
[ ] Ayarlar:
    - Product Name: DragonQuest
    - Team: (kendi team'iniz)
    - Organization Identifier: com.yourcompany
    - Interface: SwiftUI
    - Language: Swift
    - Storage: Core Data (✅ işaretle)
    - Include Tests: ✓
[ ] Create butonuna tıkla
[ ] Kayıt konumu seç
```

### 2️⃣ Mevcut Dosyaları İçe Aktar

```
[ ] Tüm Swift dosyalarını sil (Xcode'un oluşturduğu)
[ ] Mevcut DragonQuest klasörünü proje klasörüne kopyala
[ ] Xcode'da: sağ tık → Add Files to "DragonQuest"
[ ] DragonQuest klasörünü seç
[ ] Ayarlar:
    - ✓ Copy items if needed
    - ✓ Create groups
    - Add to targets: DragonQuest
[ ] Add butonuna tıkla
```

### 3️⃣ Core Data Model'i Ayarla

```
[ ] .xcdatamodeld dosyasını kontrol et
[ ] Project Settings → DragonQuest target
[ ] Build Settings → PRODUCT_NAME = "DragonQuest"
[ ] Signing & Capabilities → Team seç
```

### 4️⃣ Info.plist Düzenle

```
[ ] Info.plist dosyasını aç
[ ] Yeni key ekle: NSUserNotificationUsageDescription
    Value: "Günlük görev hatırlatmaları için bildirim izni gereklidir."
[ ] Yeni key ekle: NSCalendarsUsageDescription
    Value: "Görevlerinizi takviminize ekleyebilmek için izin gereklidir."
```

### 5️⃣ Build Settings

```
[ ] iOS Deployment Target: 16.0
[ ] Swift Language Version: 5 (otomatik)
[ ] Build Active Architecture Only (Debug): Yes
```

## 🔧 Derleme ve Çalıştırma

### 6️⃣ İlk Build

```
[ ] ⌘B (Build) tuşlarına bas
[ ] Build hatalarını kontrol et
[ ] Varsa import hatalarını düzelt
[ ] Clean Build Folder: ⌘⇧K
[ ] Tekrar build et
```

### 7️⃣ Olası Hatalar ve Çözümleri

**Hata: "Cannot find 'X' in scope"**
```
[ ] File → Packages → Reset Package Caches
[ ] Clean Build Folder (⌘⇧K)
[ ] Derived Data sil:
    ~/Library/Developer/Xcode/DerivedData
```

**Hata: Core Data model hatası**
```
[ ] .xcdatamodeld dosyasını kontrol et
[ ] Entity adlarını doğrula: TaskEntity, UserProgressEntity
[ ] Model version kontrolü
```

**Hata: Duplicate symbols**
```
[ ] Aynı isimde dosya var mı kontrol et
[ ] Build Phases → Compile Sources'ta tekrar var mı kontrol et
```

### 8️⃣ İlk Çalıştırma

```
[ ] Simulatör seç (iPhone 15 önerilir)
[ ] ⌘R (Run) tuşlarına bas
[ ] Uygulamanın açıldığını kontrol et
[ ] Bildirim izni dialogu gelecek → Allow seç
```

## 🧪 Test Etme

### 9️⃣ Temel İşlevleri Test Et

```
[ ] Ana ekran açıldı mı?
[ ] Ejderha görseli görünüyor mu?
[ ] Progress bar var mı?
[ ] Admin panel açılıyor mu? (⚙️ ikonu)
[ ] Yeni görev eklenebiliyor mu?
[ ] Görev tamamlanabiliyor mu?
[ ] XP artıyor mu?
[ ] Progress bar dolduyor mu?
```

### 🔟 Örnek Görev Ekleme

```
[ ] ⚙️ ikonuna tıkla
[ ] "Örnek Görevler Ekle" butonuna bas
[ ] Ana ekrana dön
[ ] Görevlerin listelendiğini kontrol et
[ ] Bir göreve tıkla
[ ] ✓ işareti belirdi mi?
[ ] XP arttı mı?
[ ] Progress bar güncellendi mi?
```

## 🎨 Animasyon Ekleme (Opsiyonel)

### 1️⃣1️⃣ Lottie/Rive Entegrasyonu

```
[ ] File → Add Packages
[ ] URL: https://github.com/airbnb/lottie-ios
[ ] Dependency Rule: Up to Next Major Version
[ ] Add Package
[ ] DragonQuest target seç
```

### 1️⃣2️⃣ Animasyon Dosyaları

```
[ ] Resources/Animations/ klasörü oluştur
[ ] Lottie JSON dosyalarını ekle:
    - dragon_egg.json
    - dragon_hatchling.json
    - dragon_adult.json
[ ] Xcode'da Add Files to "DragonQuest"
```

### 1️⃣3️⃣ DragonView Güncelle

```swift
// DragonView.swift içinde
import Lottie

var dragonRepresentation: some View {
    LottieView(animation: .named(stage.animationName))
        .playing(loopMode: .loop)
        .frame(width: 120, height: 120)
}
```

## 📱 Cihazda Test (Opsiyonel)

### 1️⃣4️⃣ Gerçek iPhone'da Çalıştırma

```
[ ] iPhone'u Mac'e bağla
[ ] Xcode → Window → Devices and Simulators
[ ] Cihazı güvenilir yap
[ ] Target device olarak iPhone'u seç
[ ] Signing & Capabilities → Team seç
[ ] Run (⌘R)
```

## 🚀 App Store Hazırlığı (Gelecekte)

### 1️⃣5️⃣ App Icons

```
[ ] Assets.xcassets → AppIcon
[ ] Tüm boyutlarda icon ekle
[ ] 1024x1024 App Store icon
```

### 1️⃣6️⃣ Launch Screen

```
[ ] LaunchScreen.storyboard düzenle
[ ] veya SwiftUI Launch Screen oluştur
```

### 1️⃣7️⃣ Build Ayarları

```
[ ] Deployment Target: iOS 16.0
[ ] Supported Devices: iPhone & iPad
[ ] Orientation: Portrait
[ ] Version: 1.0.0
[ ] Build Number: 1
```

### 1️⃣8️⃣ App Store Connect

```
[ ] developer.apple.com hesabı oluştur
[ ] App Store Connect'te uygulama oluştur
[ ] Screenshots hazırla
[ ] App description yaz
[ ] Privacy Policy ekle
```

## ✅ Tamamlama Kontrol Listesi

### Temel Özellikler
- [ ] Görev ekleme çalışıyor
- [ ] Görev tamamlama çalışıyor
- [ ] XP sistemi çalışıyor
- [ ] Level atlama çalışıyor
- [ ] Ejderha evrimi çalışıyor
- [ ] Progress bar çalışıyor
- [ ] Admin panel çalışıyor

### UI/UX
- [ ] Dark mode destekleniyor
- [ ] Animasyonlar düzgün
- [ ] Responsive design
- [ ] Loading states
- [ ] Error handling
- [ ] User feedback (toast/alert)

### Bildirimler
- [ ] Bildirim izni alınıyor
- [ ] Günlük hatırlatma çalışıyor
- [ ] Görev hatırlatması çalışıyor

### Veri Yönetimi
- [ ] Core Data çalışıyor
- [ ] Veri kalıcılığı var
- [ ] Uygulama yeniden açıldığında veri koruyor

### Kod Kalitesi
- [ ] Clean Architecture uygulanmış
- [ ] MVVM pattern kullanılmış
- [ ] Dependency Injection var
- [ ] Kod okunabilir ve dokümante

### Dokümantasyon
- [ ] README.md güncel
- [ ] ARCHITECTURE.md mevcut
- [ ] Kod yorumları var
- [ ] Usage examples var

## 🐛 Bilinen Sorunlar

### Çözülmesi Gerekenler
- [ ] Lottie animasyonları henüz eklenmedi
- [ ] Unit test'ler yazılmadı
- [ ] iPad layout optimizasyonu yapılmadı
- [ ] Widget desteği yok
- [ ] iCloud sync yok

### Nice-to-Have
- [ ] Haptic feedback
- [ ] Sound effects
- [ ] Achievement sistemi
- [ ] Social features
- [ ] Analytics

## 📊 Performans Kontrolleri

```
[ ] Instruments ile memory leak kontrolü
[ ] Launch time < 2 saniye
[ ] UI responsiveness (60 FPS)
[ ] Core Data query performansı
[ ] Battery usage makul
```

## 🎉 Projeyi Tamamla

```
[ ] Tüm özellikler çalışıyor
[ ] Test senaryoları geçiyor
[ ] Build başarılı
[ ] Dokümantasyon eksiksiz
[ ] Git commit'lendi
[ ] README güncel
```

## 📝 Notlar

- Build sürecinde sorun çıkarsa GETTING_STARTED.md'ye bakın
- Mimari sorular için ARCHITECTURE.md'yi inceleyin
- Kullanım örnekleri için USAGE_EXAMPLES.md'ye göz atın

---

**Başarılar! 🐉✨**

Tüm kontrol listesi tamamlandığında Dragon Quest uygulamanız hazır!


