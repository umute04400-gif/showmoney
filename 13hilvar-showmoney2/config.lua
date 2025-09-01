Config = {}

-- Para Gösterme Ayarları
Config.UpdateInterval = 500 -- Para kontrolü aralığı (milisaniye)
Config.AnimationDuration = 1000 -- Para değişim animasyon süresi (milisaniye)

-- Pozisyon Ayarları
Config.Position = {
    top = "20px",
    right = "20px"
}

-- Bildirim Pozisyonu (ekran ortası)
Config.NotificationPosition = {
    top = "50%",
    left = "50%"
}

-- Renkler
Config.Colors = {
    money = "#4ADE80",        -- Para rengi (yeşil)
    background = "rgba(0, 0, 0, 0.8)", -- Arka plan rengi
    border = "rgba(74, 222, 128, 0.3)", -- Çerçeve rengi
    text = "#FFFFFF",         -- Metin rengi
    positive = "#4ADE80",     -- Para artışı rengi (yeşil)
    negative = "#EF4444"      -- Para azalışı rengi (kırmızı)
}

-- Font Ayarları
Config.Font = {
    family = "Gala Condensed",
    fallback = "Arial Narrow, sans-serif",
    size = "20px",
    weight = "500"
}

-- Gösterim Seçenekleri
Config.ShowDuringDeath = false -- Ölüyken para gösterimi
Config.ShowDuringMenus = true  -- Menü açıkken para gösterimi
Config.ShowNotifications = true -- Para değişim bildirimleri

-- Bildirim Ayarları
Config.NotificationDuration = 3000 -- Bildirim gösterim süresi (milisaniye)
Config.MinChangeAmount = 1 -- Minimum para değişimi bildirimi için

-- Debug Modu
Config.Debug = false -- Debug mesajları için true yapın