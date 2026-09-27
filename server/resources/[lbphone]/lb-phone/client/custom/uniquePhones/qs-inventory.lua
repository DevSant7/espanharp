if Config.Item.Inventory ~= "qs-inventory" or not Config.Item.Unique or not Config.Item.Require then

    return

end

local function GetItemsByName(name)

    local inventory = (ESX and ESX.GetPlayerData().inventory) or (QB and QB.Functions.GetPlayerData().items) or {}

    local items = {}

    for _, item in pairs(inventory) do

        if item?.name == name then

            items[#items+1] = item

        end

    end

    return items

end

function GetFirstNumber()

    local phones = GetItemsByName(Config.Item.Name)

    for i = 1, #phones do

        local phone = phones[i]

        if phone?.info?.lbPhoneNumber then

            return phone.info.lbPhoneNumber

        end

    end

end

function HasPhoneNumber(number)

    local phones = GetItemsByName(Config.Item.Name)

    for i = 1, #phones do

        local phone = phones[i]

        if phone?.info?.lbPhoneNumber == number then

            return true

        end

    end

    return false

end

RegisterNetEvent("lb-phone:usePhoneItem", function(data)

    local number = data.info?.lbPhoneNumber

    if number ~= currentPhone or number == nil then

        SetPhone(number, true)

    end

    ToggleOpen(not phoneOpen)

end)

local waitingAdded = false

local function UpdatePhoneAfterInventoryUpdate()

    Wait(500)

    if currentPhone and not HasPhoneItem(currentPhone) then

        SetPhone()

    end

    if currentPhone or waitingAdded then

        return

    end

    while exports["qs-inventory"]:inInventory() do

        Wait(0)

    end

    Wait(1000)

    local firstNumber = GetFirstNumber()

    if firstNumber and not waitingAdded then

        waitingAdded = true

        SetPhone(firstNumber, true)

        waitingAdded = false

    end

end

RegisterNetEvent("QBCore:Player:SetPlayerData", function(newData)

    UpdatePhoneAfterInventoryUpdate()

end)

RegisterNetEvent("esx:removeInventoryItem", function(item)

    if item == Config.Item.Name then

        UpdatePhoneAfterInventoryUpdate()

    end

end)

RegisterNetEvent("esx:addInventoryItem", function(item)

    if item == Config.Item.Name then

        UpdatePhoneAfterInventoryUpdate()

    end

end)