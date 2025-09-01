# 13hilvar Para Gösterme Sistemi v2.0

REDM VORP Framework için gelişmiş para gösterme sistemi. Sağ üstte sürekli para gösterimi ve para değişikliklerinde ekran ortasında animasyonlu bildirimler.

## Özellikler

- **Sürekli Para Gösterimi**: Sağ üstte animasyonsuz, sürekli para gösterimi
- **Gerçek Zamanlı Güncellemeler**: Para değişikliklerinde otomatik güncelleme
- **Para Değişim Bildirimleri**: Ekran ortasında yeşil (+) ve kırmızı (-) bildirimler
- **Smooth Animasyonlar**: Para artış/azalış animasyonları
- **Responsive Tasarım**: Tüm ekran çözünürlüklerinde çalışır
- **VORP Entegrasyonu**: VORP Framework ile sorunsuz entegrasyon
- **Özel Font**: Gala Condensed Medium font desteği
- **Performans Optimizasyonu**: Minimal kaynak kullanımı

## Kurulum

1. Bu kaynağı `resources` klasörüne indirin
2. `GalaCondensed-Medium.woff2` font dosyasını `html/fonts/` dizinine ekleyin
3. `server.cfg` dosyanıza `ensure 13hilvar-showmoney2` ekleyin
4. Sunucunuzu yeniden başlatın

## Font Kurulumu

Gala Condensed Medium fontunu almak için:
1. Fontu güvenilir bir kaynaktan indirin
2. Online converter kullanarak WOFF2 formatına dönüştürün
3. Dosyayı `html/fonts/` klasörüne `GalaCondensed-Medium.woff2` adıyla yerleştirin

## Komutlar

- `/refreshmoney` - Para gösterimini manuel olarak yenile
- `/setmoney [oyuncuId] [miktar]` - Oyuncu parasını ayarla (sadece konsol)
- `/addmoney [oyuncuId] [miktar]` - Oyuncuya para ekle (sadece konsol)

## Yapılandırma

Para gösterimi otomatik olarak şu durumlarda kontrol edilir:
- Oyuncu ölüm durumu
- Menü etkileşimleri
- VORP Framework eventleri

### Config.lua Ayarları

```lua
Config.UpdateInterval = 500 -- Para kontrol aralığı
Config.AnimationDuration = 1000 -- Animasyon süresi
Config.ShowDuringDeath = false -- Ölüyken göster
Config.ShowNotifications = true -- Para değişim bildirimleri
Config.NotificationDuration = 3000 -- Bildirim süresi
```

## Sistem Davranışı

### Sağ Üst Para Gösterimi
- Sürekli görünür (animasyonsuz)
- Para değişikliklerinde smooth güncelleme
- Sarı renkte kısa animasyon ile güncelleme

### Ekran Ortası Bildirimler
- Para artışında: Yeşil + işareti ile miktar
- Para azalışında: Kırmızı - işareti ile miktar
- 3 saniye gösterim süresi
- Smooth slide-in/slide-out animasyonları

## Uyumluluk

- **REDM**: Son sürüm
- **VORP Framework**: Tüm sürümler
- **Bağımlılıklar**: vorp_core

## Destek

Destek veya özelleştirme talepleri için 13hilvar ile iletişime geçin.

---

**Sürüm**: 2.0.0  
**Yazar**: 13hilvar  
**Framework**: VORP  
**Oyun**: Red Dead Redemption 2

## Değişiklik Notları

### v2.0.0
- Sağ üstte sürekli para gösterimi eklendi
- Ekran ortasında para değişim bildirimleri eklendi
- Gelişmiş animasyon sistemi
- Responsive tasarım iyileştirmeleri
- Türkçe dil desteği
- Performans optimizasyonları