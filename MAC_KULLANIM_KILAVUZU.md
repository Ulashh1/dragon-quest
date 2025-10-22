# 🍎 Mac'te Dragon Quest Projesini Açma Kılavuzu

## ✅ Xcode Project Hazır!

Artık projenizde tam çalışır bir Xcode project dosyası var! Mac'te direkt açabilirsiniz.

---

## 🚀 Mac'te Nasıl Açılır?

### Adım 1: Projeyi Clone Edin

Terminal'i açın ve şu komutu çalıştırın:

```bash
git clone https://github.com/Ulashh1/dragon-quest.git
cd dragon-quest
```

### Adım 2: Xcode Project'i Açın

**Yöntem 1: Çift Tıklama**
```
Finder'da dragon-quest klasörüne gidin
DragonQuest.xcodeproj dosyasına çift tıklayın
```

**Yöntem 2: Terminal'den**
```bash
open DragonQuest.xcodeproj
```

**Yöntem 3: Xcode'dan**
```
Xcode'u açın
File → Open
DragonQuest.xcodeproj dosyasını seçin
```

### Adım 3: Simülatör Seçin

Xcode üst barında:
1. **Scheme**: DragonQuest seçili olmalı
2. **Device**: iPhone 15 (veya istediğiniz simülatör) seçin

### Adım 4: Çalıştırın!

```
⌘R (Command + R)
```

veya

```
Play butonu ▶️ tıklayın (üst sol köşe)
```

---

## 📱 Ne Göreceksiniz?

### 1. Ana Ekran (MainView)
- 🐉 Ejderha görseli
- 📊 XP ve Level progress bar
- ✅ Görev listeleri (Günlük, Haftalık, Ana)

### 2. Admin Panel
- Sağ üst köşedeki ⚙️ ikonuna tıklayın
- ➕ Yeni görev ekleyin
- ✏️ Görevleri düzenleyin
- 🗑️ Görevleri silin

### 3. Özellikler
- ✅ Görev tamamlama (tap ile)
- 🎮 XP kazanma animasyonu
- 📈 Level atlama bildirimi
- 🐉 Ejderha evrimi (level bazlı)
- 💾 Core Data persistence
- 🔔 Bildirim desteği

---

## 🎨 SwiftUI Previews

Her View dosyasını açıp sağ tarafta **Canvas** aktif edebilirsiniz:

1. Bir View dosyasını açın (örn: `MainView.swift`)
2. Sağ üst köşede **Editor Options** → **Canvas**
3. **Resume** butonuna basın
4. Canlı önizleme göreceksiniz!

**Preview Yapabilecekleriniz**:
```swift
// MainView.swift, AdminView.swift, DragonView.swift, vb.
// Her dosyanın en altında Preview kodu var
```

---

## 🔧 Build Settings

Proje yapılandırması:
- **iOS Deployment Target**: 16.0+
- **Swift Version**: 5.0
- **Bundle Identifier**: com.dragonquest.app
- **Minimum Device**: iPhone & iPad

---

## 🐛 Sorun Giderme

### "No such module 'DragonQuest'" hatası
```
Product → Clean Build Folder (⌘⇧K)
Product → Build (⌘B)
```

### Simülatör açılmıyor
```
Xcode → Preferences → Locations
Command Line Tools seçili mi kontrol edin
```

### Core Data hatası
```
İlk çalıştırmada otomatik oluşturulur
Sorun yaşarsanız: iOS Simulator → Reset Content and Settings
```

### "Signing requires a development team"
```
Target → Signing & Capabilities
Team: Otomatik seçilmeli
Veya "Automatically manage signing" işaretleyin
```

---

## 📂 Proje Yapısı (Xcode'da)

