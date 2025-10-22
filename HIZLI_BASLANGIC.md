# ⚡ Hızlı Başlangıç - Dragon Quest (Windows Kullanıcıları)

## 🎯 5 Dakikada GitHub'a Yükle ve Test Et!

### Ön Hazırlık
✅ Git kurulu olmalı: https://git-scm.com/download/win  
✅ GitHub hesabı olmalı: https://github.com/signup

---

## 📝 Komutlar (PowerShell veya Terminal'de)

### 1. Proje Klasörüne Git
```powershell
cd C:\Users\Ulaş\Test
```

### 2. Git Yapılandırması (İlk Kez)
```bash
git config --global user.name "Ulaş Demir"
git config --global user.email "demir.ulasx@gmail.com"
```

### 3. GitHub'da Repository Oluştur
1. https://github.com/new adresine git
2. **Repository name**: `dragon-quest`
3. **Public** seç (ücretsiz GitHub Actions için)
4. **Create repository** tıkla
5. Sayfayı açık tut

### 4. Projeyi Yükle (Terminal'de)
```bash
# Git repository başlat
git init

# Tüm dosyaları ekle
git add .

# İlk commit
git commit -m "Initial commit - Dragon Quest iOS App"

# Ana branch oluştur
git branch -M main

# Remote ekle (KULLANICI_ADINIZ'ı kendi GitHub kullanıcı adınızla değiştir!)
git remote add origin https://github.com/KULLANICI_ADINIZ/dragon-quest.git

# GitHub'a yükle
git push -u origin main
```

**Not**: Kullanıcı adı ve şifre isteyecek. Şifre yerine **Personal Access Token** kullanmanız gerekebilir.

### 5. Token Oluşturma (Şifre Çalışmazsa)
1. GitHub → Settings → Developer settings
2. Personal access tokens → Tokens (classic) → Generate new token
3. Note: `Dragon Quest Upload`
4. Scope: ✅ **repo** seçin
5. Generate token → Token'ı KOPYALAYIN (bir daha gösterilmez!)
6. `git push` yaparken şifre yerine bu token'ı yapıştırın

---

## 🎉 Tamamlandı!

### Şimdi Ne Yapmalı?

#### 1. GitHub Actions Kontrol
```
https://github.com/KULLANICI_ADINIZ/dragon-quest/actions
```
- 🟡 Sarı: Build çalışıyor (1-2 dk bekle)
- ✅ Yeşil: Build başarılı! 🎉
- ❌ Kırmızı: Hata var, tıkla detayları gör

#### 2. Projeyi İncele
```
https://github.com/KULLANICI_ADINIZ/dragon-quest
```
- Tüm dosyalar görünüyor
- Kod arama yapabilirsin
- README.md otomatik görüntülenir

#### 3. Kod Düzenleme (Opsiyonel)
Repository sayfasında klavyede **"."** (nokta) tuşuna bas → VSCode açılır!

---

## 🔄 Değişiklik Yapma (İleride)

```bash
# 1. Dosyayı düzenle (VS Code, Notepad++, vb. ile)

# 2. Git'e ekle
git add .

# 3. Commit yap
git commit -m "Açıklama buraya"

# 4. GitHub'a gönder
git push

# 5. GitHub Actions otomatik test eder!
```

---

## 📚 Detaylı Kılavuz

**Windows kullanıcıları için tam kılavuz**: [WINDOWS_KULLANICILARI_ICIN.md](WINDOWS_KULLANICILARI_ICIN.md)

---

## ❓ Sorun mu Var?

### "Permission denied"
→ Personal Access Token kullan (yukarıda anlatıldı)

### "fatal: not a git repository"
→ Doğru klasörde misin? `cd C:\Users\Ulaş\Test` komutuyla kontrol et

### "remote origin already exists"
→ Zaten eklemişsin, `git push` yapabilirsin

### GitHub Actions çalışmıyor
→ Repository **Public** mi kontrol et

---

## 🎯 Sonraki Adım

Build başarılı olduktan sonra:
- 📱 MacinCloud (24 saat ücretsiz) ile simülatörde test et
- 🎨 Kodda değişiklik yap ve GitHub Actions ile test et
- 📄 Dokümantasyonları oku (README.md, ARCHITECTURE.md)

**Başarılar! 🚀**

