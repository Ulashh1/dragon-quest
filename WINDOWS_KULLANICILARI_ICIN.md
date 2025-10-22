# 💻 Windows Kullanıcıları İçin Dragon Quest Kullanım Kılavuzu

Bu kılavuz, Mac bilgisayarı olmayan kullanıcıların Dragon Quest projesini nasıl test edip görüntüleyebileceğini anlatır.

## 🎯 Hedef

Mac olmadan:
- ✅ Projeyi GitHub'da görüntülemek
- ✅ Kodun derlenip derlenmediğini test etmek
- ✅ Syntax hatalarını kontrol etmek
- ✅ Proje yapısını incelemek
- ✅ Değişiklik yapmak ve test etmek

## 📋 Gereksinimler

1. **Git for Windows** (ücretsiz)
   - İndirme: https://git-scm.com/download/win
   - Kurulum: Varsayılan ayarlarla ilerleyin

2. **GitHub Hesabı** (ücretsiz)
   - Kayıt: https://github.com/signup
   - Email doğrulaması yapın

3. **İnternet Bağlantısı**
   - GitHub Actions için gerekli

## 🚀 Adım Adım Kurulum

### Adım 1: GitHub Repository Oluşturma

1. GitHub'da oturum açın
2. Sağ üstte **"+"** → **"New repository"** tıklayın
3. Ayarlar:
   - **Repository name**: `dragon-quest` (veya istediğiniz isim)
   - **Visibility**: Public (ücretsiz GitHub Actions için)
   - **Initialize**: Hiçbir şey seçmeyin (zaten kodunuz var)
4. **"Create repository"** tıklayın
5. Açılan sayfadaki komutları not alın

### Adım 2: Projeyi GitHub'a Yükleme

1. **Windows Terminal** veya **PowerShell** açın

2. Proje klasörüne gidin:
   ```powershell
   cd C:\Users\Ulaş\Test
   ```

3. Git yapılandırması (ilk kez yapıyorsanız):
   ```bash
   git config --global user.name "Adınız"
   git config --global user.email "email@ornek.com"
   ```

4. Git repository başlatın:
   ```bash
   git init
   ```

5. Tüm dosyaları ekleyin:
   ```bash
   git add .
   ```

6. İlk commit'i yapın:
   ```bash
   git commit -m "Initial commit - Dragon Quest iOS App"
   ```

7. Main branch oluşturun:
   ```bash
   git branch -M main
   ```

