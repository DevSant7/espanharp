local Tunnel = module("vrp", "lib/Tunnel")
serverAPI = Tunnel.getInterface("homes-creative")

RegisterNetEvent("homes:receiveInformations", function(data)
    Informations = data
end)

RegisterNuiCallback("close", function(cb)
    SetNuiFocus(false, false)
end)

--[[ RegisterNetEvent("fx:initHomes")
AddEventHandler("fx:initHomes", function(v, Name)
    local shouldMultiply = Mansions[Name] ~= nil
    local multiplier = shouldMultiply and Mansions[Name].multiplier or 1
    local interiorTarget = "Emerald"

    for k, info in pairs(Informations) do
        if info["OriginalPrice"] and info["OriginalSellPrice"] then
            info["Price"] = info["OriginalPrice"]
            info["SellPrice"] = info["OriginalSellPrice"]
        else
            info["OriginalPrice"] = info["Price"]
            info["OriginalSellPrice"] = info["SellPrice"]
        end

        info["name"] = Name

        if shouldMultiply then
            info["Price"] = info["OriginalPrice"] * multiplier
            info["SellPrice"] = info["OriginalSellPrice"] * multiplier
        end
    end

    print('depois de tudo pra ver o informations', json.encode(Informations))

    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open", data = true })
    SendNUIMessage({ action = "interior", data = interiors })
    SendNUIMessage({ action = "img", data = imgs })
    SendNUIMessage({ action = "homeFy", data = Informations })
end) ]]

RegisterNetEvent("fx:initHomes")
AddEventHandler("fx:initHomes", function(v, Name)
    local shouldMultiply = Mansions[Name] ~= nil
    local multiplier = shouldMultiply and Mansions[Name].multiplier or 1

    local filteredInformations = {}
    local filteredInteriors = {}

    for k, info in pairs(Informations) do
        local include = true

        if shouldMultiply then
            include = false
            for key, allowedInterior in pairs(Mansions[Name].interiors) do
                if k == key then
                    include = true
                    break
                end
            end
        end

        if include then
            local clonedInfo = {
                Garagem = info.Garagem,
                Vault = info.Vault,
                Fridge = info.Fridge,
                OriginalPrice = info.OriginalPrice or info.Price,
                OriginalSellPrice = info.OriginalSellPrice or info.SellPrice,
                name = Name
            }

            clonedInfo.Price = clonedInfo.OriginalPrice
            clonedInfo.SellPrice = clonedInfo.OriginalSellPrice

            if shouldMultiply then
                clonedInfo.Price = clonedInfo.OriginalPrice * multiplier
                clonedInfo.SellPrice = clonedInfo.OriginalSellPrice * multiplier
            end

            filteredInformations[k] = clonedInfo
        end
    end

    for k, interiorData in pairs(interiors) do
        local include = true

        if shouldMultiply then
            include = false
            for key2, allowedInterior in pairs(Mansions[Name].interiors) do
                if interiorData == key2 then
                    include = true
                    break
                end
            end
        end

        if include then
            table.insert(filteredInteriors, interiorData)
        end
    end

    SetNuiFocus(true, true)
    SendNUIMessage({ action = "open", data = true })
    SendNUIMessage({ action = "interior", data = filteredInteriors })
    SendNUIMessage({ action = "img", data = imgs })
    SendNUIMessage({ action = "homeFy", data = filteredInformations })
end)

RegisterNuiCallback("payment", function(data, _)
    TriggerServerEvent("propertys:Buy", data["Name"])
end)
