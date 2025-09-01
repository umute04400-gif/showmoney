local VorpCore = {}

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

-- Function to get player money
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

-- Event when player money changes (hook into VORP events)
RegisterServerEvent('vorp:updateMoney')
AddEventHandler('vorp:updateMoney', function(playerId, newMoney)
    if playerId then
        TriggerClientEvent('13hilvar-showmoney:updateMoney', playerId, newMoney)
    end
end)

-- Manual money update command (for testing)
RegisterCommand('refreshmoney', function(source, args, rawCommand)
    local playerId = source
    local money = GetPlayerMoney(playerId)
    TriggerClientEvent('13hilvar-showmoney:updateMoney', playerId, money)
    print(string.format("^2[13hilvar-showmoney]^7 Updated money display for player %d: $%d", playerId, money))
end, false)

-- Admin command to set money (for testing)
RegisterCommand('setmoney', function(source, args, rawCommand)
    if source == 0 then -- Console only
        local playerId = tonumber(args[1])
        local amount = tonumber(args[2])
        
        if playerId and amount then
            local User = VorpCore.getUser(playerId)
            if User then
                local Character = User.getUsedCharacter
                if Character then
                    Character.setMoney(amount)
                    TriggerClientEvent('13hilvar-showmoney:updateMoney', playerId, amount)
                    print(string.format("^2[13hilvar-showmoney]^7 Set money for player %d to $%d", playerId, amount))
                else
                    print("^1[13hilvar-showmoney]^7 Character not found for player " .. playerId)
                end
            else
                print("^1[13hilvar-showmoney]^7 User not found for player " .. playerId)
            end
        else
            print("^1[13hilvar-showmoney]^7 Usage: setmoney [playerId] [amount]")
        end
    end
end, true)

-- Hook into VORP money events to automatically update display
AddEventHandler('vorp:playerMoneyChange', function(playerId, oldMoney, newMoney)
    TriggerClientEvent('13hilvar-showmoney:updateMoney', playerId, newMoney)
end)

print("^2[13hilvar-showmoney]^7 Server script loaded successfully")