local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

vRP = Proxy.getInterface("vRP")
vServer = Tunnel.getInterface("fortal-dealership-server")

local Inside = false
local Camera = nil
local Vehicle = nil
local Heading = nil
local ShowIndex = nil
local FadedVehicles = {}
local TractionCache = {}

-- Test Drive Variables
local TestDriveActive = false
local TestDriveVehicle = nil
local OriginalCoords = nil
local TestDriveStartTime = 0
local TestDriveDuration = 120
local TestDriveVehicleName = ""
local TestDriveDealershipType = "normal"
local TestDriveDimension = 1000
local OriginalRoutingBucket = nil

-- Cache para melhor performance
local VehiclesProcessed = false
local ProcessedVehicles = {}

-- Variável para armazenar o tipo de concessionária atual
local CurrentDealershipType = "normal"

-- Variável para controlar o spawn de veículos
local IsSpawningVehicle = false

-- Verificar se routing buckets estão disponíveis
local function HasRoutingBuckets()
    return SetPlayerRoutingBucket ~= nil and SetEntityRoutingBucket ~= nil
end

-- Função para definir dimensão do player
local function SetPlayerDimension(playerId, dimension)
    if HasRoutingBuckets() then
        SetPlayerRoutingBucket(playerId, dimension)
        return true
    end
    return false
end

-- Função para definir dimensão da entidade
local function SetEntityDimension(entity, dimension)
    if HasRoutingBuckets() then
        SetEntityRoutingBucket(entity, dimension)
        return true
    end
    return false
end

