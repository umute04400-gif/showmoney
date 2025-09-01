local VorpCore = {}

Citizen.CreateThread(function()
    while VorpCore.addRpcCallback == nil do
        TriggerEvent("getCore", function(core)
            VorpCore = core
        end)
        Citizen.Wait(200)
    end
end)

local isUIOpen = false

-- Initialize the money display
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        
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

-- Event to update money when it changes
RegisterNetEvent('13hilvar-showmoney:updateMoney')
AddEventHandler('13hilvar-showmoney:updateMoney', function(newMoney)
    SendNUIMessage({
        type = "updateMoney",
        money = newMoney
    })
end)

-- Event to show/hide money display
RegisterNetEvent('13hilvar-showmoney:toggle')
AddEventHandler('13hilvar-showmoney:toggle', function(show)
    SendNUIMessage({
        type = "toggleDisplay",
        show = show
    })
    isUIOpen = show
end)

-- Hide money display for certain scenarios
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)
        
        -- Hide during death, menu interactions, etc.
        if IsPlayerDead(PlayerId()) or IsPauseMenuActive() then
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
end)