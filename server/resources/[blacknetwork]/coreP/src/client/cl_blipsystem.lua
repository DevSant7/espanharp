-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
local userBlips = {}

local vehicleTeams = {
    [GetHashKey("BluM5")] = "RPM",
    [GetHashKey("BluM140")] = "RPM",
    [GetHashKey("BluGS350")] = "RPM",
    [GetHashKey("BluTesla")] = "RPM",
    [GetHashKey("BluM4c")] = "RPM",
    [GetHashKey("BluGT86")] = "RPM",

    [GetHashKey("BluTundra")] = "CORE",
    [GetHashKey("BluAmarok")] = "CORE",

    [GetHashKey("BluR1200")] = "GTM",
    [GetHashKey("BluTiger")] = "GTM",

    [GetHashKey("Blu412")] = "GAEP",
    [GetHashKey("BluMd500")] = "GAEP",

    [GetHashKey("BluQuattroporte")] = "CMD",
    [GetHashKey("BluX6m")] = "CMD"
}

-- Variável para rastrear o estado atual do blip do jogador local
local currentBlipVehicleTeam = "onfoot" -- Pode ser "onfoot", "GTM", "GAEP", "RPM", "CORE", "CMD"
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:UPDATEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:updateBlips")
AddEventHandler("blipsystem:updateBlips",function(userTable)
    userList = userTable

    for k,v in pairs(userList) do
        local blipX, blipY, blipZ = v[1]["x"],v[1]["y"],v[1]["z"]
        local blipName = v[2] 
        local blipColor = v[3] 
        local vehicleTeam = v[4] 


        if DoesBlipExist(userBlips[k]) then
            SetBlipCoords(userBlips[k], blipX, blipY, blipZ)
        else
            userBlips[k] = AddBlipForCoord(blipX, blipY, blipZ)
            SetBlipAsShortRange(userBlips[k],true)
            SetBlipScale(userBlips[k],0.7)
            SetBlipColour(userBlips[k], blipColor)
        end

        if vehicleTeam == "GTM" then
            SetBlipSprite(userBlips[k], 226) 
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("GTM")
            EndTextCommandSetBlipName(userBlips[k])
        elseif vehicleTeam == "GAEP" then
            SetBlipSprite(userBlips[k], 43) 
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("GAEP")
            EndTextCommandSetBlipName(userBlips[k])
        elseif vehicleTeam == "RPM" or vehicleTeam == "CORE" or vehicleTeam == "CMD" then
            SetBlipSprite(userBlips[k], 225) 
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(vehicleTeam)
            EndTextCommandSetBlipName(userBlips[k])
        else 
            SetBlipSprite(userBlips[k], 1) 
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipName) 
            EndTextCommandSetBlipName(userBlips[k])
        end

        SetBlipColour(userBlips[k], blipColor)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:cleanBlips")
AddEventHandler("blipsystem:cleanBlips",function()
    for k,v in pairs(userBlips) do
        RemoveBlip(v)
    end
    userBlips = {}
    userList = {}
    currentBlipVehicleTeam = "onfoot" 
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPSYSTEM:REMOVEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("blipsystem:removeBlips")
AddEventHandler("blipsystem:removeBlips",function(source)
    if DoesBlipExist(userBlips[source]) then
        RemoveBlip(userBlips[source])
        userBlips[source] = nil
        userList[source] = nil
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD PARA DETECTAR VEÍCULO E REPORTAR AO SERVIDOR
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local newVehicleTeam = "onfoot" 

        if IsPedInAnyVehicle(playerPed, false) then
            local veh = GetVehiclePedIsIn(playerPed, false)
            local model = GetEntityModel(veh)
            local team = vehicleTeams[model]

            if team then
                newVehicleTeam = team 
            end
        end

        if newVehicleTeam ~= currentBlipVehicleTeam then
            TriggerServerEvent("blipsystem:updateVehicleStatus", newVehicleTeam)
            currentBlipVehicleTeam = newVehicleTeam
        end

        Wait(1000) 
    end
end)