function SetVehicle(_vehicle)
    local vehicle = _vehicle
    local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    local plate = GetVehicleNumberPlateText(vehicle)

    TriggerServerEvent("plateEveryone", plate)
    TriggerServerEvent("engine:tryFuel", plate, 100)

    TriggerEvent('cd_garage:AddKeys', plate)
    TriggerServerEvent("vehicles_keys:selfGiveVehicleKeys", plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
end

function GetForwardCoords(data)   
    local x = data.coords.x + data.distance * math.sin(-data.heading * math.pi / 180.0)
    local y = data.coords.y + data.distance * math.cos(-data.heading * math.pi / 180.0)

    return vector3(x, y, data.coords.z)
end

function GetTractionFromModel(vehicleName)
    local modelHash = GetHashKey(vehicleName)
    
    RequestModel(modelHash)
    local timeout = 0
    while not HasModelLoaded(modelHash) and timeout < 5000 do
        Wait(10)
        timeout = timeout + 10
    end

    if not HasModelLoaded(modelHash) then
        return 1.0
    end

    local vehicle = CreateVehicle(modelHash, 0.0, 0.0, -100.0, 0.0, false, false)

    timeout = 0
    while not DoesEntityExist(vehicle) and timeout < 1000 do
        Wait(10)
        timeout = timeout + 10
    end

    local traction = 1.0
    if DoesEntityExist(vehicle) then
        traction = GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront")
        DeleteEntity(vehicle)
    end

    SetModelAsNoLongerNeeded(modelHash)
    return traction
end

function GetTractionCached(vehicleName)
    if TractionCache[vehicleName] then
        return TractionCache[vehicleName]
    end

    local traction = GetTractionFromModel(vehicleName)
    TractionCache[vehicleName] = traction
    return traction
end

function ProcessVehicleStats(vehicles, categorysMaxStats)
    CreateThread(function()
        for index, vehicle in pairs(vehicles) do
            if not ProcessedVehicles[vehicle.spawn] then
                local vehicleModel = GetHashKey(vehicle.spawn)
                local vehicleTraction = GetTractionCached(vehicle.spawn)
                local vehicleSpeed = math.floor(GetVehicleModelEstimatedMaxSpeed(vehicleModel) * 3.6)
                local vehicleAcceleration = math.floor(GetVehicleModelAcceleration(vehicleModel) * 100.0)

                local traction = "dianteira"

                if vehicleTraction < 1.0 then
                    if vehicleTraction >= 0.5 then
                        traction = "4x4"
                    else
                        traction = "traseira"
                    end
                end

                local normalizedSpeed = 1
                local normalizedAccel = 1
                
                if categorysMaxStats[vehicle.section] and categorysMaxStats[vehicle.section].speed > 0 then
                    normalizedSpeed = math.floor((vehicleSpeed / categorysMaxStats[vehicle.section].speed) * 5)
                end
                
                if categorysMaxStats[vehicle.section] and categorysMaxStats[vehicle.section].acceleration > 0 then
                    normalizedAccel = math.floor((vehicleAcceleration / categorysMaxStats[vehicle.section].acceleration) * 5)
                end

                normalizedSpeed = math.max(1, math.min(5, normalizedSpeed))
                normalizedAccel = math.max(1, math.min(5, normalizedAccel))

                vehicles[index].rate = math.floor((normalizedSpeed + normalizedAccel) / 2)

                vehicles[index].stats = {            
                    maxSpeed = {vehicleSpeed, categorysMaxStats[vehicle.section] and categorysMaxStats[vehicle.section].speed or vehicleSpeed},
                    acceleration = {vehicleAcceleration, categorysMaxStats[vehicle.section] and categorysMaxStats[vehicle.section].acceleration or vehicleAcceleration},
                    wheeling = traction,
                    trunk = vehicle.stats and vehicle.stats.trunk or {30, 60}
                }

                ProcessedVehicles[vehicle.spawn] = vehicles[index]
                
                if index % 5 == 0 then
                    Wait(0)
                end
            else
                vehicles[index] = ProcessedVehicles[vehicle.spawn]
            end
        end
        
        VehiclesProcessed = true
    end)
end

function GetFormatedVehicles(category)
    local categorysMaxStats = {}

    local allowedTypes = {}
    if CurrentDealershipType == "vip" then
        allowedTypes = Config.DealershipTypes.vip
    else
        allowedTypes = Config.DealershipTypes.normal
    end

    for _,categoryType in ipairs(allowedTypes) do
        categorysMaxStats[categoryType] = {
            speed = 0,
            acceleration = 0,
        }
    end

    if not category then
        category = allowedTypes[1] or "comum"
    end

    if not VehiclesProcessed then
        for _, vehicle in ipairs(Config.Vehicles) do
            if vehicle.section == category and categorysMaxStats[vehicle.section] then
                local vehicleModel = GetHashKey(vehicle.spawn)
                local vehicleSpeed = math.floor(GetVehicleModelEstimatedMaxSpeed(vehicleModel) * 3.6)
                local vehicleAcceleration = math.floor(GetVehicleModelAcceleration(vehicleModel) * 100.0)

                if vehicleSpeed > categorysMaxStats[vehicle.section].speed then
                    categorysMaxStats[vehicle.section].speed = vehicleSpeed
                end
                
                if vehicleAcceleration > categorysMaxStats[vehicle.section].acceleration then
                    categorysMaxStats[vehicle.section].acceleration = vehicleAcceleration
                end
            end
        end
    end

    local vehicles = vServer.GetVehicles(category)
    
    if not vehicles or type(vehicles) ~= "table" then
        return {}
    end

    if not VehiclesProcessed then
        ProcessVehicleStats(vehicles, categorysMaxStats)
    else
        for index, vehicle in pairs(vehicles) do
            if ProcessedVehicles[vehicle.spawn] then
                vehicles[index].rate = ProcessedVehicles[vehicle.spawn].rate
                vehicles[index].stats = ProcessedVehicles[vehicle.spawn].stats
            end
        end
    end

    return vehicles
end

function CleanupShowroomVehicles()
    if ShowIndex then
        local showCoords = Config.Show.Coords[ShowIndex]
        local vehicles = GetGamePool("CVehicle")
        
        for _, vehicle in ipairs(vehicles) do
            if vehicle ~= Vehicle then
                local vehicleCoords = GetEntityCoords(vehicle)
                local distance = #(vec3(showCoords.x, showCoords.y, showCoords.z) - vehicleCoords)
                
                if distance < 5.0 then
                    DeleteEntity(vehicle)
                end
            end
        end
    end
end

function CleanupTestDrive()
    if TestDriveVehicle and DoesEntityExist(TestDriveVehicle) then
        DeleteEntity(TestDriveVehicle)
        TestDriveVehicle = nil
    end
    
    TestDriveActive = false
    TestDriveStartTime = 0
    TestDriveVehicleName = ""
    TestDriveDealershipType = "normal"
    
    -- Restaurar dimensão original se disponível
    if HasRoutingBuckets() and OriginalRoutingBucket then
        SetPlayerRoutingBucket(PlayerId(), OriginalRoutingBucket)
        OriginalRoutingBucket = nil
    end
    
    SendNUIMessage({
        action = "updateTestDrive",
        data = {
            active = false,
            timeRemaining = 0,
            vehicleName = "",
            dealershipType = "normal"
        }
    })
end

-- Função para atualizar timer do test drive (chamada por evento)
function UpdateTestDriveTimer()
    if TestDriveActive then
        local currentTime = GetGameTimer()
        local elapsedTime = math.floor((currentTime - TestDriveStartTime) / 1000)
        local timeRemaining = math.max(0, TestDriveDuration - elapsedTime)
        
        SendNUIMessage({
            action = "updateTestDrive",
            data = {
                active = true,
                timeRemaining = timeRemaining,
                vehicleName = TestDriveVehicleName,
                dealershipType = TestDriveDealershipType
            }
        })
        
        if timeRemaining <= 0 then
            TriggerEvent("fortal-dealership:Client:EndTestDrive")
            TriggerEvent("fortal-dealership:Client:Notify", "Test Drive", "Tempo do test drive esgotado!", 5000)
        end
    end
end

-- Event handler para verificar se saiu do veículo - MELHORADO
AddEventHandler('gameEventTriggered', function(name, args)
    if name == 'CEventNetworkPlayerLeftVehicle' then
        if TestDriveActive and TestDriveVehicle then
            local playerPed = PlayerPedId()
            local vehicleLeft = args[2] -- Veículo que foi deixado
            
            -- Verificar se é o veículo de test drive
            if vehicleLeft == TestDriveVehicle then
                SetTimeout(500, function() -- Delay maior para garantir que saiu mesmo
                    local currentVehicle = GetVehiclePedIsIn(playerPed, false)
                    
                    -- Se não está mais no veículo de test drive, encerrar
                    if currentVehicle ~= TestDriveVehicle then
                        TriggerEvent("fortal-dealership:Client:EndTestDrive")
                        TriggerEvent("fortal-dealership:Client:Notify", "Test Drive", "Test drive finalizado - você saiu do veículo.", 3000)
                    end
                end)
            end
        end
    end
end)

-- Verificação adicional por thread leve apenas para saída do veículo
CreateThread(function()
    while true do
        local sleep = 2000 -- Verificar a cada 2 segundos
        
        if TestDriveActive and TestDriveVehicle and DoesEntityExist(TestDriveVehicle) then
            sleep = 1000 -- Verificar mais frequentemente durante test drive
            
            local playerPed = PlayerPedId()
            local currentVehicle = GetVehiclePedIsIn(playerPed, false)
            
            -- Se não está no veículo de test drive
            if currentVehicle ~= TestDriveVehicle then
                -- Verificar se está realmente fora (não apenas mudando de assento)
                local isInAnyVehicle = IsPedInAnyVehicle(playerPed, false)
                local isInTestDriveVehicle = IsPedInVehicle(playerPed, TestDriveVehicle, false)
                
                if not isInTestDriveVehicle then
                    TriggerEvent("fortal-dealership:Client:EndTestDrive")
                    TriggerEvent("fortal-dealership:Client:Notify", "Test Drive", "Test drive finalizado - você saiu do veículo.", 3000)
                end
            end
        end
        
        Wait(sleep)
    end
end)

CreateThread(function()
    Wait(3000)

    SendNUIMessage({
        action = "setColor",
        data = Config.Color[1]..","..Config.Color[2]..","..Config.Color[3]
    })

    for k,v in pairs(Config.Peds) do
        local modelHash = GetHashKey(v.Model)

        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Wait(10)
        end

        local ped = CreatePed(4, modelHash, v.Coords.x, v.Coords.y, v.Coords.z - 1, v.Coords.h, false, false)
        SetPedArmour(ped, 100)
        SetEntityInvincible(ped, true)
        FreezeEntityPosition(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)      
        SetModelAsNoLongerNeeded(modelHash)

        if v.Anim then
        	RequestAnimDict(v.Anim.dict)
        	while not HasAnimDictLoaded(v.Anim.dict) do
        		Wait(10)
            end
            
        	TaskPlayAnim(ped, v.Anim.dict, v.Anim.set, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
        end
    end

    for k,v in pairs(Config.Peds) do
        exports["target"]:AddCircleZone("Dealership_"..k, vec3(v.Coords.x, v.Coords.y, v.Coords.z), 2.0, {
            name = "Dealership_"..k,
            heading = v.Coords.h
        }, {
            distance = 2.5,
            options = {
                {
                    event = "fortal-dealership:Client:Open",
                    label = v.Type == "vip" and "Abrir Concessionária VIP" or "Abrir Concessionária",
                    tunnel = "client"
                },
                {
                    event = "fortalvendas:openUI",
                    label = "Vender Veículos",
                    tunnel = "client"
                }
            }
        })
    end
end)

CreateThread(function()
    while true do
        local timestamp = 1000

        if Inside then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local closestToDealership = false

            timestamp = 0

            for id = 0, 256 do
				if id ~= PlayerId() and NetworkIsPlayerActive(id) then
					NetworkFadeOutEntity(GetPlayerPed(id), false)
				end
			end

            local vehicles = GetGamePool("CVehicle")

            for _, vehicle in ipairs(vehicles) do
                if vehicle ~= Vehicle then
                    local vehicleCoords = GetEntityCoords(vehicle)
                    local distance = #(playerCoords - vehicleCoords)
    
                    if distance <= 50.0 then
					    NetworkFadeOutEntity(vehicle, false)
                        FadedVehicles[vehicle] = true
                    end
                end
            end

            for k,v in pairs(Config.Peds) do
                local coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z)
                local distance = #(playerCoords - coords)

                if distance < 10.0 then
                   closestToDealership = true 
                end
            end

            if not closestToDealership or GetEntityHealth(playerPed) <= 101 then
                TriggerEvent("fortal-dealership:Client:Close")
            end
        end

        Wait(timestamp)
    end
end)

RegisterNetEvent("fortal-dealership:Client:Open", function()
    if TestDriveActive then
        TriggerEvent("fortal-dealership:Client:Notify", "Negado", "Você não pode abrir a concessionária durante um test drive.", 5000)
        return
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    for k,v in pairs(Config.Peds) do
        local coords = vec3(v.Coords.x, v.Coords.y, v.Coords.z)
        local distance = #(playerCoords - coords)
        
        if distance <= 10.0 then
            ShowIndex = k
            CurrentDealershipType = v.Type or "normal"
            vServer.SetDealershipType(CurrentDealershipType)
            break
        end
    end

    if ShowIndex then
        CleanupShowroomVehicles()
        
        local showCoords = GetForwardCoords({
            coords = Config.Show.Coords[ShowIndex],
            heading = Config.Show.Coords[ShowIndex].h,
            distance = 5.0
        })

        FadedVehicles = {}
        Inside = true
        Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        SetCamCoord(Camera, showCoords.x, showCoords.y, showCoords.z + 1.7)
        PointCamAtCoord(Camera, Config.Show.Coords[ShowIndex].x, Config.Show.Coords[ShowIndex].y, Config.Show.Coords[ShowIndex].z - 0.5)
        RenderScriptCams(true, true, 500, true)
    
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "setVisibility",
            data = true
        })
    
        TriggerEvent("hud:actions", false)
    end
