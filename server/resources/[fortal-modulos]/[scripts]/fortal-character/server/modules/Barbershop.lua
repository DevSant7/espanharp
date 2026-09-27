RegisterNetEvent("fortal-character:Server:Barbershop:Finish", function(price, appearanceData)
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
            vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Character", value = json.encode(appearanceData) })
            TriggerClientEvent("Notify", playerSource, "verde", "Você salvou sua nova aparência pelo valor de <b>$"..price.."</b>.", 5000)
            TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
                appearance = appearanceData
            })
        else
            TriggerClientEvent("Notify", playerSource, "vermelho", "Você não possui <b>"..price.."</b> para salvar sua aparência.", 5000)
        end
    else
        TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
            appearance = appearanceData
        })
        
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Character", value = json.encode(appearanceData) })
    end

    TriggerClientEvent("fortal-character:Client:Barbershop:Close", playerSource)
end)

RegisterNetEvent("fortal-character:Server:Barbershop:Save", function(playerSource, appearanceData)
    local playerSource = playerSource or source
    local userId = vRP.getUserId(playerSource)

    if userId then
        TriggerClientEvent("fortal-character:Client:Barbershop:Close", playerSource)
        TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
            appearance = appearanceData
        })
        
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Character", value = json.encode(appearanceData) })
    end
end)

if Config.Barbershop.Command then
    RegisterCommand(Config.Barbershop.Command.Name, function(playerSource)
        local userId = vRP.getUserId(playerSource)

        if userId then
            local permissionsData = Config.Barbershop.Command.Permissions
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
                TriggerClientEvent("fortal-character:Client:Barbershop:Open", playerSource)
            end
        end
    end)
end