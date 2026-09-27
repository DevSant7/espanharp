if Config.Framework ~= "standalone" then

    return

end

function IsAdmin(source)

    return IsPlayerAceAllowed(source, "command.lbphone_admin") == 1

end

function GetIdentifier(source)

    return GetPlayerIdentifierByType(source, "license")

end

function GetSourceFromIdentifier(identifier)

    local players = GetPlayers()

    for i = 1, #players do

        if GetPlayerIdentifierByType(players[i], "license") == identifier then

            return players[i]

        end

    end

end

function HasItem(source, itemName)

    if GetResourceState("ox_inventory") == "started" then

        return (exports.ox_inventory:Search(source, "count", Config.Item.Name) or 0) > 0

    end

    return true

end

function GetCharacterName(source)

    return GetPlayerName(source), ""

end
