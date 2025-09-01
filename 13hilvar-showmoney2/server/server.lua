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
    TriggerClientEvent('13hilvar-showmoney2:updateMoney', playerId, money)
    
    if Config.Debug then
        print(string.format("^2[13hilvar-showmoney2]^7 Para gösterimi güncellendi - Oyuncu: %d, Para: $%d", playerId, money))
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
                    local oldMoney = Character.money
                    Character.setMoney(amount)
                    TriggerClientEvent('13hilvar-showmoney2:updateMoney', playerId, amount)
                    print(string.format("^2[13hilvar-showmoney2]^7 Oyuncu %d parasını $%d olarak ayarlandı (eski: $%d)", playerId, amount, oldMoney))
                else
                    print("^1[13hilvar-showmoney2]^7 Oyuncu " .. playerId .. " için karakter bulunamadı")
                end
            else
                print("^1[13hilvar-showmoney2]^7 Oyuncu " .. playerId .. " bulunamadı")
            end
        else
            print("^1[13hilvar-showmoney2]^7 Kullanım: setmoney [oyuncuId] [miktar]")
        end
    else
        print("^1[13hilvar-showmoney2]^7 Bu komut sadece konsoldan kullanılabilir")
    end
end, true)

-- Para ekleme komutu (test için)
RegisterCommand('addmoney', function(source, args, rawCommand)
    if source == 0 then -- Sadece konsol
        local playerId = tonumber(args[1])
        local amount = tonumber(args[2])
        
        if playerId and amount then
            local User = VorpCore.getUser(playerId)
            if User then
                local Character = User.getUsedCharacter
                if Character then
                    local oldMoney = Character.money
                    local newMoney = oldMoney + amount
                    Character.setMoney(newMoney)
                    TriggerClientEvent('13hilvar-showmoney2:updateMoney', playerId, newMoney)
                    print(string.format("^2[13hilvar-showmoney2]^7 Oyuncu %d'e $%d eklendi (toplam: $%d)", playerId, amount, newMoney))
                else
                    print("^1[13hilvar-showmoney2]^7 Oyuncu " .. playerId .. " için karakter bulunamadı")
                end
            else
                print("^1[13hilvar-showmoney2]^7 Oyuncu " .. playerId .. " bulunamadı")
            end
        else
            print("^1[13hilvar-showmoney2]^7 Kullanım: addmoney [oyuncuId] [miktar]")
        end
    end
end, true)

-- VORP para değişim eventlerini dinle
AddEventHandler('vorp:playerMoneyChange', function(playerId, oldMoney, newMoney)
    TriggerClientEvent('13hilvar-showmoney2:updateMoney', playerId, newMoney)
    
    if Config.Debug then
        local difference = newMoney - oldMoney
        print(string.format("^2[13hilvar-showmoney2]^7 Para değişimi - Oyuncu: %d, Eski: $%d, Yeni: $%d, Fark: $%d", 
            playerId, oldMoney, newMoney, difference))
    end
end)

-- Sunucu başlatıldığında
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print("^2[13hilvar-showmoney2]^7 Sunucu scripti başarıyla yüklendi")
        print("^2[13hilvar-showmoney2]^7 Komutlar: /refreshmoney, /setmoney [id] [miktar], /addmoney [id] [miktar]")
    end
end)