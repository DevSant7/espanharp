RegisterNetEvent("fortal-character:Server:Tattooshop:Finish", function(price, tattooData)
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
            vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Tattoos", value = json.encode(tattooData) })
            TriggerClientEvent("Notify", playerSource, "verde", "Você salvou suas novas tatuagens pelo valor de <b>$"..price.."</b>.", 5000)
            TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
                tattoos = tattooData
            })        
        else
            TriggerClientEvent("Notify", playerSource, "vermelho", "Você não possui <b>"..price.."</b> para salvar suas tatuagens.", 5000)
        end
    else
        TriggerClientEvent("fortal-character:Client:Tattooshop:Close", playerSource)
        TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
            tattoos = tattooData
        })
        
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Tattoos", value = json.encode(tattooData) })
    end

    TriggerClientEvent("fortal-character:Client:Tattooshop:Close", playerSource)
end)

RegisterNetEvent("fortal-character:Server:Tattooshop:Save", function(playerSource, tattooData)
    local playerSource = playerSource or source
    local userId = vRP.getUserId(playerSource)

    if userId then
        TriggerClientEvent("fortal-character:Client:Tattooshop:Close", playerSource)
        TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
            tattoos = tattooData
        })
        
        vRP.query("fortal-characters/setCharacterData", { userId = userId, key = "Tattoos", value = json.encode(tattooData) })
    end
end)

if Config.Tattooshop.Command then
    RegisterCommand(Config.Tattooshop.Command.Name, function(playerSource)
        local userId = vRP.getUserId(playerSource)

        if userId then
            local permissionsData = Config.Tattooshop.Command.Permissions
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
                TriggerClientEvent("fortal-character:Client:Tattooshop:Open", playerSource)
            end
        end
    end)
end