```
DragonQuest/
├── App/
│   ├── DragonQuestApp.swift       # Ana entry point
│   ├── AppDelegate.swift          # Notification handling
│   └── DIContainer.swift          # Dependency injection
│
├── Data/
│   ├── CoreData/
│   │   ├── CoreDataManager.swift
│   │   ├── DragonQuest.xcdatamodeld
│   │   ├── Entities/
│   │   ├── Mappers/
│   │   └── Repositories/
│   └── Services/
│
├── Domain/
│   ├── Entities/
│   ├── RepositoryProtocols/
│   └── UseCases/
│
├── Presentation/
│   ├── Common/
│   ├── Coordinators/
│   └── Scenes/
│       ├── Admin/
│       └── Main/
│
└── Resources/
    ├── Assets.xcassets
    └── Info.plist
```

---

## 🎯 İlk Çalıştırma Checklist

Projeyi ilk kez açtığınızda:

- [ ] Xcode 15.0+ kurulu mu?
- [ ] Command Line Tools yüklü mü?
- [ ] Simülatör seçildi mi?
- [ ] Scheme "DragonQuest" seçili mi?
- [ ] Build başarılı mı? (⌘B)
- [ ] Run çalışıyor mu? (⌘R)

---

## 🎮 Test Senaryoları

### Senaryo 1: Görev Ekleme ve Tamamlama
1. ⚙️ Admin panele gir
2. ➕ Yeni görev ekle (Günlük, 10 XP)
3. Ana ekrana dön
4. Görev satırına tap yap
5. ✅ XP kazandığını gör

### Senaryo 2: Level Atlama
1. Admin'den yüksek XP'li görev ekle (100 XP)
2. Ana ekranda tamamla
3. 🎉 "Level Up!" mesajı göreceksin
4. Ejderha evrimini gör

### Senaryo 3: Bildirim
1. Admin → Bildirim ayarları
2. Saat seç
3. Simülatör saatini değiştir
4. Bildirim geldiğini gör

---

## 📸 Ekran Görüntüleri Alma

```
⌘⇧4 → Mouse ile seç → Ekran görüntüsü
```

veya

```
Simülatör → File → Save Screen (⌘S)
```

---

## 🚀 TestFlight'a Yükleme (İleriye Dönük)

1. Apple Developer hesabı aç (yıllık $99)
2. App Store Connect'te app oluştur
3. Xcode'da Archive (Product → Archive)
4. Upload to App Store
5. TestFlight beta testi başlat

---

## 💡 İpuçları

### Hızlı Navigasyon
- **⌘⇧O**: Dosya ara (Open Quickly)
- **⌘⇧F**: Tüm projede ara (Find in Project)
- **⌘⌥[**: Önceki dosya
- **⌘⌥]**: Sonraki dosya

### Debug
- **Breakpoint**: Satır numarasına tıkla
- **Console**: ⌘⇧Y
- **Print**: `print("debug")` kullan

### Preview Tricks
- **⌘⌥P**: Preview'u refresh et
- **Pin Preview**: Sağ tıkla → Pin Preview
- **Multiple Previews**: Farklı cihazlar test et

---

## 📚 Öğrenmek İçin Kaynaklar

- **SwiftUI**: https://developer.apple.com/documentation/swiftui
- **Core Data**: https://developer.apple.com/documentation/coredata
- **Xcode**: https://developer.apple.com/xcode/resources/

---

## ❓ Sıkça Sorulan Sorular

**S: Gerçek iPhone'da çalıştırabilir miyim?**
A: Evet! iPhone'u USB ile bağla, device olarak seç, run yap.

**S: Xcode nerede?**
A: App Store'dan ücretsiz indir (büyük dosya, ~12GB)

**S: Simülatör yavaş**
A: M1/M2 Mac'te çok hızlı, Intel Mac'te biraz yavaş olabilir

**S: Core Data sıfırlama?**
A: iOS Simulator → Device → Erase All Content and Settings

---

## 🎉 Başarılar!

Artık Dragon Quest uygulamanızı gerçek iOS simülatörde test edebilirsiniz!

**Keyifli kodlamalar! 🐉✨**

---

## 📞 Destek

Sorun yaşarsanız:
1. GitHub Issues: https://github.com/Ulashh1/dragon-quest/issues
2. README.md dosyasını okuyun
3. ARCHITECTURE.md'de detaylı mimari var

---

**Not**: Bu proje eğitim ve portfolio amaçlı hazırlanmıştır.