end)

RegisterNetEvent("fortal-dealership:Client:Close", function()
    local playerPed = PlayerPedId()

    if Vehicle then
        DeleteEntity(Vehicle)
        Vehicle = nil
    end

    CleanupShowroomVehicles()

    RenderScriptCams(false, true, 500, true)
    SetCamActive(Camera, false)
    DestroyCam(Camera)
    Camera = nil

    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "setVisibility",
        data = false
    })

	TriggerEvent("hud:actions", true)

    for vehicle,_ in pairs(FadedVehicles) do
        if DoesEntityExist(vehicle) then
            NetworkFadeInEntity(vehicle, true)
        end
    end

    Inside = false
    ShowIndex = nil
    CurrentDealershipType = "normal"
    IsSpawningVehicle = false
end)

-- Melhorar a thread do timer no RegisterNetEvent StartTestDrive
RegisterNetEvent("fortal-dealership:Client:StartTestDrive", function(vehicleSpawn, vehicleData, vehicleName, duration)
    local playerPed = PlayerPedId()
    
    OriginalCoords = GetEntityCoords(playerPed)
    TriggerEvent("fortal-dealership:Client:Close")
    
    TestDriveDuration = duration or Config.TestDrive.Duration
    TestDriveStartTime = GetGameTimer()
    
    local spawnCoords = Config.TestDrive.SpawnCoords.normal
    
    local vipCategories = {"blindado", "CLASSE S+", "CLASSE S", "CLASSE A", "CLASSE B", "CLASSE C", "CLASSE D", "MOTOS", "SUV"}
    local isVipCategory = false
    
    if vehicleData and vehicleData.section then
        for _, vipCat in pairs(vipCategories) do
            if vehicleData.section == vipCat then
                isVipCategory = true
                break
            end
        end
    end
    
    if isVipCategory then
        spawnCoords = Config.TestDrive.SpawnCoords.vip
    end
    
    -- Usar routing buckets se disponível
    if HasRoutingBuckets() then
        OriginalRoutingBucket = GetPlayerRoutingBucket(PlayerId())
        SetPlayerRoutingBucket(PlayerId(), TestDriveDimension)
    end
    
    SetEntityCoords(playerPed, spawnCoords.x, spawnCoords.y, spawnCoords.z)
    
    local modelHash = GetHashKey(vehicleSpawn)
    
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(10)
    end
    
    TestDriveVehicle = CreateVehicle(modelHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, spawnCoords.h, true, false)
    
    -- Mover veículo para mesma dimensão se disponível
    if HasRoutingBuckets() then
        SetEntityDimension(TestDriveVehicle, TestDriveDimension)
    end
    
    if vehicleData.defaultColors then
        SetVehicleColours(TestDriveVehicle, vehicleData.defaultColors.primary.id, vehicleData.defaultColors.secondary.id)
        SetVehicleCustomPrimaryColour(Vehicle, vehicleData.defaultColors.primary.rgb[1], vehicleData.defaultColors.primary.rgb[2], vehicleData.defaultColors.primary.rgb[3])
        SetVehicleCustomSecondaryColour(Vehicle, vehicleData.defaultColors.secondary.rgb[1], vehicleData.defaultColors.secondary.rgb[2], vehicleData.defaultColors.secondary.rgb[3])
    end
    
    SetVehicle(TestDriveVehicle)
    TaskWarpPedIntoVehicle(playerPed, TestDriveVehicle, -1)
    
    TestDriveActive = true
    TestDriveVehicleName = vehicleName or "Veículo"
    TestDriveDealershipType = isVipCategory and "vip" or "normal"
    
    SetModelAsNoLongerNeeded(modelHash)
    
    local dealershipTypeText = isVipCategory and "VIP" or "normal"
    local dimensionText = HasRoutingBuckets() and " (Dimensão isolada)" or ""
    TriggerEvent("fortal-dealership:Client:Notify", "Test Drive", "Test drive "..dealershipTypeText.." iniciado!"..dimensionText.." Saia do veículo para retornar à concessionária.", 5000)
    
    -- Iniciar timer na NUI
    UpdateTestDriveTimer()
    
    -- Thread do timer melhorada
    CreateThread(function()
        while TestDriveActive do
            Wait(1000)
            if TestDriveActive then -- Verificar novamente após o wait
                UpdateTestDriveTimer()
            end
        end
    end)
end)

