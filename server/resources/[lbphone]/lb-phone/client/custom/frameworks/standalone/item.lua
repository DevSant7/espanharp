if Config.Framework ~= "standalone" then

    return

end

function HasItem(itemName)

    if GetResourceState("ox_inventory") == "started" then

        return (exports.ox_inventory:Search("count", itemName) or 0) > 0

    end

    return true

end