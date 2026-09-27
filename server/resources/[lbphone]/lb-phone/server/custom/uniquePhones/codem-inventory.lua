if Config.Item.Inventory ~= "codem-inventory" or not Config.Item.Unique or not Config.Item.Require then

    return

end

local function GetItemsByName(source, name)

    local inventory = exports["codem-inventory"]:GetInventory(false, source)

    local items = {}

    for _, item in pairs(inventory) do

        if item?.name == name then

            items[#items + 1] = item

        end

    end

    return items

end

function HasPhoneNumber(source, phoneNumber)

    debugprint("checking if " .. source .. " has a phone item with number", phoneNumber)

    local phones = GetItemsByName(source, Config.Item.Name)

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

    local items = exports["codem-inventory"]:GetInventory(false, source)

    for k, v in pairs(items) do

        local item = v

        if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == nil then

            item.info.lbPhoneNumber = phoneNumber

            item.info.lbFormattedNumber = FormatNumber(phoneNumber)

            qPlayer.Functions.SetInventory(items)

            return true

        end

    end

    return false

end

function SetItemName(source, phoneNumber, name)

    local qPlayer = QB.Functions.GetPlayer(source)

    local items = exports["codem-inventory"]:GetInventory(false, source)

    for k, v in pairs(items) do

        local item = v

        if item and item.name == Config.Item.Name and item.info.lbPhoneNumber == phoneNumber then

            item.info.lbPhoneName = name

            item.info.lbFormattedNumber = FormatNumber(phoneNumber)

            qPlayer.Functions.SetInventory(items)

            return true

        end

    end

end

QB.Functions.CreateUseableItem(Config.Item.Name, function(source, item)

    if item then

        TriggerClientEvent("lb-phone:usePhoneItem", source, item)

    end

end)
