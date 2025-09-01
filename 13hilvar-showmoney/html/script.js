let currentMoney = 0;
let updateTimeout;

// Format money with commas
function formatMoney(amount) {
    return new Intl.NumberFormat('en-US').format(Math.floor(amount));
}

// Show money display with animation
function showMoneyDisplay(money) {
    const container = document.getElementById('moneyContainer');
    const amountElement = document.getElementById('moneyAmount');
    
    currentMoney = money;
    amountElement.textContent = formatMoney(money);
    
    container.classList.remove('fade-out');
    container.classList.add('visible', 'fade-in');
    
    // Remove animation class after animation completes
    setTimeout(() => {
        container.classList.remove('fade-in');
    }, 600);
}

// Update money amount with smooth transition
function updateMoneyAmount(newMoney) {
    const amountElement = document.getElementById('moneyAmount');
    
    if (newMoney !== currentMoney) {
        // Add updating animation
        amountElement.classList.add('updating');
        
        // Clear previous timeout
        if (updateTimeout) {
            clearTimeout(updateTimeout);
        }
        
        // Animate the number change
        const startMoney = currentMoney;
        const difference = newMoney - startMoney;
        const duration = 800; // 800ms animation
        const steps = 30;
        const stepAmount = difference / steps;
        const stepDuration = duration / steps;
        
        let currentStep = 0;
        
        const animateNumber = () => {
            currentStep++;
            const progress = currentStep / steps;
            const easedProgress = easeOutCubic(progress);
            const displayMoney = startMoney + (difference * easedProgress);
            
            amountElement.textContent = formatMoney(displayMoney);
            
            if (currentStep < steps) {
                setTimeout(animateNumber, stepDuration);
            } else {
                currentMoney = newMoney;
                amountElement.textContent = formatMoney(newMoney);
                
                // Remove updating class after animation
                updateTimeout = setTimeout(() => {
                    amountElement.classList.remove('updating');
                }, 200);
            }
        };
        
        animateNumber();
    }
}

// Easing function for smooth animation
function easeOutCubic(t) {
    return 1 - Math.pow(1 - t, 3);
}

// Hide money display
function hideMoneyDisplay() {
    const container = document.getElementById('moneyContainer');
    container.classList.remove('visible', 'fade-in');
    container.classList.add('fade-out');
    
    setTimeout(() => {
        container.classList.remove('fade-out');
    }, 400);
}

// Listen for messages from Lua
window.addEventListener('message', function(event) {
    const data = event.data;
    
    switch (data.type) {
        case 'showMoney':
            showMoneyDisplay(data.money);
            break;
            
        case 'updateMoney':
            updateMoneyAmount(data.money);
            break;
            
        case 'toggleDisplay':
            if (data.show) {
                showMoneyDisplay(currentMoney);
            } else {
                hideMoneyDisplay();
            }
            break;
    }
});

// Initialize display on load
document.addEventListener('DOMContentLoaded', function() {
    console.log('13hilvar Money Display System loaded');
    
    // Request initial money data
    fetch(`https://${GetParentResourceName()}/requestMoney`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({})
    }).catch(() => {}); // Ignore fetch errors in NUI context
});