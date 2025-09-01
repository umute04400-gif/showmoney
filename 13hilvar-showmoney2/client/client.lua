local VorpCore = {}
local currentMoney = 0
local isUIOpen = false
local isDead = false

-- VORP Core'u al
Citizen.CreateThread(function()
    while VorpCore.addRpcCallback == nil do
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
        Citizen.Wait(200)
    end
end)

-- Para gösterimini başlat
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.UpdateInterval)
        
        if VorpCore and VorpCore.getUser then
            local User = VorpCore.getUser()
            if User then
                local Character = User.getUsedCharacter
                if Character then
                    local money = Character.money
                    
                    -- İlk kez açılıyorsa göster
                    if not isUIOpen then
                        SetNuiFocus(false, false)
                        SendNUIMessage({
                            type = "showMoney",
                            money = money
                        })
                        isUIOpen = true
                        currentMoney = money
                    else
                        -- Para değişikliği varsa güncelle
                        if money ~= currentMoney then
                            local difference = money - currentMoney
                            
                            -- Para gösterimini güncelle
                            SendNUIMessage({
                                type = "updateMoney",
                                money = money,
                                animate = true
                            })
                            
                            -- Para değişim bildirimini göster
                            if Config.ShowNotifications and math.abs(difference) >= Config.MinChangeAmount then
                                SendNUIMessage({
                                    type = "showMoneyChange",
                                    amount = difference,
                                    isPositive = difference > 0
                                })
                            end
                            
                            currentMoney = money
                        end
                    end
                end
            end
        end
    end
end)

-- Ölüm durumu kontrolü
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        local playerPed = PlayerPedId()
        local isDeadNow = IsEntityDead(playerPed)
        
        if isDeadNow ~= isDead then
            isDead = isDeadNow
            
            if not Config.ShowDuringDeath then
                SendNUIMessage({
                    type = "toggleDisplay",
                    show = not isDead
                })
            end
        end
    end
end)

-- Para güncelleme eventi
RegisterNetEvent('13hilvar-showmoney2:updateMoney')
AddEventHandler('13hilvar-showmoney2:updateMoney', function(newMoney)
    local difference = newMoney - currentMoney
    
    SendNUIMessage({
        type = "updateMoney",
        money = newMoney,
        animate = true
    })
    
    -- Para değişim bildirimini göster
    if Config.ShowNotifications and math.abs(difference) >= Config.MinChangeAmount then
        SendNUIMessage({
            type = "showMoneyChange",
            amount = difference,
            isPositive = difference > 0
        })
    end
    
    currentMoney = newMoney
end)

-- Para gösterimini aç/kapat
RegisterNetEvent('13hilvar-showmoney2:toggle')
AddEventHandler('13hilvar-showmoney2:toggle', function(show)
    SendNUIMessage({
        type = "toggleDisplay",
        show = show
    })
    isUIOpen = show
end)

-- NUI Callback - Para bilgisi isteme
RegisterNUICallback('requestMoney', function(data, cb)
    if VorpCore and VorpCore.getUser then
        local User = VorpCore.getUser()
        if User then
            local Character = User.getUsedCharacter
            if Character then
                currentMoney = Character.money
                cb({money = currentMoney})
                return
            end
        end
    end
    cb({money = 0})
end)

-- Debug komutu
if Config.Debug then
    RegisterCommand('moneydebug', function(source, args, rawCommand)
        print("^2[13hilvar-showmoney2]^7 Current Money: $" .. currentMoney)
        print("^2[13hilvar-showmoney2]^7 UI Open: " .. tostring(isUIOpen))
        print("^2[13hilvar-showmoney2]^7 Is Dead: " .. tostring(isDead))
    end, false)
end