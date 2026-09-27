local Tunnel = module("vrp","lib/Tunnel")
vFunc = {}

Tunnel.bindInterface("fortal-character", vFunc)

Character = {
    cameraHeading = nil,
    lastHeading = nil
}

CreateThread(function()
    Wait(10000)
    TriggerServerEvent("fortal-character:Server:Spawn")

    SendNUIMessage({
        action = "setColor",
        data = Config.Color[1]..","..Config.Color[2]..","..Config.Color[3]
    })
end)

CreateThread(function()
	while true do
		local timestamp = 1000

		if (Skinshop and Skinshop.inside) or (Barbershop and Barbershop.inside) or (Tattooshop and Tattooshop.inside) then
            timestamp = 0

	        for id = 0, 256 do
				if id ~= PlayerId() and NetworkIsPlayerActive(id) then
					NetworkFadeOutEntity(GetPlayerPed(id), false)
				end
			end
		end

        Wait(timestamp)
	end
end)

CreateThread(function()
    while true do
        local timestamp = 100

        if GetResourceState("fortal-dui") == "started" then

            for _, section in pairs({ "Skinshop", "Barbershop", "Tattooshop" }) do
                local data = _G[section]
    
                if data then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
    
                    for index, coords in pairs(Config[section].Locations) do
                        local distance = #(playerCoords - vec3(coords.x, coords.y, coords.z))
                        local duiId = (string.lower(section).."_"..index)
                        local duiExists = exports["fortal-dui"]:Get(duiId)
    
                        if not data.inside and distance <= coords.viewRadius then
                            timestamp = 0
                            exports["fortal-dui"]:Draw({
                                id = duiId,
                                coords = coords,
                                title = Config[section].MarkerTitle,
                                close = (distance <= coords.radius),
                            })
    
                            if distance <= coords.radius and IsControlJustReleased(0, 38) then
                                data:Open()
                            end
                        else
                            if duiExists then
                                exports["fortal-dui"]:Delete(duiId)
                            end
                        end
                    end
                end
            end
        end

        Wait(timestamp)
    end
end)

RegisterNUICallback("removeFocus", function(_, Callback)
    for _, section in pairs({ "Skinshop", "Barbershop", "Tattooshop" }) do
        local data = _G[section]

        if data and data.inside then
            data:Close()
        end
    end

    Callback(true)
end)

RegisterNUICallback("Character:RotatePed", function(data, Callback)
	local playerPed = PlayerPedId()
	local playerHeading = GetEntityHeading(playerPed)

	if data.direction then
        if not Character.lastHeading then
            Character.lastHeading = data.direction

        	Callback(true)
            return
        end
    
        local delta = data.direction - Character.lastHeading
        Character.lastHeading = data.direction
    
        local newHeading = (playerHeading + delta) % 360
    
        SetEntityHeading(playerPed, newHeading)
	end

	Callback(true)
end)

RegisterNUICallback("Character:SetCamera", function(data, Callback)
    local section = _G[data.section]

    if section then
        Callback(not section.isSwitchingCamera)

        if not section.isSwitchingCamera then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local playerHeading = GetEntityHeading(playerPed)
        
            local cameraCoords = Config.Cameras[data.id]
            local forwardCoords = Utils.GetForwardCoord(playerCoords, Creator.inside and Config.Creator.Coords.h or (Character.cameraHeading or playerHeading), cameraCoords.distance)
            local newCamera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
        
            SetCamCoord(newCamera, forwardCoords + vec3(0, 0, cameraCoords.height))
            PointCamAtEntity(newCamera, playerPed, 0, 0, cameraCoords.pointOffSet)
            SetCamActiveWithInterp(newCamera, section.mainCamera, 600, 1, 1)
        
            section.isSwitchingCamera = true
        
            Wait(350)
        
            section.isSwitchingCamera = false
            DestroyCam(section.mainCamera)
            section.mainCamera = newCamera
        end    
    end
end)

RegisterNetEvent("fortal-character:Client:AddNotify", function(data)
    SendNUIMessage({
        action = "addNotify",
        data = data
    })
end)