8. Remote repository ekleyin (KULLANICI_ADINIZ'ı değiştirin):
   ```bash
   git remote add origin https://github.com/KULLANICI_ADINIZ/dragon-quest.git
   ```

9. GitHub'a yükleyin:
   ```bash
   git push -u origin main
   ```

10. GitHub kullanıcı adı ve şifrenizi girin
    - **Not**: Şifre yerine **Personal Access Token** kullanmanız gerekebilir
    - Token oluşturma: Settings → Developer settings → Personal access tokens → Generate new token

### Adım 3: GitHub Actions'ı Kontrol Etme

1. GitHub repository sayfanıza gidin:
   ```
   https://github.com/KULLANICI_ADINIZ/dragon-quest
   ```

2. Üstteki **"Actions"** sekmesine tıklayın

3. Şunları göreceksiniz:
   - 🟡 **Sarı nokta**: Build çalışıyor (bekleyin)
   - ✅ **Yeşil tik**: Build başarılı! 🎉
   - ❌ **Kırmızı X**: Build hatası (detaylara bakın)

4. Workflow'a tıklayarak detayları görün:
   - Hangi dosyalar kontrol edildi
   - Kaç tane Swift dosyası var
   - Build log'ları
   - Hatalar (varsa)

### Adım 4: Build Sonuçlarını Anlama

#### ✅ Başarılı Build

```
✓ Checkout
✓ Select Xcode
✓ Xcode version
✓ Build with Swift Package Manager
✓ List all Swift files
  Found 28 Swift files
✓ Build Status
```

**Anlamı**: Projeniz derleniyor, syntax hataları yok! 🎉

#### ❌ Başarısız Build

```
✗ Build with Swift Package Manager
  Error: Cannot find type 'SomeClass' in scope
```

**Anlamı**: Kod hatası var, düzeltilmesi gerekiyor.

### Adım 5: Kod Değişiklikleri Yapma ve Test Etme

1. **Windows'ta kod editörü açın** (VS Code, Notepad++, vb.)

2. **Dosya düzenleyin** (örnek: `DragonQuest/Domain/Entities/Task.swift`)

3. **Değişiklikleri kaydedin**

4. **Git ile yükleyin**:
   ```bash
   git add .
   git commit -m "Task entity güncellendi"
   git push
   ```

5. **GitHub Actions tekrar çalışacak** - Actions sekmesinden takip edin

## 🔍 Projeyi Online İnceleme Yöntemleri

### Yöntem 1: GitHub Web Arayüzü (En Kolay)

- GitHub repository sayfasında dosyalara tıklayın
- Kod vurgulama var
- Arama yapabilirsiniz (sağ üstte arama kutusu)
- Dosya ağacını görebilirsiniz

### Yöntem 2: GitHub.dev (Tarayıcı IDE)

1. Repository sayfasında klavyede **"."** (nokta) tuşuna basın
2. VSCode benzeri editör açılır
3. Tam özellikli kod düzenleme
4. Terminal yok, sadece düzenleme

### Yöntem 3: GitHub Codespaces (En Güçlü - Aylık Ücretsiz Kota)

1. Repository → **"Code"** → **"Codespaces"**
2. **"Create codespace on main"** tıklayın
3. Bulut tabanlı tam VSCode ortamı
4. Terminal var, komut çalıştırabilirsiniz
5. **Ücretsiz**: Ayda 60 saat

**Not**: Codespaces'te iOS uygulaması çalıştıramazsınız, ama kod düzenleyip GitHub Actions ile test edebilirsiniz.

## 📊 GitHub Actions Workflow Detayları

`.github/workflows/ios-build.yml` dosyası ne yapıyor?

```yaml
1. macOS sanal makine başlatır (GitHub'ın sunucusu)
2. Xcode'u seçer
3. Projeyi indirir
4. Swift Package Manager ile derler
5. Tüm Swift dosyalarını sayar
6. Sonuçları gösterir
```

**Maliyet**: Tamamen ücretsiz (public repo için)

## 🎨 Projeyi Görselleştirme

### README Badge Ekleme

README.md dosyasının en üstüne ekleyin:

```markdown
![Build Status](https://github.com/KULLANICI_ADINIZ/dragon-quest/workflows/iOS%20Build%20%26%20Test/badge.svg)
```

Sonuç:
- ✅ Yeşil badge: Build başarılı
- ❌ Kırmızı badge: Build başarısız

### GitHub Pages (Opsiyonel)

Dokümantasyonu web sayfası olarak yayınlayabilirsiniz:

1. Settings → Pages
2. Source: **"main branch"** seçin
3. Dokümantasyon `https://KULLANICI_ADINIZ.github.io/dragon-quest` adresinde olur

## 🐛 Sorun Giderme

### Problem: `git push` şifre istemiyor veya hata veriyor

**Çözüm**: Personal Access Token kullanın
1. GitHub → Settings → Developer settings → Personal access tokens
2. "Generate new token" (classic)
3. Scope: `repo` seçin
4. Token'ı kopyalayın (bir daha gösterilmez!)
5. Git push yaparken şifre yerine token'ı kullanın

### Problem: GitHub Actions çalışmıyor

**Kontrol**:
1. Repository Public mi? (Private repoda dakika kotası var)
2. `.github/workflows/ios-build.yml` dosyası var mı?
3. Actions sekmesi aktif mi? (Settings → Actions → Allow all actions)

### Problem: Build başarısız

**Yapılacaklar**:
1. Actions sekmesinde hatalı workflow'a tıklayın
2. "Build with Swift Package Manager" adımını açın
3. Hata mesajını okuyun
4. Hatayı düzeltin, commit edin, push edin

## 📚 Faydalı Linkler

- **Git for Windows**: https://git-scm.com/download/win
- **GitHub Docs**: https://docs.github.com
- **GitHub Actions**: https://docs.github.com/actions
- **Swift.org**: https://swift.org/documentation/
- **GitHub Codespaces**: https://github.com/features/codespaces

## 💡 İpuçları

1. **Her değişiklikten sonra test edin**
   - Küçük commit'ler yapın
   - Her commit GitHub Actions'ı tetikler
   - Hataları erken yakalayın

2. **Commit mesajları anlamlı olsun**
   ```bash
   ✅ git commit -m "Task entity'ye priority özelliği eklendi"
   ❌ git commit -m "update"
   ```

3. **Branch kullanın** (ileri seviye)
   ```bash
   git checkout -b yeni-ozellik
   # Değişiklikleri yapın
   git commit -m "Yeni özellik eklendi"
   git push -u origin yeni-ozellik
   # GitHub'da Pull Request açın
   ```

4. **.gitignore dosyasını koruyun**
   - Gereksiz dosyalar yüklenmesin
   - Build dosyaları, cache dosyaları ignore edilir

## 🎯 Sonraki Adımlar

1. ✅ Projeyi GitHub'a yükleyin
2. ✅ GitHub Actions'ın çalıştığını doğrulayın
3. ✅ Build badge'i README'ye ekleyin
4. ✅ Kod değişikliği yapın ve test edin
5. 📱 İleriye dönük: MacinCloud (24 saat ücretsiz) ile gerçek simülatörde test

## ❓ Sık Sorulan Sorular

**S: Projeyi Windows'ta çalıştırabilir miyim?**
A: Hayır, iOS uygulamaları sadece macOS + Xcode ile çalışır. Ama GitHub Actions ile build test edebilirsiniz.

**S: GitHub Actions her zaman ücretsiz mi?**
A: Public repolar için evet. Private repolar için aylık 2000 dakika ücretsiz.

**S: Kodda değişiklik yapsam çalışır mı?**
A: GitHub Actions her push'ta test eder. Syntax hatası varsa gösterir.

**S: Uygulamayı telefonuma yükleyebilir miyim?**
A: Bunun için Mac + Xcode gerekli. Alternatif: MacinCloud, TestFlight, veya arkadaşınızın Mac'i.

## 🎉 Başarılar!

Artık Mac olmadan Dragon Quest projesini yönetebilir, güncelleyebilir ve test edebilirsiniz!

Sorularınız için: [Issues](https://github.com/KULLANICI_ADINIZ/dragon-quest/issues) sayfasından bildirin.

---

**Not**: Bu kılavuz Windows 10/11 için hazırlanmıştır. Linux kullanıcıları benzer komutları kullanabilir.

