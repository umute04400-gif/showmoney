local VorpCore = {}

-- VORP Core'u al
Citizen.CreateThread(function()
    while VorpCore.addRpcCallback == nil do
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
        Citizen.Wait(200)
    end
end)

local isUIOpen = false

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
                    
                    if not isUIOpen then
                        SetNuiFocus(false, false)
                        SendNUIMessage({
                            type = "showMoney",
                            money = money
                        })
                        isUIOpen = true
                    else
                        SendNUIMessage({
                            type = "updateMoney",
                            money = money
                        })
                    end
                end
            end
        end
    end
end)

-- Para güncelleme eventi
RegisterNetEvent('13hilvar-showmoney3:updateMoney')
AddEventHandler('13hilvar-showmoney3:updateMoney', function(newMoney)
    SendNUIMessage({
        type = "updateMoney",
        money = newMoney
    })
end)

-- Para gösterimini aç/kapat
RegisterNetEvent('13hilvar-showmoney3:toggle')
AddEventHandler('13hilvar-showmoney3:toggle', function(show)
    SendNUIMessage({
        type = "toggleDisplay",
        show = show
    })
    isUIOpen = show
end)

-- Ölüm durumu kontrolü
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
        if not Config.ShowDuringDeath then
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) then
                SendNUIMessage({
                    type = "toggleDisplay",
                    show = false
                })
            else
                if isUIOpen then
                    SendNUIMessage({
                        type = "toggleDisplay",
                        show = true
                    })
                end
            end
        end
    end
end)

-- NUI Callback - Para bilgisi isteme
RegisterNUICallback('requestMoney', function(data, cb)
    if VorpCore and VorpCore.getUser then
        local User = VorpCore.getUser()
        if User then
            local Character = User.getUsedCharacter
            if Character then
                cb({money = Character.money})
                return
            end
        end
    end
    cb({money = 0})
end)