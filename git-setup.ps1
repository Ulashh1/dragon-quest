# Dragon Quest Git Setup Script

Write-Host "=== Dragon Quest Git Kurulumu ===" -ForegroundColor Green
Write-Host ""

# Git yapılandırması
Write-Host "1. Git kullanıcı ayarları yapılandırılıyor..." -ForegroundColor Yellow
git config --global user.name "Ulaş Demir"
git config --global user.email "demir.ulasx@gmail.com"
Write-Host "   ✓ Tamamlandı" -ForegroundColor Green
Write-Host ""

# Git repository başlat (zaten başlatılmış olabilir)
Write-Host "2. Git repository kontrol ediliyor..." -ForegroundColor Yellow
if (!(Test-Path ".git")) {
    git init
    Write-Host "   ✓ Git repository başlatıldı" -ForegroundColor Green
} else {
    Write-Host "   ✓ Git repository zaten mevcut" -ForegroundColor Green
}
Write-Host ""

# Tüm dosyaları ekle
Write-Host "3. Dosyalar Git'e ekleniyor..." -ForegroundColor Yellow
git add .
Write-Host "   ✓ Tamamlandı" -ForegroundColor Green
Write-Host ""

# Commit yap
Write-Host "4. İlk commit yapılıyor..." -ForegroundColor Yellow
git commit -m "Initial commit - Dragon Quest iOS App"
Write-Host "   ✓ Tamamlandı" -ForegroundColor Green
Write-Host ""

# Main branch oluştur
Write-Host "5. Main branch oluşturuluyor..." -ForegroundColor Yellow
git branch -M main
Write-Host "   ✓ Tamamlandı" -ForegroundColor Green
Write-Host ""

# Durum göster
Write-Host "=== GIT DURUMU ===" -ForegroundColor Cyan
git status
Write-Host ""

Write-Host "=== SONRAKİ ADIMLAR ===" -ForegroundColor Magenta
Write-Host ""
Write-Host "1. GitHub'da yeni repository oluşturun:" -ForegroundColor White
Write-Host "   https://github.com/new" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Repository adı: dragon-quest" -ForegroundColor White
Write-Host "3. Public seçin" -ForegroundColor White
Write-Host ""
Write-Host "4. Aşağıdaki komutu çalıştırın (KULLANICI_ADINIZ yerine GitHub kullanıcı adınızı yazın):" -ForegroundColor White
Write-Host ""
Write-Host '   git remote add origin https://github.com/KULLANICI_ADINIZ/dragon-quest.git' -ForegroundColor Yellow
Write-Host '   git push -u origin main' -ForegroundColor Yellow
Write-Host ""
Write-Host "=== TAMAMLANDI! ===" -ForegroundColor Green

