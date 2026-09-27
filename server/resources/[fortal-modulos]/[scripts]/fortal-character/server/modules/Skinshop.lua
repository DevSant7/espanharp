RegisterNetEvent("fortal-character:Server:Skinshop:Finish", function(price, clothesData)
    local playerSource = source
    local userId = vRP.getUserId(playerSource)
    local userWallet = vRP.itemAmount(userId, "dollars")
    local userBank = vRP.getBank(userId)

    if price > 0 then
        local proceed = false

        if userWallet >= price then
            vRP.tryGetInventoryItem(userId, "dollars", price)
            proceed = true
        end

        if userBank >= price then
            vRP.delBank(userId, price)
            proceed = true
        end


        if proceed then
            vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Clothings", value = json.encode(clothesData) })
            TriggerClientEvent("Notify", playerSource, "verde", "Você adquiriu suas novas roupas pelo valor de <b>$"..price.."</b>.", 5000)
            TriggerClientEvent("fortal-character:Client:Skinshop:SaveDefault", playerSource, clothesData)
        else
            TriggerClientEvent("Notify", playerSource, "vermelho", "Você não possui <b>"..price.."</b> para adquirir estas roupas.", 5000)
        end
    else
        TriggerClientEvent("fortal-character:Client:Skinshop:SaveDefault", playerSource, clothesData)
        
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Clothings", value = json.encode(clothesData) })
    end

    TriggerClientEvent("fortal-character:Client:Skinshop:Close", playerSource)
end)

RegisterNetEvent("fortal-character:Server:Skinshop:Save", function(playerSource, clothesData)
    local playerSource = playerSource or source
    local userId = vRP.getUserId(playerSource)

    if userId then
        TriggerClientEvent("fortal-character:Client:Skinshop:Close", playerSource)
        TriggerClientEvent("fortal-character:Client:Skinshop:SaveDefault", playerSource, clothesData)
            
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Clothings", value = json.encode(clothesData) })
    end
end)

if Config.Skinshop.Command then
    RegisterCommand(Config.Skinshop.Command.Name, function(playerSource)    
        local userId = vRP.getUserId(playerSource)
        
        if userId then
            local permissionsData = Config.Skinshop.Command.Permissions
            local permissionsAvailable = false
    
            if permissionsData then
                for name, hierarchy in pairs(permissionsData) do
                    if vRP.hasGroup(userId, name, hierarchy) then
                        permissionsAvailable = true
                    end
                end
            else
                permissionsAvailable = true
            end
    
            if permissionsAvailable then
                TriggerClientEvent("fortal-character:Client:Skinshop:Open", playerSource)
            end
        end
    end)
end