RegisterNetEvent("fortal-dealership:Client:EndTestDrive", function()
    local playerPed = PlayerPedId()
    
    vServer.ForceEndTestDrive()
    
    if OriginalCoords then
        SetEntityCoords(playerPed, OriginalCoords.x, OriginalCoords.y, OriginalCoords.z)
        OriginalCoords = nil
    end
    
    CleanupTestDrive()
end)

RegisterNetEvent("fortal-dealership:Client:Update", function()
    SendNUIMessage({
        action = "updateDealership",
    })
end)

RegisterNetEvent("fortal-dealership:Client:Notify", function(title, description, delay)
    SendNUIMessage({
        action = "addNotify",
        data = {
            title = title,
            description = description,
            delay = delay
        }
    })
end)

RegisterNUICallback("GetVehicleTypes", function(_, Callback)
    local vehicleTypes = vServer.GetVehicleTypes()
    Callback(vehicleTypes or {})
end)

RegisterNUICallback("GetDealershipType", function(_, Callback)
    local dealershipType = vServer.GetDealershipType()
    Callback(dealershipType or "normal")
end)

RegisterNUICallback("GetVehicles", function(data, Callback)
    CreateThread(function()
        local category = data and data.category
        if CurrentDealershipType == "vip" and not category then
            category = "blindado"
        elseif not category then
            category = "comum"
        end
        
        local success, vehicles = pcall(GetFormatedVehicles, category)
        
        if success and vehicles and type(vehicles) == "table" then
            Callback(vehicles)
        else
            Callback({})
        end
    end)
end)

