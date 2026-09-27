local hoodActive = false
local nitroActive = false 
local nitroFuel = nil
local beltLock = false
local pauseBreak = false
local hours = GlobalState["Hours"]
local minutes = GlobalState["Minutes"]
local beltSpeed = 0
local beltVelocity = vector3(0,0,0)
local clientStress = 0
local clientHunger = 100
local clientThirst = 100
local showHud = false
local homeInterior = false
local updateFoods = GetGameTimer()
local wantedTimer = GetGameTimer()
local reposeTimer = GetGameTimer()
local divingMask = nil
local divingTank = nil
local clientOxigen = 100
local divingTimers = GetGameTimer()
local voiceTarget = { "sussurrando","falando","gritando","Muito Alto" }
local voiceTarget2 = 2
local radioFreq = 0 
local chatOpen = false
local userGems = 0

CreateThread(function()
	SetTextChatEnabled(false)
	SendNUIMessage({ action = "setVisible",data = true })
end) 

CreateThread(function()
	while true do 
		local ped = PlayerPedId()
		local pid = PlayerId()
		local currentHealth = GetEntityHealth(ped)
		local pedArmour = GetPedArmour(ped) 
		local pedCoords = GetEntityCoords(ped)
		local inCar = IsPedInAnyVehicle(ped)
		local isWeapon 	= GetCurrentPedWeapon(ped)
		local hash = GetSelectedPedWeapon(ped)
        local _,ammoInClip = GetAmmoInClip(ped, hash)
        local ammoOutClip = GetAmmoInPedWeapon(ped, hash) - ammoInClip
		local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(pedCoords["x"], pedCoords["y"], pedCoords["z"]))
		local curTalkingStatus = MumbleIsPlayerTalking(pid) == 1
		local hours = GlobalState["Hours"] >= 0 and GlobalState["Hours"] < 10 and "0" .. GlobalState["Hours"] or GlobalState["Hours"]
		local minutes = GlobalState["Minutes"] >= 0 and GlobalState["Minutes"] < 10 and "0" .. GlobalState["Minutes"] or GlobalState["Minutes"]
		local maxHealth = 200
		local minHealth = 101
		local healthPercentage = 0

		if currentHealth >= minHealth and currentHealth <= maxHealth then
			healthPercentage = ((currentHealth - minHealth) / (maxHealth - minHealth)) * 100
		else
			healthPercentage = 0
		end

		if isWeapon then
			SendNUIMessage({ action = "setWeapon",data = { 
				image = "https://cdn.blacknetwork.com.br/black_weapon/" .. hash .. ".png",
				amountMax = ammoOutClip,
				amountMin = ammoInClip
			}})
		else 
			SendNUIMessage({ action = "setWeapon",data = nil })
		end
		SendNUIMessage({ action = "set:voice",data = { 
			active  = curTalkingStatus, 
			current = voiceTarget[tonumber(voiceTarget2)]
		}})
		SendNUIMessage({ action = "set:info",data = {
			health = healthPercentage,
			shield = pedArmour,
		}})
		SendNUIMessage({ action = "setStress",data = clientStress })
		SendNUIMessage({ action = "set:time",data = { hours, minutes } })
		SendNUIMessage({ action = "set:street",data = streetName })
		SendNUIMessage({ action = "set:radio",data = radioFreq })
		SendNUIMessage({ action = "set:gens",data = userGems })

		if inCar then 
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehicleEngine = GetIsVehicleEngineRunning(vehicle)
			local vehicleFuel = GetVehicleFuelLevel(vehicle)
			local vehicleDoors = GetVehicleDoorLockStatus(vehicle)
			local vehicleSpeed = parseInt(GetEntitySpeed(vehicle) * 3.6)
			local vehiclePlate = GetVehicleNumberPlateText(vehicle)
			local vehicleGear = GetVehicleCurrentGear(vehicle)
			local traction = GetVehicleMaxTraction(vehicle)
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			local _, lightsOn, highBeamsOn = GetVehicleLightsState(vehicle)
			local lightLevel = 0

			if state == 1 then
				lightLevel = 1 
			end

			if lightsOn == 1 then
				lightLevel = 1 
			end
			
			if highBeamsOn == 1 then
				lightLevel = 2 
			end
			if not nitroFuel then
				nitroFuel = GlobalState["Nitro"][vehPlate] or 0
			end

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = "N"
			elseif (vehicleSpeed > 0 and vehicleGear == 0) then
				vehicleGear = "R"
			end 
			DisplayRadar(true)
			SetBlipAlpha(GetNorthRadarBlip(), 0)
			
			SendNUIMessage({ action = "onVehicle",data = true })
			-- Motor: de 0 (quebrado) a 1000 (novo)
		local engineHealth = GetVehicleEngineHealth(vehicle)
		if engineHealth > 1000 then engineHealth = 1000 end
		if engineHealth < 0 then engineHealth = 0 end

		-- Converter para porcentagem
		local enginePercent = math.floor((engineHealth / 1000) * 100)

		SendNUIMessage({ action = "speedometer", data = {
			speed    = vehicleSpeed,
			gas      = vehicleFuel,
			tracion  = traction,
			march    = vehicleGear,
			lock     = (vehicleDoors == 2),
			light    = lightLevel,
			engine   = enginePercent, -- aqui em porcentagem
			nitro    = (nitroFuel / 200) * 100,
			seatbelt = beltLock
		}})

		else
			SendNUIMessage({ 
				action = "onVehicle",
				data   = false 
			})
			DisplayRadar(false)
			
			if nitroFuel then
				nitroFuel = nil
			end
		end 

		if IsPauseMenuActive() then
			if showHud then
				SendNUIMessage({ action = "setVisible", data = false })
			end
		elseif showHud then
			SendNUIMessage({ action = "setVisible", data = true })
		end
		
		
		Wait(75) 
	end 		
