local Blips = {
    Main = nil,
    Area = nil,
    AreaActive = false
}

local Plane = {
    Vehicle = nil,
    Pilot = nil
}

local Drop = {
    Box = nil,
    Parachute = nil,
    Flare = nil,
    Falling = false,
    Particle = nil,
}

RegisterNetEvent("fortal-airdrop:Client:StartDelay", function(locationIndex)
    local locationData = Config.Locations[locationIndex]

    if locationData then
        Blips.Main = AddBlipForCoord(locationData.x, locationData.y, locationData.z)

        SetBlipSprite(Blips.Main, Config.Blips.Delay.Sprite)
        SetBlipColour(Blips.Main, Config.Blips.Delay.Colour)
  		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Blips.Delay.Text)
		EndTextCommandSetBlipName(Blips.Main)
    end
end)

RegisterNetEvent("fortal-airdrop:Client:StartDrop", function(locationIndex)
    local locationData = Config.Locations[locationIndex]

    if locationData then
        local coords = { x = locationData.x, y = locationData.y, z = locationData.z + Config.Drop.Height }
        local points = GenerateTwoPoints(coords)

        CreatePlane(points, locationData)

        CreateThread(function()
            while true do
                if Drop.Box and Config.Drop.DangerZone then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local distance = #(playerCoords - vec3(locationData.x, locationData.y, locationData.z))
                                        
                    if distance < (Config.Drop.DangerZone.Radius * 5) then
                        local color = Config.Drop.DangerZone.Color
                        local radius = Config.Drop.DangerZone.Radius * 1.98412

                        DrawMarker(1, locationData.x, locationData.y, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, radius, radius, 400.0, color[1], color[2], color[3], Config.Drop.DangerZone.Alpha, false, false, 2, false, nil, nil, false)
                    end
                end
                
                Wait(5)
            end
        end)
    end
end)

function CreatePlane(points, locationData)    
    local planeHash = GetHashKey(Config.Drop.Plane)
    local pilotHash = GetHashKey('s_m_m_pilot_01')

    RequestModel(planeHash)
    RequestModel(pilotHash)

    while not HasModelLoaded(planeHash) or not HasModelLoaded(pilotHash)  do
        Wait(0)
    end
        
    if HasModelLoaded(planeHash) and HasModelLoaded(pilotHash) then
        Plane.Vehicle = CreateVehicle(planeHash, vec3(points.first.x,points.first.y,points.first.z + 140.0), points.direction, false, false)
        Plane.Pilot = CreatePedInsideVehicle(Plane.Vehicle, 6, pilotHash, -1, false, false)       
        
        SetEntityProofs(Plane.Vehicle, true, true, true, true, true, true, true, false);
        SetVehicleEngineOn(Plane.Vehicle, true, true, true)
        SetModelAsNoLongerNeeded(Plane.Vehicle)

        TaskPlaneMission(Plane.Pilot, Plane.Vehicle, 0, 0, points.second.x, points.second.y, points.second.z, 4, GetVehicleModelMaxSpeed(planeHash), 1.0, points.direction, 10.0, 40.0)
    
        CreateThread(function()
            while true do
                local planeCoords = GetEntityCoords(Plane.Vehicle)
                local distance = GetDistanceBetweenCoords(planeCoords.x, planeCoords.y, planeCoords.z, locationData.x, locationData.y, locationData.z, false)

                if distance <= 25.0 and not Config.Drop.Falling then
                    CreateDrop(locationData)
                end

                if distance > ((Config.Drop.Distance / 2) + 20.0) then
                    DeleteEntity(Plane.Vehicle)
                    DeleteEntity(Plane.Pilot) 

                    Plane = {
                        Vehicle = nil,
                        Pilot = nil
                    }

                    break
                end

                Wait(500)
            end
        end)
    end
end

