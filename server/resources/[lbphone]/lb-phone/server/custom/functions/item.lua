local phoneItemNames = {}

if Config.Item.Name then

    phoneItemNames[Config.Item.Name] = true

end

if Config.Item.Names then

    for i = 1, #Config.Item.Names do

        phoneItemNames[Config.Item.Names[i].name] = true

    end

end

function IsItemAPhone(itemName)

    return phoneItemNames[itemName] or false

end

function HasPhoneItem(source, phoneNumber)

    if not Config.Item.Require then

        return true

    end

    if Config.Item.Unique then

        return HasPhoneNumber(source, phoneNumber)

    end

    local hasItem = false

    if Config.Item.Name then

        hasItem = HasItem(source, Config.Item.Name)

    elseif Config.Item.Names then

        for i = 1, #Config.Item.Names do

            if HasItem(source, Config.Item.Names[i].name) then

                hasItem = true

                break

            end

        end

    end

    if not hasItem then

        return false

    end

    if not phoneNumber then

        return hasItem

    end

    local equippedNumber = GetEquippedPhoneNumber(source)

    if equippedNumber then

        return equippedNumber == phoneNumber

    end

    return MySQL.scalar.await(

        "SELECT 1 FROM phone_phones WHERE id = ? AND phone_number = ?",

        { GetIdentifier(source), phoneNumber }

    ) ~= nil

end

exports("HasPhoneItem", HasPhoneItem)