end) 

CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if GetGameTimer() >= updateFoods and GetEntityHealth(ped) > 101 then
				updateFoods = GetGameTimer() + 90000
				clientThirst = clientThirst - 1
				clientHunger = clientHunger - 1

				SendNUIMessage({ action = "setHunger",data = clientHunger })
				SendNUIMessage({ action = "setThirst",data = clientThirst })
				serverAPI.updateFoodsData(clientThirst,clientHunger)
			end
		end
		Wait(30000)
	end
end)

CreateThread(function()
	while true do
		if LocalPlayer["state"]["Active"] then
            local ped = PlayerPedId()
			local pedHealth = GetEntityHealth(ped)
			if divingMask ~= nil then
				if GetGameTimer() >= divingTimers then
					divingTimers = GetGameTimer() + 3000
					SendNUIMessage({ 
						action = "set:oxigen", 
						data = { 
							active = divingMask ~= nil,
							value = clientOxigen 
						}
					})
				end
			else
				if IsPedSwimmingUnderWater(ped) then 
					local pid = PlayerId()
					local maxOxygen = 10.0 
       				local currentOxygen = GetPlayerUnderwaterTimeRemaining(pid) 
       				local oxygenPercentage = math.floor((currentOxygen / maxOxygen) * 100) 

       				if oxygenPercentage > 100 then oxygenPercentage = 100 end
       				if oxygenPercentage < 0 then oxygenPercentage = 0 end

					SendNUIMessage({ 
						action = "set:oxigen", 
						data = { 
							active = true,
							value = oxygenPercentage 
						}
					})
				else
					SendNUIMessage({ 
						action = "set:oxigen", 
						data = { 
							active = false,
							value = oxygenPercentage 
						}
					})
				end
			end
		end
		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		local hours = GlobalState["Hours"]

        local canAssault = (hours >= 23 or hours < 7)

        SendNUIMessage({ 
            action = "set:assault",
            data = {
                type = not canAssault,
				title = "Atenção",
                show = false,
                description = canAssault and "Assalto Permitido." or "Assalto Proibido.",
            }
        })

		Wait(500)
	end
end)