function CreateDrop(locationData)
    -- TriggerEvent('black:chatMessage', Config.Alert.Chat.Dropping.Title, Config.Alert.Chat.Dropping.Message)
    TriggerEvent('Notify2', -1,"airdrop", Config.Alert.Chat.Dropping.Title, Config.Alert.Chat.Dropping.Message,5000)

    if Blips.Main and DoesBlipExist(Blips.Main) then
        RemoveBlip(Blips.Main)
    end

    if Blips.Area and DoesBlipExist(Blips.Area) then
        RemoveBlip(Blips.Area)
    end

    Blips.Main = AddBlipForCoord(locationData.x, locationData.y, locationData.z)
    Blips.Area = AddBlipForRadius(locationData.x, locationData.y, locationData.z, Config.Drop.DangerZone.Radius)

    SetBlipSprite(Blips.Main, Config.Blips.OnDrop.Sprite)
    SetBlipColour(Blips.Main, Config.Blips.OnDrop.Colour)
  	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Blips.OnDrop.Text)
	EndTextCommandSetBlipName(Blips.Main)

    SetBlipColour(Blips.Area, Config.Blips.OnDrop.Colour)
    SetBlipAlpha(Blips.Area, 90)
    SetBlipDisplay(Blips.Area, 4)

    local boxModel = GetHashKey(Config.Drop.Object.Box)
    local parachuteModel = GetHashKey(Config.Drop.Object.Parachute)
    local flareModel = GetHashKey(Config.Drop.Object.Flare)

    Drop.Box = CreateObject(boxModel, locationData.x, locationData.y, Config.Drop.Height - 2.0, false, true, true)
    Drop.Parachute = CreateObject(parachuteModel, locationData.x, locationData.y, Config.Drop.Height - 2.0, false, true, true)
    Drop.Flare = CreateObject(flareModel, locationData.x,locationData.y,locationData.z - 1, false, true, true)

    StartParticle(locationData)

    FreezeEntityPosition(Drop.Flare,true)
    FreezeEntityPosition(Drop.Box,true)
    SetEntityInvincible(Drop.Box,true)
    FreezeEntityPosition(Drop.Parachute,true)
    SetEntityInvincible(Drop.Parachute,true)
    AttachEntityToEntity(Drop.Parachute, Drop.Box, 0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    Drop.Falling = true

    CreateThread(function()
        while true do
            if Drop.Falling then
                Blips.AreaActive = not Blips.AreaActive

                SetBlipAlpha(Blips.Area, Blips.AreaActive and 90 or 180)
            else
                if Blips.AreaActive then
                    SetBlipAlpha(Blips.Area, 90)
                    Blips.AreaActive = false

                    break
                end
            end

            Wait(1000)
        end
    end)

    CreateThread(function()
        while true do
            if Drop.Falling then
                timestamp = 0

                local playerPed = PlayerPedId()
                local boxCoords = GetEntityCoords(Drop.Box)
                local boxHeight = GetEntityHeightAboveGround(Drop.Box)

                if boxHeight <= 70.0 then
                    DeleteEntity(Drop.Flare)
                    StopParticle()
                end

                if boxHeight > 0.15 then
                    SetEntityCoords(Drop.Box, boxCoords + vec3(0, 0, -Config.Drop.Decrease))
                    SetEntityCoords(Drop.Parachute, boxCoords + vec3(0, 0, -Config.Drop.Decrease))
                else
                    SetEntityCoords(Drop.Box, locationData.x, locationData.y, locationData.z - 1)
                    DeleteEntity(Drop.Parachute)

                    SetBlipSprite(Blips.Main, Config.Blips.Dropped.Sprite)
                    SetBlipColour(Blips.Main, Config.Blips.Dropped.Colour)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(Config.Blips.Dropped.Text)
                    EndTextCommandSetBlipName(Blips.Main)

                    exports["target"]:AddCircleZone("AirDrop:1", vec3(locationData.x, locationData.y, locationData.z), 2.0, {
                        name = "AirDrop:1",
                        heading = 3374176
                    }, {
                        shop = "AirDrop-1",
                        distance = 2.0,
                        options = {
                            {
                                event = "chest:openSystem2",
                                label = "Abrir",
                                tunnel = "shop"
                            }
                        }
                    })
                    
                    Drop.Falling = false
                end
            else
                Wait(Config.Drop.Times.Delete * 60 * 1000)

                if Blips.Main and DoesBlipExist(Blips.Main) then
                    RemoveBlip(Blips.Main)
                end

                if Blips.Area and DoesBlipExist(Blips.Area) then
                    RemoveBlip(Blips.Area)
                end

                DeleteEntity(Drop.Box)

                Drop.Box = nil

				exports["target"]:RemCircleZone("AirDrop")
            end

            Wait(5)
        end
    end)
end

function GenerateTwoPoints(coords)
    local halfDistance = Config.Drop.Distance / 2.0
    local heading = math.random() * 360
    local angleRad = math.rad(heading)

    local cosRad = math.cos(angleRad)
    local senRad = math.sin(angleRad)

    local firstPoint = {
        x = coords.x + cosRad * halfDistance,
        y = coords.y + senRad * halfDistance,
        z = coords.z
    }

    local secondPoint = {
        x = coords.x - cosRad * halfDistance,
        y = coords.y - senRad * halfDistance,
        z = coords.z
    }

    local deltaX = secondPoint.x - firstPoint.x
    local deltaY = secondPoint.y - firstPoint.y
    local pointsDirection = -math.deg(math.atan2(deltaX, deltaY))

    if pointsDirection < 0 then
        pointsDirection = pointsDirection + 360
    end

    return { first = firstPoint, second = secondPoint, direction = pointsDirection }
end

function StartParticle(locationData)
    RequestNamedPtfxAsset(Config.Particle.Dict)

    while not HasNamedPtfxAssetLoaded(Config.Particle.Dict) do
        RequestNamedPtfxAsset(Config.Particle.Dict)
        Wait(50);
    end

    UseParticleFxAssetNextCall(Config.Particle.Dict)
        
    Drop.Particle = StartParticleFxLoopedAtCoord(Config.Particle.Name, locationData.x, locationData.y, locationData.z - 0.75, 0.0, 0.0, 0.0, 2.0, false, false, false, false);
end

function StopParticle()
    if Drop.Particle then
        StopParticleFxLooped(Drop.Particle, false)

        Drop.Particle = nil
    end
end