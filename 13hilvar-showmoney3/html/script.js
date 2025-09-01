let currentMoney = 0;

// Parayı formatla (virgülle ayır)
function formatMoney(amount) {
    return '$' + new Intl.NumberFormat('en-US').format(Math.floor(amount));
}

// Para gösterimini başlat
function showMoneyDisplay(money) {
    const display = document.getElementById('moneyDisplay');
    const amountElement = document.getElementById('moneyAmount');
    
    currentMoney = money;
    amountElement.textContent = formatMoney(money);
    display.classList.remove('hidden');
}

// Para miktarını güncelle (animasyonsuz)
function updateMoneyAmount(newMoney) {
    const amountElement = document.getElementById('moneyAmount');
    
    if (newMoney !== currentMoney) {
        currentMoney = newMoney;
        amountElement.textContent = formatMoney(newMoney);
    }
}

// Para gösterimini gizle/göster
function toggleMoneyDisplay(show) {
    const display = document.getElementById('moneyDisplay');
    
    if (show) {
        display.classList.remove('hidden');
    } else {
        display.classList.add('hidden');
    }
}

// Lua'dan gelen mesajları dinle
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.type) {
        case 'showMoney':
            // İlk para gösterimi
            showMoneyDisplay(data.money);
            break;
            
        case 'updateMoney':
            // Para güncelleme
            updateMoneyAmount(data.money);
            break;
            
        case 'toggleDisplay':
            // Para gösterimini aç/kapat
            toggleMoneyDisplay(data.show);
            break;
    }
});

// Sayfa yüklendiğinde başlat
document.addEventListener('DOMContentLoaded', function() {
    console.log('13hilvar Sade Para Gösterme Sistemi yüklendi');
    
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

// GetParentResourceName fonksiyonu
function GetParentResourceName() {
    return window.location.hostname === 'nui-game-internal' ? 
           '13hilvar-showmoney3' : 
           window.location.pathname.split('/')[1];
}