RegisterNUICallback("GetVehicleColors", function(_, Callback)
    Callback(Config.Show.Colors)
end)

RegisterNUICallback("GetPlayerInfo", function(_, Callback)
    local playerInfos = vServer.GetPlayerInfos()
    Callback(playerInfos or {})
end)

RegisterNUICallback("StartTestDrive", function(data, Callback)
    vServer.StartTestDrive(data.spawn, data.name)
    Callback(true)
end)

RegisterNUICallback("RenderVehicle", function(data, Callback)
    if IsSpawningVehicle then
        Callback(false)
        return
    end
    
    if ShowIndex then
        IsSpawningVehicle = true
        
        if Vehicle and DoesEntityExist(Vehicle) then
            Heading = GetEntityHeading(Vehicle)
            DeleteEntity(Vehicle)
            Vehicle = nil
            Wait(100)
        else
            Heading = Config.Show.Coords[ShowIndex].h - 45.0
        end
        
        CleanupShowroomVehicles()
        Wait(50)
    
        if data then
            local modelHash = GetHashKey(data.spawn)
    
            if IsModelInCdimage(modelHash) then
                RequestModel(modelHash)
                local timeout = 0
                while not HasModelLoaded(modelHash) and timeout < 5000 do
                    Wait(10)
                    timeout = timeout + 10
                end
                
                if HasModelLoaded(modelHash) then
                    Vehicle = CreateVehicle(modelHash, Config.Show.Coords[ShowIndex].x, Config.Show.Coords[ShowIndex].y, Config.Show.Coords[ShowIndex].z - 1.0, Heading, false, false)
                    
                    timeout = 0
                    while not DoesEntityExist(Vehicle) and timeout < 2000 do
                        Wait(10)
                        timeout = timeout + 10
                    end
                    
                    if DoesEntityExist(Vehicle) then
                        if data.defaultColors then
                            SetVehicleColours(Vehicle, data.defaultColors.primary.id, data.defaultColors.secondary.id)
                            SetVehicleCustomPrimaryColour(Vehicle, data.defaultColors.primary.rgb[1], data.defaultColors.primary.rgb[2], data.defaultColors.primary.rgb[3])
                            SetVehicleCustomSecondaryColour(Vehicle, data.defaultColors.secondary.rgb[1], data.defaultColors.secondary.rgb[2], data.defaultColors.secondary.rgb[3])
                        end
                
                        FreezeEntityPosition(Vehicle, true)
                        SetEntityInvincible(Vehicle, true)
                    end
                    
                    SetModelAsNoLongerNeeded(modelHash)
                end
            end
        end
        
        IsSpawningVehicle = false
    end

    Callback(true)
end)

