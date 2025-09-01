local VorpCore = {}

-- VORP Core'u al
TriggerEvent("getCore", function(core)
    VorpCore = core
end)

-- Oyuncu parasını al
function GetPlayerMoney(playerId)
    local User = VorpCore.getUser(playerId)
    if User then
        local Character = User.getUsedCharacter
        if Character then
            return Character.money or 0
        end
    end
    return 0
end

-- Para yenileme komutu
RegisterCommand('refreshmoney', function(source, args, rawCommand)
    local playerId = source
    local money = GetPlayerMoney(playerId)
    TriggerClientEvent('13hilvar-showmoney3:updateMoney', playerId, money)
    
    if Config.Debug then
        print(string.format("^2[13hilvar-showmoney3]^7 Para güncellendi - Oyuncu: %d, Para: $%d", playerId, money))
    end
end, false)

-- Admin para ayarlama komutu (sadece konsol)
RegisterCommand('setmoney', function(source, args, rawCommand)
    if source == 0 then -- Sadece konsol
        local playerId = tonumber(args[1])
        local amount = tonumber(args[2])
        
        if playerId and amount and amount >= 0 then
            local User = VorpCore.getUser(playerId)
            if User then
                local Character = User.getUsedCharacter
                if Character then
                    Character.setMoney(amount)
                    TriggerClientEvent('13hilvar-showmoney3:updateMoney', playerId, amount)
                    print(string.format("^2[13hilvar-showmoney3]^7 Oyuncu %d parasını $%d olarak ayarlandı", playerId, amount))
                else
                    print("^1[13hilvar-showmoney3]^7 Oyuncu " .. playerId .. " için karakter bulunamadı")
                end
            else
                print("^1[13hilvar-showmoney3]^7 Oyuncu " .. playerId .. " bulunamadı")
            end
        else
            print("^1[13hilvar-showmoney3]^7 Kullanım: setmoney [oyuncuId] [miktar]")
        end
    end
end, true)

-- VORP para değişim eventlerini dinle
AddEventHandler('vorp:playerMoneyChange', function(playerId, oldMoney, newMoney)
    TriggerClientEvent('13hilvar-showmoney3:updateMoney', playerId, newMoney)
end)

-- Sunucu başlatıldığında
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[13hilvar-showmoney3]^7 Sade para gösterme sistemi yüklendi")
    end
end)