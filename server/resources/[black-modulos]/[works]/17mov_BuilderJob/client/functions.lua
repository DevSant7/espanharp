local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")

-- Notificação padrão
RegisterNetEvent('17mov_DrawDefaultNotification'..GetCurrentResourceName(), function(msg)
    Notify(msg)
end)

-- Dados do jogador
function GetPlayerData()
    return { job = { name = "unknown", grade = 0 } }
end

-- Deletar veículo
function DeleteVehicleByCore(vehicle)
    SetEntityAsMissionEntity(vehicle, false, true)
    DeleteVehicle(vehicle)
end

-- Notificações
function Notify(msg)
    if Config.UseBuiltInNotifications and Config.useModernUI then
        local type = CheckIfNotificationIsWrong(msg) and "wrong" or "good"
        SendNUIMessage({
            action = "showNotification",
            type = type,
            msg = msg
        })
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

-- Config real de roupas
Config.realClothes = {
    male = {},
    female = {},
}

local componentIdTranslation = {
    ["mask"] = 1,
    ["arms"] = 3,
    ["pants"] = 4,
    ["bag"] = 5,
    ["shoes"] = 6,
    ["t-shirt"] = 8,
    ["torso"] = 11,
    ["decals"] = 10,
    ["kevlar"] = 9,
}

for k,v in pairs(Config.Clothes.male) do
    table.insert(Config.realClothes.male, {component_id = componentIdTranslation[k], drawable = v.clotheId, texture = v.variation})
end

for k,v in pairs(Config.Clothes.female) do
    table.insert(Config.realClothes.female, {component_id = componentIdTranslation[k], drawable = v.clotheId, texture = v.variation})
end

-- Setar veículo e aplicar fuel + chaves
local model, plate, vehicle
function SetVehicle(_vehicle)
    vehicle = _vehicle
    model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    plate = GetVehicleNumberPlateText(vehicle)

    TriggerServerEvent("plateEveryone", plate)
    TriggerServerEvent("engine:tryFuel", plate, 100)

    TriggerEvent('cd_garage:AddKeys', plate)
    TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)

    -- Combustível (vários suportes)
    if GetResourceState("LegacyFuel") == "started" then
        exports["LegacyFuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("cdn-fuel") == "started" then
        exports["cdn-fuel"]:SetFuel(vehicle, 100.0)
    elseif GetResourceState("ps-fuel") == "started" then
        exports["ps-fuel"]:SetFuel(vehicle, 100.0)
    end

    Entity(vehicle).state.fuel = 100.0
end

function RemoveKeys()
    if GetResourceState("qs-vehiclekeys") == "started" then
        exports["qs-vehiclekeys"]:RemoveKeys(plate, model)
    end
end

function PrepeareVehicle()
    -- lógica antes de spawnar o veículo, se quiser
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 500
    DrawRect(_x, _y + 0.0125, 0.030 + factor, 0.03, 0, 0, 0, 150)
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

function ChangeClothes(type)
    local playerPed = PlayerPedId()
    local model = GetEntityModel(playerPed)
    local outfitData = {}

    if type == "work" then
        local clothes = (model == 1885233650) and Config.Clothes.male or Config.Clothes.female
        for item, data in pairs(clothes) do
            outfitData[item] = { clotheId = data.clotheId, variation = data.variation }
        end
        TriggerEvent("skinshop:apply", outfitData)
    else
        -- lógica para retornar à roupa original
    end
end

function CheckIfNotificationIsWrong(text)
    local arrayName
    for k,v in pairs(Config.Lang) do
        if v == text then
            arrayName = k
            break
        end
    end
    return Config.WrongNotifications[arrayName] or false
end

Config.WrongNotifications = {
    ["no_permission"] = true,
    ["too_far"] = true,
    ["alreadyWorking"] = true,
    ["wrongCar"] = true,
    ["CarNeeded"] = true,
    ["nobodyNearby"] = true,
    ["cantInvite"] = true,
    ["spawnpointOccupied"] = true,
    ["pipesNotReady"] = true,
    ["workstationOccupied"] = true,
    ["notFullJob"] = true,
    ["notADriver"] = true,
    ["partyIsFull"] = true,
    ["wrongReward1"] = true,
    ["wrongReward2"] = true,
    ["isAlreadyHost"] = true,
    ["isBusy"] = true,
    ["hasActiveInvite"] = true,
    ["HaveActiveInvite"] = true,
    ["InviteDeclined"] = true,
    ["error"] = true,
    ["kickedOut"] = true,
    ["RequireOneFriend"] = true,
    ["clientsPenalty"] = true,
    ["noMixerStatus"] = true,
    ["dontHaveReqItem"] = true,
    ["notEverybodyHasRequiredJob"] = true,
}