RegisterNUICallback("SetPreviewColor", function(data, Callback)
    if data and Vehicle and DoesEntityExist(Vehicle) then
        SetVehicleColours(Vehicle, data.id, data.id)
        SetVehicleCustomPrimaryColour(Vehicle, data.color[1], data.color[2], data.color[3])
        SetVehicleCustomSecondaryColour(Vehicle, data.color[1], data.color[2], data.color[3])
    end

    Callback(true)
end)

RegisterNUICallback("MoveCamera", function(data, Callback)
    if Vehicle and DoesEntityExist(Vehicle) then
        local vehicleHeading = GetEntityHeading(Vehicle)
        local x = (data.x / 150)

        SetEntityHeading(Vehicle, vehicleHeading - x)
    end
    
    Callback(true)
end)

RegisterNUICallback("CheckStock", function(data, Callback)
    local stockStatus = vServer.CheckStock(data.spawn, data.name)
    Callback(stockStatus)
end)

RegisterNUICallback("BuyVehicle", function(data, Callback)
    local primaryColour, secondaryColour;

    if Vehicle and DoesEntityExist(Vehicle) then
        primaryColour, secondaryColour = GetVehicleColours(Vehicle)
    end

    vServer.BuyVehicle(data.spawn, data.currency, { primaryColour, secondaryColour })
    Callback(true)
end)

RegisterNUICallback("removeFocus", function(_, Callback)
    TriggerEvent("fortal-dealership:Client:Close")
    Callback(true)
end)

RegisterCommand("dealership", function()
    TriggerEvent("fortal-dealership:Client:Open")
end)

RegisterCommand("endtestdrive", function()
    if TestDriveActive then
        TriggerEvent("fortal-dealership:Client:EndTestDrive")
        TriggerEvent("fortal-dealership:Client:Notify", "Test Drive", "Test drive finalizado manualmente.", 3000)
    end
end)

RegisterNUICallback("GetVehiclesByCategory", function(data, Callback)
    CreateThread(function()
        local category = data and data.category
        if CurrentDealershipType == "vip" and not category then
            category = "blindado"
        elseif not category then
            category = "comum"
        end
        
        local success, vehicles = pcall(GetFormatedVehicles, category)
        
        if success and vehicles and type(vehicles) == "table" then
            Callback(vehicles)
        else
            Callback({})
        end
    end)
end)
