# test123

iOS test projesi. SwiftUI + Clean Architecture.

## Hızlı Bakış

```
test123/
├── App/           # Giriş noktası
├── Domain/        # İş mantığı
├── Data/          # Veritabanı, API
└── Presentation/  # UI
```

**Kullanılan**: SwiftUI, Core Data, MVVM

## Mac Olmadan Nasıl Test Edilir?

GitHub Actions kullanıyorum. Her push'ta otomatik derleniyor.

- Windows için: [WINDOWS_KULLANICILARI_ICIN.md](WINDOWS_KULLANICILARI_ICIN.md)
- Mac için: [MAC_KULLANIM_KILAVUZU.md](MAC_KULLANIM_KILAVUZU.md)

## Hızlı Başlangıç

```bash
git clone https://github.com/Ulashh1/dragon-quest.git
cd dragon-quest
open test123.xcodeproj
```

Xcode'da ⌘R ile çalıştır.

## Mimari

**Clean Architecture** kullanıyorum:
- Domain: İş mantığı (entities, use cases)
- Data: Veri yönetimi (Core Data, repositories)
- Presentation: UI (SwiftUI views, view models)

**Neden?**
- Test edilebilir
- Değişime açık
- Bağımlılıklar tek yönlü

## Özellikler

- ✅ SwiftUI modern UI
- ✅ Core Data persistence
- ✅ MVVM pattern
- ✅ Dependency injection
- ✅ GitHub Actions CI/CD

## Gereksinimler

- iOS 16.0+
- Xcode 15.0+
- Swift 5.9+

## Lisans

MIT

---

**Not**: Eğitim/test amaçlı proje.