CreateThread(function()
	while true do
		if homeInterior then
			SetWeatherTypeNow("CLEAR")
			SetWeatherTypePersist("CLEAR")
			SetWeatherTypeNowPersist("CLEAR")
			NetworkOverrideClockTime(00,00,00)
		else
			SetWeatherTypeNow(GlobalState["Weather"])
			SetWeatherTypePersist(GlobalState["Weather"])
			SetWeatherTypeNowPersist(GlobalState["Weather"])
			NetworkOverrideClockTime(GlobalState["Hours"],GlobalState["Minutes"],00)
		end

		Wait(1)
	end
end)

CreateThread(function()
	local foodTimers = GetGameTimer()
	while true do
		if LocalPlayer["state"]["Active"] then
			if GetGameTimer() >= foodTimers then
				foodTimers = GetGameTimer() + 10000

				local ped = PlayerPedId()
				local pedHealth = GetEntityHealth(ped)
				if pedHealth > 101 then
					if clientHunger >= 10 and clientHunger <= 20 then
						SetEntityHealth(ped,pedHealth - 1)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					elseif clientHunger <= 9 then
						SetEntityHealth(ped,pedHealth - 2)
						TriggerEvent("Notify","hunger","Sofrendo com a fome.",3000)
					end

					if clientThirst >= 10 and clientThirst <= 20 then
						SetEntityHealth(ped,pedHealth - 1)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					elseif clientThirst <= 9 then
						SetEntityHealth(ped,pedHealth - 2)
						TriggerEvent("Notify","thirst","Sofrendo com a sede.",3000)
					end
				end
			end
		end
		Wait(1000)
	end
end)

CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if GetEntityHealth(ped) > 101 then
				if clientStress >= 99 then
					timeDistance = 2500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.75)
				elseif clientStress >= 80 and clientStress <= 98 then
					timeDistance = 5000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.50)
				elseif clientStress >= 60 and clientStress <= 79 then
					timeDistance = 7500
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.25)
				elseif clientStress >= 40 and clientStress <= 59 then
					timeDistance = 10000
					ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
				end
			end
		end
		Wait(timeDistance)
	end
end)

function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end

CreateThread(function()
	while true do
		local timeDistance = 999
		if LocalPlayer["state"]["Active"] then
			local ped = PlayerPedId()
			if IsPedInAnyVehicle(ped) then
				if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
					timeDistance = 1

					
					local vehicle = GetVehiclePedIsUsing(ped)
					
					if beltLock then
						DisableControlAction(1,75,true)
					end

					local speed = GetEntitySpeed(vehicle) * 3.6
					if speed ~= beltSpeed then
						if (beltSpeed - speed) >= 45 and not beltLock then
							local fowardVeh = fowardPed(ped)
							local coords = GetEntityCoords(ped)
							local health = GetEntityHealth(ped)
							SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
							SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
							SetEntityHealth(ped,health - 50)

							Wait(1)

							SetPedToRagdoll(ped,5000,5000,0,0,0,0)
						end

						beltVelocity = GetEntityVelocity(vehicle)
						beltSpeed = speed
					end
				end
			else
				if beltSpeed ~= 0 then
					beltSpeed = 0
				end

				if beltLock then
					SendNUIMessage({ action = "set:seatbelt",data = false })
					beltLock = false
				end
			end
		end

		Wait(timeDistance)
	end
end)

