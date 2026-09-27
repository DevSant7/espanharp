if Config.Framework ~= "qbox" then

    return

end

debugprint("Loading Qbox")

QB = exports["qb-core"]:GetCoreObject()

debugprint("Qbox loaded")

function IsAdmin(source)

    return QB.Functions.HasPermission(source, "admin") or IsPlayerAceAllowed(source, "command.lbphone_admin") == 1

end

function GetIdentifier(source)

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer?.PlayerData?.citizenid then

        debugprint("GetIdentifier: Failed to get player for source:", source)

        return

    end

    return qPlayer.PlayerData.citizenid

end

function GetSourceFromIdentifier(identifier)

    local player = QB.Functions.GetPlayerByCitizenId(identifier)

    if player then

        return player?.PlayerData?.source

    end

end

function HasItem(source, itemName)

    if GetResourceState("ox_inventory") == "started" then

        return (exports.ox_inventory:Search(source, "count", itemName) or 0) > 0

    elseif GetResourceState("qs-inventory") == "started" then

        return (exports["qs-inventory"]:GetItemTotalAmount(source, itemName) or 0) > 0

    end

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then

        debugprint("HasItem: Failed to get player for source:", source)

        return false

    end

    return (qPlayer.Functions.GetItemByName(itemName)?.amount or 0) > 0

end

function CreateUsableItem(item, cb)

    QB.Functions.CreateUseableItem(item, cb)

end

function GetCharacterName(source)

    local qPlayer = QB.Functions.GetPlayer(tonumber(source))

    if not qPlayer then

        debugprint("GetCharacterName: Failed to get qPlayer for source:", source)

        return GetPlayerName(source), ""

    end

    local characterInfo = qPlayer.PlayerData.charinfo

    return characterInfo.firstname, characterInfo.lastname

end
