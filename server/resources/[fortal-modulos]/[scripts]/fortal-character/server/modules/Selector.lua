RegisterNetEvent("fortal-character:Server:Selector:Open", function(playerSource)
    local playerSteam = vRP.getIdentities(playerSource)
    local playerInfos = vRP.infoAccount(playerSteam)
    local playerCharacters = vRP.query("fortal-characters/getCharacters", { steam = playerSteam })
    local dimension = math.ceil(math.random(1000, 2000) * math.pi)

    if playerInfos then
        SetPlayerRoutingBucket(playerSource, dimension)

        local characters = {}
    
        for index = 1, playerInfos["chars"] do
            local characterData = playerCharacters[index]

            if characterData then
                local vip = false

                for _,v in pairs(Config.Selector.Vip.Groups) do
                    if vRP.hasGroup(characterData.id, v) then
                        characterData.vipDate = json.decode(characterData.vipDate)
                        local remaingTime = 0
    
                        if characterData.vipDate and type(characterData.vipDate) == "table" and characterData.vipDate[v] then
                            remaingTime = Config.Selector.Vip.Time - (os.time() - characterData.vipDate[v]) / 86400
                        end
                        
                        if remaingTime > 0 then
                            vip = {
                                title = v,
                                remaining = math.ceil(remaingTime)
                            }
    
                            break
                        end
                    end
                end

                local characterAppearance = vRP.userData(characterData.id, "Character")
                local characterClothings = vRP.userData(characterData.id, "Clothings")
                local characterTattoos = vRP.userData(characterData.id, "Tattoos")

                characters[index] = {
                    type = "character",
                    name = characterData.name.." "..characterData.name2,
                    id = characterData.id,
                    gender = string.lower(characterData.sex),
                    age = characterData.age,
                    bank = characterData.bank,
                    phone = characterData.phone,
                    appearance = characterAppearance,
                    clothes = characterClothings,
                    tattoos = characterTattoos,
                    gems = characterData.gems,
                    vip = vip
                }
            else
                characters[index] = {
                    type = "slot",
                    price = Config.Selector.Price
                }
            end 
        end
    
        TriggerClientEvent("fortal-character:Client:Selector:Open", playerSource, characters)
    end
end)

RegisterNetEvent("fortal-character:Server:Selector:Delete", function(data)
    local playerSource = source
    local playerSteam = vRP.getIdentities(playerSource)

    vRP.query("fortal-characters/deleteCharacter", { steam = playerSteam, id = data.id })
    TriggerClientEvent("fortal-character:Client:AddNotify", playerSource, { 
        title = "Sucesso",
        description = "Personagem <b>"..data.name.." foi deletado com sucesso.",
        delay = 5000
    })
end)

RegisterNetEvent("fortal-character:Server:Selector:SelectCharacter", function(data)
    local playerSource = source
    local queryPosition = json.decode(vRP.query("fortal-characters/getCharacterData", { user_id = data.id, key = "Position" })[1].dvalue)
    local playerGender = string.lower(string.sub(data.gender, 1, 1))

    TriggerClientEvent("fortal-character:Client:Selector:Close", playerSource)

    vRP.characterChosen(playerSource, data.id)
    TriggerClientEvent("vRP:playerActive", playerSource, data.id, data.name)

    Wait(500)

    SetPlayerRoutingBucket(playerSource, 0)
    TriggerClientEvent("fortal-character:Client:Skinshop:SaveDefault", playerSource, data.clothes)
    TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
        appearance = data.appearance,
        tattoos = data.tattoos
    })

    if PlayersSpawned[data.id] then
        TriggerClientEvent("fortal-character:Client:Selector:Spawn", playerSource, playerGender, queryPosition, data.appearance, data.clothes, data.tattoos)
    else
        PlayersSpawned[data.id] = true
        TriggerClientEvent("fortal-character:Client:Spawn:Open", playerSource, playerGender, queryPosition, data.appearance, data.clothes, data.tattoos)
    end
end)

if Config.Selector.Command then
    RegisterCommand(Config.Selector.Command.Name, function(playerSource)    
        local userId = vRP.getUserId(playerSource)
        local playerPed = GetPlayerPed(playerSource)
        local playerCoords = GetEntityCoords(playerPed)
        
        if userId then
            local permissionsData = Config.Selector.Command.Permissions
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
                vRP.rejoinPlayer(playerSource)

                TriggerEvent("fortal-character:Server:Selector:Open", playerSource)
            end
        end
    end)
end