-- CreateThread(function()
-- 	while true do 
-- 		local ped = PlayerPedId()
-- 		if IsPedInAnyVehicle(ped,true) and not IsPedOnAnyBike(ped) then 
-- 			if not beltLock then 
-- 				TriggerEvent("sounds:source","seatbeltalarm",0.5)
-- 			end
-- 		else
-- 			TriggerEvent("sounds:stop")
-- 		end
-- 		Wait(2000)
-- 	end 
-- end)

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(a, b, c, d,f)
	if type(b) == "string" then
		b = string.gsub(b, "<b>", "")
		b = string.gsub(b, "</b>", "")
	end
	local typeNotify,title,description,duration;
	local typeNotifyIcon = {
		["important"] = "amarelo",
		["verde"] = "verde",
		["check"] = "verde",
		["azul"] = "azul",
		["vermelho"] = "vermelho",
		["unlocked"] = "vermelho",
		["cancel"] = "vermelho",
		["locked"] = "verde",
		["negado"] = "vermelho",
		["pm"] = "azul",
		["hospital"] = "azul",
		["mechanic"] = "amarelo"
	}

	if f and (type(f) == "number" or tonumber(f) > 10) then
		title = b
		typeNotify = typeNotifyIcon[a] or a
		description = c
		duration = tonumber(f)
	elseif type(d) == "number" then
		typeNotify = typeNotifyIcon[a] or a
		title = b
		description = c
		duration = d
	elseif type(c) == "number" then
		typeNotify = typeNotifyIcon[a] or a
		title = "Alerta!"
		description = b
		duration = c
	else 
		title = "Alerta!"
		typeNotify = typeNotifyIcon[a] or a
		description = b
		duration = 5000
	end

	SendNUIMessage({ action = "setVisible",data = true })
	TriggerEvent("sounds:source", "notify", 1)
    SendNUIMessage({ 
        action = "set:notify",
        data = {
            type = typeNotify,
            title = title,
            message = description,
            delay = duration 
        }
    })
end)

RegisterNetEvent("Notify2")
AddEventHandler("Notify2",function(b, c, d,f)
	SendNUIMessage({ action = "setVisible",data = true })
	-- TriggerEvent("sounds:source", "notify", 0.5)
	
	print("Notify2",b,c,d,f)
    SendNUIMessage({ 
        action = "set:notify2",
        data = {
            type = b,
            title = c,
            message = d,
            delay = f 
        }
    })
end)

RegisterNetEvent("Progress")
AddEventHandler("Progress",function(delay)
	SendNUIMessage({ action = "set:progress",data = {
		active = true,
		time  = delay 
	}})
end)

RegisterNetEvent("StopProgress")
AddEventHandler("StopProgress",function()
	SendNUIMessage({ action = "set:progress",data = {
		active = false,
		delay = 0
	}})
end)

RegisterNetEvent("hud:Radio")
AddEventHandler("hud:Radio",function(number)
	radioFreq = number 
end)

RegisterNetEvent("hud:Gems")
AddEventHandler("hud:Gems",function(number)
	userGems = number 
end)

RegisterNetEvent("hud:Voip")
AddEventHandler("hud:Voip",function(number)
	voiceTarget2 = number
	SendNUIMessage({ action = "set:voice",data = { active = false, current = voiceTarget[tonumber(number)]} })
end)

RegisterNetEvent("hud:Hood")
AddEventHandler("hud:Hood",function()
	hoodActive = not hoodActive
	local ped = PlayerPedId()
	if hoodActive then
		DoScreenFadeOut(1000)
		SetPedComponentVariation(ped, 1, 69, 0, 1)
	else
		DoScreenFadeIn(1000)
		SetPedComponentVariation(ped, 1, 0, 0, 1)
	end
	SendNUIMessage({ action = "set:hood", data = hoodActive })
end)

RegisterNetEvent("homes:Hours")
AddEventHandler("homes:Hours",function(status)
	homeInterior = status
end)

RegisterNetEvent("hud:wantedClient")
AddEventHandler("hud:wantedClient", function(Seconds)
  
    SendNUIMessage({ action = "setCooldown", data = Seconds })
end)


RegisterNetEvent("hud:reposeClient")
AddEventHandler("hud:reposeClient",function(Seconds)
	reposeTimer = GetGameTimer() + (Seconds * 1000)
end)

RegisterNetEvent("hud:Hunger")
AddEventHandler("hud:Hunger",function(number)
	clientHunger = number
	SendNUIMessage({ action = "setHunger",data = clientHunger })
end)

RegisterNetEvent("hud:Thirst")
AddEventHandler("hud:Thirst",function(number)
	clientThirst = number
	SendNUIMessage({ action = "setThirst",data = clientThirst })
end)

RegisterNetEvent("hud:Stress")
AddEventHandler("hud:Stress",function(number)
	SendNUIMessage({ action = "setStress",data = number })
	clientStress = number
end)

RegisterNetEvent("hud:Oxigen")
AddEventHandler("hud:Oxigen",function(number)
	SendNUIMessage({ active = divingMask ~= nil, amount = number })
	clientOxigen = number
end)

