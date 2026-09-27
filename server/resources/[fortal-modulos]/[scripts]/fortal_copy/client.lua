local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")

-- Componentes visuais (roupas)
local componentMap = {
    ["mask"] = 1,
    ["arms"] = 3,
    ["tshirt"] = 8,
    ["torso"] = 11, -- ✅ Corrigido para aplicar jaqueta corretamente
    ["pants"] = 4,
    ["shoes"] = 6,
    ["decals"] = 10,
    ["vest"] = 9,
    ["accessory"] = 7,
    ["backpack"] = 5
}


-- Props (acessórios removíveis)
local propMap = {
    ["hat"] = 0,
    ["glass"] = 1,
    ["ear"] = 2,
    ["watch"] = 6,
    ["bracelet"] = 7
}

RegisterCommand("copiar", function(_, args)
    local targetUserId = tonumber(args[1])
    local genderArg = args[2] and string.lower(args[2])

    if not targetUserId then
        return
    end

    TriggerServerEvent("copiar_skin:requestData", targetUserId, genderArg)
end)

RegisterNetEvent("copiar_skin:applyCustomization")
AddEventHandler("copiar_skin:applyCustomization", function(data)
    if not data or not data.model or not data.clothings then
        return
    end

    local hash = GetHashKey(data.model)
    RequestModel(hash)
    local start = GetGameTimer()
    while not HasModelLoaded(hash) do
        if GetGameTimer() - start > 5000 then
            return
        end
        Wait(10)
    end

    SetPlayerModel(PlayerId(), hash)
    SetModelAsNoLongerNeeded(hash)
    Wait(1000)

    local ped = PlayerPedId()

    -- Aplicar componentes
    for partName, compId in pairs(componentMap) do
        local partData = data.clothings[partName]
        if partData then
            local drawable = partData.item or 0
            local texture = partData.texture or 0
            local palette = partData.palette or 0

            if IsPedComponentVariationValid(ped, compId, drawable, texture) then
                SetPedComponentVariation(ped, compId, drawable, texture, palette)
            end
        end
    end

    for propName, propId in pairs(propMap) do
        local propData = data.clothings[propName]
        if propData then
            local drawable = propData.item or -1
            local texture = propData.texture or 0
            if drawable ~= -1 then
                SetPedPropIndex(ped, propId, drawable, texture, true)
            else
                ClearPedProp(ped, propId)
            end
        end
    end

    -- Aplicar face
    if data.face then
        TriggerServerEvent("fortal-character:Server:Barbershop:Save", nil, data.face)
    end

    -- Aplicar tatuagens
    if data.tattoos then
        TriggerServerEvent("fortal-character:Server:Tattooshop:Save", nil, data.tattoos)
    end
end)
