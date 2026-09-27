if (Config.Item.Inventory ~= "qb-inventory" and Config.Item.Inventory ~= "lj-inventory") or not Config.Item.Unique or not Config.Item.Require then

    return

end

local usedPhoneSlots = {}

local function GetPhonesInInventory(source)

    local phones = {}

    local items = QB.Functions.GetPlayer(source).PlayerData.items

    for _, item in pairs(items) do

        if IsItemAPhone(item.name) then

            phones[#phones+1] = item

        end

    end

    return phones

end

function HasPhoneNumber(source, phoneNumber)

    debugprint("checking if " .. source .. " has a phone item with number", phoneNumber)

    local phones = GetPhonesInInventory(source)

    for i = 1, #phones do

        local phone = phones[i]

        if phone?.info?.lbPhoneNumber == phoneNumber then

            debugprint("they do")

            return true

        end

    end

    debugprint("they do not")

    return false

end

function SetPhoneNumber(source, phoneNumber)

    local qPlayer = QB.Functions.GetPlayer(source)

    local items = qPlayer.PlayerData.items

    local slot = usedPhoneSlots[source]

    if slot then

        debugprint("Used slot:", slot)

        for _, item in pairs(items) do

            if item and IsItemAPhone(item.name) and item.info.lbPhoneNumber == nil and item.slot == slot then

                item.info.lbPhoneNumber = phoneNumber

                item.info.lbFormattedNumber = FormatNumber(phoneNumber)

                qPlayer.Functions.SetInventory(items, true)

                return true

            end

        end

    end

    for _, item in pairs(items) do

        if item and IsItemAPhone(item.name) and item.info.lbPhoneNumber == nil then

            item.info.lbPhoneNumber = phoneNumber

            item.info.lbFormattedNumber = FormatNumber(phoneNumber)

            qPlayer.Functions.SetInventory(items, true)

            return true

        end

    end

    return false

end

function SetItemName(source, phoneNumber, name)

    local qPlayer = QB.Functions.GetPlayer(source)

    local items = qPlayer.PlayerData.items

    for _, item in pairs(items) do

        if item and IsItemAPhone(item.name) and item.info.lbPhoneNumber == phoneNumber then

            item.info.lbPhoneName = name

            item.info.lbFormattedNumber = FormatNumber(phoneNumber)

            qPlayer.Functions.SetInventory(items, true)

            return true

        end

    end

end

local itemNames = {}

if Config.Item.Name then

    itemNames[#itemNames+1] = Config.Item.Name

end

if Config.Item.Names then

    for i = 1, #Config.Item.Names do

        itemNames[#itemNames+1] = Config.Item.Names[i].name

    end

end

for i = 1, #itemNames do

    QB.Functions.CreateUseableItem(itemNames[i], function(source, item)

        local slot = item.slot

        TriggerClientEvent("lb-phone:usePhoneItem", source, item)

        usedPhoneSlots[source] = slot

        SetTimeout(10000, function()

            if usedPhoneSlots[source] == slot then

                usedPhoneSlots[source] = nil

            end

        end)

    end)

end
