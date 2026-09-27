RegisterNetEvent("fortal-character:Server:Creator:Open", function(playerSource)
    local dimension = math.ceil(math.random(1000, 2000) * math.pi)

    SetPlayerRoutingBucket(playerSource, dimension)

    TriggerClientEvent("fortal-character:Client:Creator:Open", playerSource)
end)

RegisterNetEvent("fortal-character:Server:Creator:Finish", function(genetics, appearance, clothes)
    local playerSource = source

    local userLicense = vRP.getIdentities(playerSource)
    local userPhone = vRP.generatePhone()
    local userSerial = vRP.generateSerial()

    local queryData = vRP.query("fortal-characters/createCharacter", { 
        steam = userLicense,
        name = genetics.name,
        name2 = genetics.surname,
        sex = string.upper(genetics.gender),
        phone = userPhone,
        serial = userSerial,
        blood = math.random(0,4),
        reset = false
    })
        
    if queryData.insertId then
        vRP.query("fortal-characters/addCharacterData", { user_id = queryData.insertId, key = "Character", value = json.encode(appearance) })
        vRP.query("fortal-characters/addCharacterData", { user_id = queryData.insertId, key = "Clothings", value = json.encode(clothes) })
        vRP.query("fortal-characters/addCharacterData", { user_id = queryData.insertId, key = "Tattoos", value = json.encode({}) })
        vRP.query("fortal-characters/addCharacterData", { user_id = queryData.insertId, key = "Position", value = json.encode(Config.Creator.Spawn) })

        TriggerClientEvent("fortal-character:Client:Skinshop:Close", playerSource)
        
        Wait(500)

        vRP.characterChosen(playerSource, queryData.insertId, "mp_"..genetics.gender.."_freemode_01", "Sul")
        TriggerClientEvent("vRP:playerActive", playerSource, queryData.insertId, genetics.name.." "..genetics.surname)

        Wait(1000)
        
        TriggerClientEvent("fortal-character:Client:Skinshop:SaveDefault", playerSource, clothes)

        TriggerClientEvent("fortal-character:Client:Sync:Start", playerSource, {
            appearance = appearance
        })
        TriggerClientEvent("fortal-character:Client:Creator:Spawn", playerSource)

        SetPlayerRoutingBucket(playerSource, 0)
    end
end)