local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

vFunc = {}
Tunnel.bindInterface("fortal-character")

vRP.prepare("fortal-characters/getCharacters","SELECT * FROM characters WHERE steam = @steam and deleted = 0")
vRP.prepare("fortal-characters/deleteCharacter", "UPDATE characters SET deleted = 1 WHERE id = @id AND steam = @steam")
vRP.prepare("fortal-characters/setCharacterData", "UPDATE playerdata SET dvalue = @value WHERE dkey = @key AND user_id = @userId")
vRP.prepare("fortal-characters/addCharacterData", "INSERT INTO playerdata(user_id, dkey, dvalue) VALUES(@user_id, @key, @value)")
vRP.prepare("fortal-characters/getCharacterData", "SELECT dvalue FROM playerdata WHERE user_id = @user_id AND dkey = @key")
vRP.prepare("fortal-characters/createCharacter", "INSERT INTO characters(steam,name,name2,sex,phone,serial,blood,reset) VALUES(@steam,@name,@name2,@sex,@phone,@serial,@blood,@reset)")

PlayersSpawned = {}

RegisterNetEvent("fortal-character:Server:Spawn", function()
    local playerSource = source
    local playerSteam = vRP.getIdentities(playerSource)
    local playerCharacters = vRP.query("fortal-characters/getCharacters", { steam = playerSteam })

    if #playerCharacters > 0 then
        TriggerEvent("fortal-character:Server:Selector:Open", playerSource)
    else
        TriggerEvent("fortal-character:Server:Creator:Open", playerSource)
    end
end)