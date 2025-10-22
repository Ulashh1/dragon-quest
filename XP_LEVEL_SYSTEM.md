# XP ve Level Sistemi Dokümantasyonu

## 🎮 Genel Bakış

Dragon Quest uygulaması, kullanıcıları motive etmek için oyunlaştırılmış bir XP (Experience Points) ve Level sistemi kullanır. Bu sistem, görev tamamlama ile ilerleme arasında doğrudan bir bağlantı kurar.

## 📊 XP Sistemi

### XP Kazanma

Kullanıcılar görev tamamladıklarında XP kazanırlar. Her görev tipinin farklı bir varsayılan XP değeri vardır:

| Görev Tipi | Varsayılan XP | Açıklama |
|-----------|--------------|----------|
| Günlük | 10 XP | Her gün tekrar eden basit görevler |
| Haftalık | 50 XP | Haftalık hedefler |
| Ana Görev | 100 XP | Büyük, önemli görevler |

**Not:** Admin panelinden her görev için XP değeri özelleştirilebilir (5-200 XP arası).

### XP Hesaplama

```swift
// UserProgress.swift içinde
mutating func addXP(_ amount: Int) {
    totalXP += amount           // Toplam XP artar
    currentLevelXP += amount    // Mevcut level için XP artar
    
    // Level atlama kontrolü
    while currentLevelXP >= nextLevelXP {
        levelUp()
    }
}
```

## 🔼 Level Sistemi

### Level Atlama Formülü

Her level için gereken XP üstel olarak artar:

```swift
nextLevelXP = 100 * (1.5 ^ (currentLevel - 1))
```

### Level Tablosu

| Level | Gereken XP | Kümülatif Toplam XP |
|-------|-----------|---------------------|
| 1 | 0 | 0 |
| 2 | 100 | 100 |
| 3 | 150 | 250 |
| 4 | 225 | 475 |
| 5 | 337 | 812 |
| 10 | ~3,800 | ~13,000 |
| 20 | ~437,000 | ~1,455,000 |

### Level Atlama Mekanizması

```swift
private mutating func levelUp() {
    currentLevelXP -= nextLevelXP  // Fazla XP bir sonraki level'e taşınır
    currentLevel += 1               // Level artar
    nextLevelXP = calculateNextLevelXP()
    
    // Ejderha evrimi güncellenir
    updateDragonStage()
}
```

## 🐉 Ejderha Evrim Sistemi

Level ilerledikçe ejderha evrileşir:

| Aşama | Level Aralığı | Görsel | Açıklama |
|-------|---------------|--------|----------|
| 🥚 Yumurta | 1-5 | Egg | Gizemli bir enerji içeriyor |
| 🔨 Çatlayan Yumurta | 6-10 | Cracking | Yumurta çatlamaya başladı |
| 🐲 Yavru Ejderha | 11-15 | Hatchling | Küçük ejderha dünyaya geldi |
| 🐉 Genç Ejderha | 16-25 | Juvenile | Kanatlarını açabiliyor |
| 🐲 Yetişkin Ejderha | 26-40 | Adult | Tam gücüne ulaştı |
| 🐉 Efsanevi Ejderha | 41+ | Elder | Zamanın ötesinde güç |

### Evrim Hesaplama

```swift
private mutating func updateDragonStage() {
    switch currentLevel {
    case 1...5:
        dragonStage = .egg
    case 6...10:
        dragonStage = .cracking
    case 11...15:
        dragonStage = .hatchling
    case 16...25:
        dragonStage = .juvenile
    case 26...40:
        dragonStage = .adult
    default:
        dragonStage = .elder
    }
}
```

## 📈 İlerleme Gösterimi

### Progress Bar

Kullanıcıya mevcut level içindeki ilerlemesini gösterir:

```swift
var progressPercentage: Double {
    guard nextLevelXP > 0 else { return 0.0 }
    return Double(currentLevelXP) / Double(nextLevelXP)
}
```

Örnek:
- Current Level XP: 75
- Next Level XP: 100
- Progress: 75%

### Visual Feedback

1. **Progress Bar**: Yüzdelik dilim olarak gösterir
2. **XP Counter**: "75 / 100 XP" formatında
3. **Dragon Animation**: Level'e göre değişen görsel
4. **Level Up Screen**: Level atlandığında animasyonlu ekran

## 🎯 Motivasyon Mekanikleri

### 1. Anlık Geri Bildirim
- Görev tamamlandığında hemen XP kazanılır
- Progress bar anında güncellenir
- Ses/haptic feedback (opsiyonel)

### 2. Görsel İlerleme
- Ejderha büyüdükçe görsel değişir
- Progress bar dolma animasyonu
- Parlama/glow efektleri