RegisterNetEvent("hud:rechargeOxigen")
AddEventHandler("hud:rechargeOxigen",function()
	TriggerEvent("Notify","verde","Reabastecimento concluído.",3000)
	SendNUIMessage({ active = divingMask ~= nil, amount = 100 })
	vRPS.rechargeOxigen()
	clientOxigen = 100
end)

RegisterNetEvent("hud:RemoveScuba")
AddEventHandler("hud:RemoveScuba",function()
	local ped = PlayerPedId()
	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ action = "set:oxigen", data = { active = false,value = 0 } })
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	end
end)

RegisterNetEvent("hud:Diving")
AddEventHandler("hud:Diving",function()
	local ped = PlayerPedId()

	if DoesEntityExist(divingMask) or DoesEntityExist(divingTank) then
		if DoesEntityExist(divingMask) then
			SendNUIMessage({ action = "set:oxigen", data = { active = false,value = 0 } })
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingMask))
			divingMask = nil
		end

		if DoesEntityExist(divingTank) then
			TriggerServerEvent("tryDeleteObject",ObjToNet(divingTank))
			divingTank = nil
		end

		SetEnableScuba(ped,false)
		SetPedMaxTimeUnderwater(ped,10.0)
	else
		local coords = GetEntityCoords(ped)
		local myObject,objNet = vRPS.CreateObject("p_s_scuba_tank_s",coords["x"],coords["y"],coords["z"])
		if myObject then
			local spawnObjects = 0
			divingTank = NetworkGetEntityFromNetworkId(objNet)
			while not DoesEntityExist(divingTank) and spawnObjects <= 1000 do
				divingTank = NetworkGetEntityFromNetworkId(objNet)
				spawnObjects = spawnObjects + 1
				Wait(1)
			end

			spawnObjects = 0
			local objectControl = NetworkRequestControlOfEntity(divingTank)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(divingTank)
				spawnObjects = spawnObjects + 1
				Wait(1)
			end

			AttachEntityToEntity(divingTank,ped,GetPedBoneIndex(ped,24818),-0.28,-0.24,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
	
			SetEntityAsNoLongerNeeded(divingTank)
		end

		local myObject,objNet = vRPS.CreateObject("p_s_scuba_mask_s",coords["x"],coords["y"],coords["z"])
		if myObject then
			local spawnObjects = 0
			divingMask = NetworkGetEntityFromNetworkId(objNet)
			while not DoesEntityExist(divingMask) and spawnObjects <= 1000 do
				divingMask = NetworkGetEntityFromNetworkId(objNet)
				spawnObjects = spawnObjects + 1
				Wait(1)
			end

			spawnObjects = 0
			local objectControl = NetworkRequestControlOfEntity(divingMask)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(divingMask)
				spawnObjects = spawnObjects + 1
				Wait(1)
			end

			AttachEntityToEntity(divingMask,ped,GetPedBoneIndex(ped,12844),0.0,0.0,0.0,180.0,90.0,0.0,1,1,0,0,2,1)
	
			SetEntityAsNoLongerNeeded(divingMask)
		end

		SetEnableScuba(ped,true)
		SetPedMaxTimeUnderwater(ped,2000.0)
	end
end)

function nitroEnable()
	if nitroActive then return end

	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle, -1) == ped then
			local vehPlate = GetVehicleNumberPlateText(vehicle)
			nitroFuel = GlobalState["Nitro"][vehPlate] or 0
			if nitroFuel >= 1 then
				TriggerEvent("sounds:source", "nitro", 1.0)
				nitroActive = true

				while nitroActive do
					if nitroFuel and nitroFuel > 0 then
						nitroFuel = nitroFuel - 1

						SetVehicleCheatPowerIncrease(vehicle, 5.0)
						ModifyVehicleTopSpeed(vehicle, 20.0)
						fireExaust(vehicle)
					else
						SetVehicleCheatPowerIncrease(vehicle, 0.0)
						ModifyVehicleTopSpeed(vehicle, 0.0)

						nitroActive = false
					end

					Wait(100)
				end
			end
		end
	end
