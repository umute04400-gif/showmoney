let currentMoney = 0;
let updateTimeout;
let notificationTimeout;

// Parayı formatla (virgülle ayır)
function formatMoney(amount) {
    return new Intl.NumberFormat('en-US').format(Math.floor(amount));
}

// Para gösterimini başlat
function showMoneyDisplay(money) {
    const container = document.getElementById('moneyContainer');
    const amountElement = document.getElementById('moneyAmount');
    
    currentMoney = money;
    amountElement.textContent = formatMoney(money);
    
    container.classList.remove('hidden');
    container.classList.add('visible');
}

// Para miktarını güncelle
function updateMoneyAmount(newMoney, animate = false) {
    const amountElement = document.getElementById('moneyAmount');
    
    if (newMoney !== currentMoney) {
        if (animate) {
            // Güncelleme animasyonu ekle
            amountElement.classList.add('updating');
            
            // Önceki timeout'u temizle
            if (updateTimeout) {
                clearTimeout(updateTimeout);
            }
            
            // Sayı değişim animasyonu
            const startMoney = currentMoney;
            const difference = newMoney - startMoney;
            const duration = 600; // 600ms animasyon
            const steps = 20;
            const stepAmount = difference / steps;
            const stepDuration = duration / steps;
            
            let currentStep = 0;
            
            const animateNumber = () => {
                currentStep++;
                const progress = currentStep / steps;
                const easedProgress = easeOutQuart(progress);
                const displayMoney = startMoney + (difference * easedProgress);
                
                amountElement.textContent = formatMoney(displayMoney);
                
                if (currentStep < steps) {
                    setTimeout(animateNumber, stepDuration);
                } else {
                    currentMoney = newMoney;
                    amountElement.textContent = formatMoney(newMoney);
                    
                    // Güncelleme sınıfını kaldır
                    updateTimeout = setTimeout(() => {
                        amountElement.classList.remove('updating');
                    }, 200);
                }
            };
            
            animateNumber();
        } else {
            // Animasyonsuz güncelleme
            currentMoney = newMoney;
            amountElement.textContent = formatMoney(newMoney);
        }
    }
}

// Para değişim bildirimini göster
function showMoneyChangeNotification(amount, isPositive) {
    const notification = document.getElementById('moneyNotification');
    const content = document.getElementById('notificationContent');
    const sign = document.getElementById('notificationSign');
    const amountElement = document.getElementById('notificationAmount');
    
    // Önceki bildirimi temizle
    if (notificationTimeout) {
        clearTimeout(notificationTimeout);
        notification.classList.remove('show', 'slide-in', 'slide-out');
    }
    
    // İçeriği ayarla
    sign.textContent = isPositive ? '+' : '-';
    amountElement.textContent = '$' + formatMoney(Math.abs(amount));
    
    // Renkleri ayarla
    if (isPositive) {
        content.classList.remove('negative');
        content.classList.add('positive');
        sign.classList.remove('negative');
        sign.classList.add('positive');
    } else {
        content.classList.remove('positive');
        content.classList.add('negative');
        sign.classList.remove('positive');
        sign.classList.add('negative');
    }
    
    // Bildirimi göster
    notification.classList.add('show', 'slide-in');
    
    // Belirli süre sonra gizle
    notificationTimeout = setTimeout(() => {
        notification.classList.remove('slide-in');
        notification.classList.add('slide-out');
        
        setTimeout(() => {
            notification.classList.remove('show', 'slide-out');
        }, 400);
    }, Config?.NotificationDuration || 3000);
}

// Easing fonksiyonu
function easeOutQuart(t) {
    return 1 - Math.pow(1 - t, 4);
}

// Para gösterimini gizle/göster
function toggleMoneyDisplay(show) {
    const container = document.getElementById('moneyContainer');
    
    if (show) {
        container.classList.remove('hidden');
        container.classList.add('visible');
    } else {
        container.classList.add('hidden');
        container.classList.remove('visible');
    }
}

// Lua'dan gelen mesajları dinle
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.type) {
        case 'showMoney':
            // İlk para gösterimi (animasyonsuz)
            showMoneyDisplay(data.money);
            break;
            
        case 'updateMoney':
            // Para güncelleme (animasyonlu)
            updateMoneyAmount(data.money, data.animate || false);
            break;
            
        case 'showMoneyChange':
            // Para değişim bildirimi
            showMoneyChangeNotification(data.amount, data.isPositive);
            break;
            
        case 'toggleDisplay':
            // Para gösterimini aç/kapat
            toggleMoneyDisplay(data.show);
            break;
    }
});

// Sayfa yüklendiğinde başlat
document.addEventListener('DOMContentLoaded', function() {
    console.log('13hilvar Para Gösterme Sistemi v2.0 yüklendi');
    
    // İlk para bilgisini iste
    fetch(`https://${GetParentResourceName()}/requestMoney`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
    }).catch(() => {
        // NUI context'inde fetch hatalarını yoksay
    });
});

// GetParentResourceName fonksiyonu (NUI için)
function GetParentResourceName() {
    return window.location.hostname === 'nui-game-internal' ? 
           '13hilvar-showmoney2' : 
           window.location.pathname.split('/')[1];
}