### 3. Milestone Celebrations
- Level atlama animasyonu
- "Level Up!" ekranı
- Yeni ejderha aşaması bildirimi

### 4. Günlük Streak
```swift
mutating func updateStreak() {
    if calendar.isDateInYesterday(lastActiveDate) {
        dailyStreak += 1  // Streak devam ediyor
    } else if !calendar.isDateInToday(lastActiveDate) {
        dailyStreak = 1   // Streak kırıldı, yeniden başla
    }
    lastActiveDate = Date()
}
```

## 🔧 Teknik Detaylar

### Core Data Schema

```swift
UserProgressEntity:
- totalXP: Int32           // Toplam kazanılan XP
- currentLevel: Int32      // Mevcut level
- currentLevelXP: Int32    // Bu level için XP
- nextLevelXP: Int32       // Sonraki level için gereken XP
- totalTasksCompleted: Int32
- dailyStreak: Int32
- dragonStage: Int16       // Ejderha aşaması (enum raw value)
```

### Use Case Flow

```
CompleteTaskUseCase
    ↓
1. Task'ı tamamla (Repository)
    ↓
2. AddXPUseCase çağır
    ↓
3. UserProgress güncelle
    ↓
4. Level atlama kontrolü
    ↓
5. Dragon stage güncelle
    ↓
6. ViewModel'e bildir
    ↓
7. UI güncelle
```

## 📱 Kullanıcı Deneyimi

### Görev Tamamlama Akışı

1. Kullanıcı göreve tıklar
2. Checkmark işareti belirir
3. XP kazanma animasyonu (+10 XP)
4. Progress bar güncellenir
5. Ejderha animasyonu (opsiyonel pulse)
6. Level atlanırsa → Level Up ekranı

### Level Atlama Deneyimi

1. Progress bar %100'e ulaşır
2. Parlama efekti
3. Level sayısı güncellenir
4. "Level Up!" modal ekranı
5. Yeni level gösterilir
6. Ejderha evrildiyse → Yeni form gösterilir

## 🎨 Gelecek Geliştirmeler

### Planlanan Özellikler

1. **Achievements (Başarılar)**
   - İlk görev tamamlama
   - 100 görev tamamlama
   - 30 günlük streak
   - Tüm görev tiplerini tamamlama

2. **Bonus XP**
   - Streak bonus (her 7 gün: +10% XP)
   - Perfect day bonus (tüm günlük görevler)
   - Combo bonus (arka arkaya görev)

3. **Özelleştirilebilir Ejderhalar**
   - Farklı renkler
   - Farklı türler
   - Özel animasyonlar

4. **Leaderboard**
   - Haftalık XP lideri
   - Aylık level lideri
   - Global streak rekoru

5. **Power-ups**
   - 2x XP boost (1 saat)
   - Auto-complete daily tasks
   - Streak freeze (1 gün)

## 🧮 Örnek Senaryolar

### Senaryo 1: Yeni Kullanıcı

```
Başlangıç: Level 1, 0 XP
↓
Günlük görev tamamla (+10 XP)
→ Level 1, 10/100 XP (10%)
↓
Haftalık görev tamamla (+50 XP)
→ Level 1, 60/100 XP (60%)
↓
4 günlük görev daha (+40 XP)
→ Level 2, 0/150 XP
→ 🎉 Level Up! Yumurta parlıyor!
```

### Senaryo 2: Aktif Kullanıcı

```
Level 10, 500/1000 XP
↓
Ana görev tamamla (+100 XP)
→ Level 10, 600/1000 XP
↓
10 günlük görev (+100 XP)
→ Level 10, 700/1000 XP
↓
5 haftalık görev (+250 XP)
→ Level 10, 950/1000 XP
↓
1 günlük görev (+10 XP)
→ Level 11, 0/1500 XP
→ 🐲 Yavru ejderhaya evrildi!
```

## 💡 Best Practices

### 1. Dengeli XP Dağılımı
- Günlük: Küçük, kolay görevler
- Haftalık: Orta zorluk, daha fazla XP
- Ana: Büyük hedefler, maksimum XP

### 2. Kullanıcı Beklentileri
- Level atlama görünür olmalı
- İlerleme her zaman hissedilmeli
- Çok hızlı/yavaş level atlanmamalı

### 3. Görsel Tutarlılık
- XP renkleri: Altın/Sarı
- Level renkleri: Mavi/Mor
- Streak renkleri: Turuncu/Kırmızı

### 4. Performans
- XP hesaplamaları senkron
- Animasyonlar 60 FPS
- Core Data güncellemeleri background thread