end


function nitroDisable()
	if nitroActive then
		nitroActive = false

		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local vehPlate = GetVehicleNumberPlateText(vehicle)

			SetVehicleCheatPowerIncrease(vehicle,0.0)
			serverAPI.updateNitro(vehPlate,nitroFuel)
			ModifyVehicleTopSpeed(vehicle,0.0)

			if GetScreenEffectIsActive("RaceTurbo") then
				StopScreenEffect("RaceTurbo")
			end
		end
	end
end

local exausts = {
	"exhaust","exhaust_2","exhaust_3","exhaust_4","exhaust_5","exhaust_6","exhaust_7","exhaust_8",
	"exhaust_9","exhaust_10","exhaust_11","exhaust_12","exhaust_13","exhaust_14","exhaust_15","exhaust_16"
}

function fireExaust(vehicle)
	for k,v in ipairs(exausts) do
		local exaustNumber = GetEntityBoneIndexByName(vehicle,v)

		if exaustNumber > -1 then
			UseParticleFxAssetNextCall("core")
			StartNetworkedParticleFxNonLoopedOnEntityBone("veh_backfire",vehicle,0.0,0.0,0.0,0.0,0.0,0.0,exaustNumber,1.75,false,false,false)
		end
	end
end

RegisterCommand("seatbelt",function(source,args,rawCommand)
	if MumbleIsConnected() then
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			if not IsPedOnAnyBike(ped) then
				if beltLock then
					TriggerEvent("sounds:source","unbelt",0.5)
					SendNUIMessage({ action = "set:seatbelt",data = false })
					beltLock = false
				else
					TriggerEvent("sounds:source","belt",0.5)
					SendNUIMessage({ action = "set:seatbelt",data = true })
					beltLock = true
				end
			end
		end
	end
end)

RegisterCommand("hud",function(source,args,rawCommand)
	if MumbleIsConnected() then
		showHud = not showHud
		SendNUIMessage({ action = "setVisible",data = showHud })
	end
end)

RegisterCommand("openChat",function(source,args)
	chatOpen = true  
	SendNUIMessage({ action = "set:showChat",data = true  })
	SetNuiFocus(true,true)
end) 

RegisterNUICallback("getSuggestions",function(data,cb)
	cb(Utils.suggestions)
end) 

RegisterNUICallback("getChannelsPermissions", function(data, cb)
    local src = source
    local result = serverAPI.getChannelsPermissions(src) 
    cb(result)
end)

RegisterNUICallback("hideChat",function(data,cb)
	SetNuiFocus(false)
	chatOpen = false
	SendNUIMessage({ action = "set:showChat",data = false })
end) 

RegisterNUICallback("chatResult",function(data,cb)
	SetNuiFocus(false)
	chatOpen = false

	if data.message then
		if data.message:sub(1,1) == "/" then
			ExecuteCommand(data.message:sub(2))
		else
			TriggerServerEvent("black:chatMessageEntered", data.message, data.type)
		end
	end
	SendNUIMessage({ action = "set:showChat",data = false })
end) 

RegisterNetEvent("hud:actions")
AddEventHandler("hud:actions",function(bool)
	showHud = bool
	SendNUIMessage({ action = "setVisible",data = bool })
end) 

RegisterNetEvent("black:chatMessage")
AddEventHandler("black:chatMessage",function(name,message,type)
	SendNUIMessage({ 
		action = "addChatMessage",
		data = {
			name = name,
			message = message,
			type = "default" 
		}
	})
end) 

RegisterNetEvent("black:addChatMessage")
AddEventHandler("black:addChatMessage", function(data)
	SendNUIMessage({ 
		action = "addChatMessage",
		data = data
	})
end)


exports("statusChat",function()
	return chatOpen
end)

function src.chatStatus()
	return chatOpen
end

RegisterCommand("+activeNitro",nitroEnable)
RegisterCommand("-activeNitro",nitroDisable)
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","G")
RegisterKeyMapping("openChat","Abrir chat.","keyboard","T")
RegisterKeyMapping("+activeNitro","Ativação do nitro.","keyboard","LMENU")
