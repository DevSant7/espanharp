-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

serverAPI = Tunnel.getInterface("target")

coreP = Tunnel.getInterface("coreP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local Selected = {}
local Sucess = false
LocalPlayer["state"]["Target"] = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
local Gymnasium = Config.Gymnasium
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	for Index,Value in pairs(Gymnasium["Locations"]) do
		if Value["Ped"] then
			exports["coreP"]:AddPed({
				["distance"] = 25,
				["model"] = {Value["Ped"]["Model"][1],Value["Ped"]["Model"][2]},
				["coords"] = Value["Ped"]["Coords"],
				["anim"] = Value["Ped"]["anim"]
			})
			AddCircleZone("Gymnasium:"..Index,vec3(Value["Ped"]["Coords"][1],Value["Ped"]["Coords"][2],Value["Ped"]["Coords"][3]),1.0,{
				name = "Gymnasium:"..Index,
				heading = 3374176
			},{
				shop = Index,
				distance = 0.75,
				options = {
					{
						event = "target:PaymentGym",
						label = "Academia",
						tunnel = "police",
						service = Value["Ped"]["Price"]
					}
				}
			})
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDSTATEBAGCHANGEHANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddStateBagChangeHandler("Gymnastics",nil,function(Name,Key,Value)
	local Name = "Gymnasium"..Value.Location..":"..Value.Equipment..""..Value.Position
	local Coords = Gymnasium["Locations"][Value.Location]["Positions"][Value.Equipment][Value.Position]
	if Gymnasium["Locations"][Value.Location]["Active"] then
		if Value.Available == nil then
			exports["target"]:RemBoxZone(Name)
		else
			exports["target"]:AddBoxZone(Name,Coords["xyz"],1.5,1.5,{
				["name"] = Name,
				["heading"] = Coords["h"] or 0.0,
				["minZ"] = Coords["z"],
				["maxZ"] = Coords["z"]+2.2,
			},{
				distance = 1.5,
				options = {{
				 	event = "target:Gymnasium",
				 	label = Value.Equipment,
				 	tunnel = "server",
				}},
				shop = { 
					Coords = Coords,
					Location = Value.Location, 
					Equipment = Value.Equipment, 
					Position = Value.Position, 
					Anim = Gymnasium["Anim"][Value.Equipment] 
				}
			})
		end
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Gymnasium")
AddEventHandler("target:Gymnasium",function(Data)
	for Location,Value in pairs(Gymnasium["Locations"]) do
		for Equipment,Value in pairs(Value["Positions"]) do
			for Position,Value in pairs(Value) do
				if not Gymnasium["Locations"][Location]["Ped"] or Data[2][tostring(Location)] then
					Gymnasium["Locations"][Location]["Active"] = true
					if Data[1]["Gymnasium"..Location..":"..Equipment..""..Position] then
						exports["target"]:RemBoxZone("Gymnasium"..Location..":"..Equipment..""..Position)
					else
						exports["target"]:AddBoxZone("Gymnasium"..Location..":"..Equipment..""..Position,Value["xyz"],1.5,1.5,{
							["name"] = "Gymnasium"..Location..":"..Equipment..""..Position,
							["heading"] = Value["h"] or 0.0,
							["minZ"] = Value["z"],
							["maxZ"] = Value["z"]+2.2,
						},{
							distance = 1.5,
							options = {{
								event = "target:Gymnasium",
								label = Equipment,
								tunnel = "server",
							}},
							shop = { 
								Coords = Value,
								Location = Location, 
								Equipment = Equipment, 
								Position = Position, 
								Anim = Gymnasium["Anim"][Equipment] 
							}
						})
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:DISMANTLES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Debug")
AddEventHandler("target:Debug",function()
	SetNuiFocus(false,false)
	SendNUIMessage({ action = "setVisible", data = false })
	LocalPlayer["state"]["Target"] = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	Config.initOptions()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	if not serverAPI.IsAuth() then return end 

	if LocalPlayer["state"]["Active"] then
		local ped = PlayerPedId()

		if LocalPlayer["state"]["Buttons"] or LocalPlayer["state"]["Commands"] or LocalPlayer["state"]["Handcuff"] or Sucess or IsPedArmed(ped,6) or IsPedInAnyVehicle(ped) or not MumbleIsConnected() or LocalPlayer["state"]["Route"] > 900000 then
			return
		end

		LocalPlayer["state"]["Target"] = true
		SendNUIMessage({ action = "setVisible", data = true })
		SendNUIMessage({ action = "openTarget" })


		while LocalPlayer["state"]["Target"] do
			local hitZone,entCoords,entity = RayCastGamePlayCamera()
			if hitZone == 1 then
				local coords = GetEntityCoords(ped)

				for k,v in pairs(Zones) do
					if Zones[k]:isPointInside(entCoords) then
						if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then

							if v["targetoptions"]["shop"] ~= nil then
								Selected = v["targetoptions"]["shop"]
							end

							if v["targetoptions"]["shopserver"] ~= nil then
								Selected = v["targetoptions"]["shopserver"]
							end
							SendNUIMessage({ action = "validTarget", data = Zones[k]["targetoptions"]["options"] })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _, entCoords, entity = RayCastGamePlayCamera()
							
								DisableControlAction(0, 24, true)
								DisableControlAction(0, 257, true)
								DisableControlAction(0, 140, true)
								DisableControlAction(0, 141, true)
								DisableControlAction(0, 142, true)
							
								if IsControlJustReleased(1, 24) or IsDisabledControlJustReleased(1, 24) then
									SetCursorLocation(0.5, 0.5)
									SetNuiFocus(true, true)
									Wait(150)
								end
							
								if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
									Sucess = false
								end
							
								Wait(1)
							end							

							SendNUIMessage({ action = "leftTarget" })
							SendNUIMessage({ action = "setVisible",data = false })
						end
					end
				end

				if GetEntityType(entity) ~= 0 then
					if IsEntityAVehicle(entity) then
						local Menu,updatedSelected = Config.vehiclesOptions(entity,coords,entCoords,Selected)
						if Menu and updatedSelected then 
							Selected = updatedSelected
							SendNUIMessage({ action = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.9 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ action = "leftTarget" })
						end
					elseif IsPedAPlayer(entity) then
						local Menu,updatedSelected = Config.playerOptions(entity,coords,entCoords,Selected)
						if Menu and updatedSelected then
							Selected = updatedSelected
							SendNUIMessage({ action = "validTarget", data = Menu })

							Sucess = true
							while Sucess do
								local ped = PlayerPedId()
								local coords = GetEntityCoords(ped)
								local _,entCoords,entity = RayCastGamePlayCamera()

								if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
									SetCursorLocation(0.5,0.5)
									SetNuiFocus(true,true)
								end

								if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.8 then
									Sucess = false
								end

								Wait(1)
							end

							SendNUIMessage({ action = "leftTarget" })
							SendNUIMessage({ action = "setVisible",data = false })
						end
					else
						for k,v in pairs(Models) do
							if DoesEntityExist(entity) then
								if k == GetEntityModel(entity) then
									if #(coords - entCoords) <= Models[k]["distance"] then
										local objNet = nil
										if NetworkGetEntityIsNetworked(entity) then
											objNet = ObjToNet(entity)
										end

										Selected = { entity,k,objNet,GetEntityCoords(entity) }

										SendNUIMessage({ action = "validTarget", data = Models[k]["options"] })

										Sucess = true
										while Sucess do
											local ped = PlayerPedId()
											local coords = GetEntityCoords(ped)
											local _,entCoords,entity = RayCastGamePlayCamera()

											if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
												SetCursorLocation(0.5,0.5)
												SetNuiFocus(true,true)
											end

											if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
												Sucess = false
											end

											Wait(1)
										end


										SendNUIMessage({ action = "leftTarget" })
										SendNUIMessage({ action = "setVisible",data = false })
									end
								end
							end
						end
					end
				end
			end

			Wait(100)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local bedAttach = false
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 },
	[-935625561] = { 0.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(Selected[1])

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[Selected[2]][1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(Selected[1]) + beds[Selected[2]][2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if Selected[2] == -935625561 then
				AttachEntityToEntity(ped,Selected[1],11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = Selected[1]
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:Treatment")
AddEventHandler("target:Treatment",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		
		if coreP.checkParamedicServices() then 
			return 
		end
		if GetEntityHealth(ped) > 101 then
			if coreP.tryTreatmentPayment() then 
				LocalPlayer["state"]["Cancel"] = true
				LocalPlayer["state"]["Commands"] = true
				local objCoords = GetEntityCoords(Selected[1])

				SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[Selected[2]][1],1,0,0,0)
				SetEntityHeading(ped,GetEntityHeading(Selected[1]) + beds[Selected[2]][2] - 180.0)

				vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

				if Selected[2] == -935625561 then
					AttachEntityToEntity(ped,Selected[1],11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
					bedAttach = Selected[1]
				end
				TriggerEvent('checkin:startTreatment')
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDPICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedPickup")
AddEventHandler("target:bedPickup",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local spawnObjects = 0
			local uObject = NetworkGetEntityFromNetworkId(Selected[3])
			local objectControl = NetworkRequestControlOfEntity(uObject)
			while not objectControl and spawnObjects <= 1000 do
				objectControl = NetworkRequestControlOfEntity(uObject)
				spawnObjects = spawnObjects + 1
				Citizen.Wait(1)
			end

			AttachEntityToEntity(uObject,ped,11816,0.0,1.25,-0.15,0.0,0.0,0.0,false,false,false,false,2,true)
			bedAttach = Selected[1]
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDETACH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDetach")
AddEventHandler("target:bedDetach",function()
	if bedAttach then
		DetachEntity(PlayerPedId(),false,false)
		FreezeEntityPosition(bedAttach,true)
		DetachEntity(bedAttach,false,false)
		bedAttach = false
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:BEDDESTROY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:bedDestroy")
AddEventHandler("target:bedDestroy",function()
	if not LocalPlayer["state"]["Commands"] and LocalPlayer["state"]["Paramedic"] then
		TriggerServerEvent("tryDeleteObject",Selected[3])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)

			if k == -935625561 then
				AttachEntityToEntity(ped,object,11816,0.0,0.0,1.0,0.0,0.0,0.0,false,false,false,false,2,true)
				bedAttach = object
			end

			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	if not LocalPlayer["state"]["Commands"] and not LocalPlayer["state"]["Handcuff"] then
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 101 then
			local objCoords = GetEntityCoords(Selected[1])

			FreezeEntityPosition(Selected[1],true)
			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[Selected[2]],1,0,0,0)
			if chairs[Selected[2]] == 0.7 then
				SetEntityHeading(ped,GetEntityHeading(Selected[1]))
			else
				SetEntityHeading(ped,GetEntityHeading(Selected[1]) - 180.0)
			end

			vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if Sucess or not LocalPlayer["state"]["Target"] then
		return
	end

	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ action = "closeTarget" })
	SendNUIMessage({ action = "setVisible",data = false })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback('selectTarget', function(data2, cb)
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ action = "closeTarget" })
	SendNUIMessage({ action = "setVisible",data = false })
	local data = data2.selectedItem

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],Selected)
	elseif data["tunnel"] == "shopserver" then
		TriggerServerEvent(data["event"],Selected)
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],Selected[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],Selected,data["service"])
	elseif data["tunnel"] == "products" then
		TriggerServerEvent(data["event"],data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],Selected[3])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ action = "closeTarget" })
	SendNUIMessage({ action = "setVisible", data = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	Sucess = false
	SetNuiFocus(false,false)
	LocalPlayer["state"]["Target"] = false
	SendNUIMessage({ action = "closeTarget" })
	SendNUIMessage({ action = "setVisible", data = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCOORDSFROMCAM
-----------------------------------------------------------------------------------------------------------------------------------------
function GetCoordsFromCam(Distance,Coords)
	local rotation = GetGameplayCamRot()
	local adjustedRotation = vector3((math.pi / 180) * rotation["x"],(math.pi / 180) * rotation["y"],(math.pi / 180) * rotation["z"])
	local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])),math.sin(adjustedRotation[1]))

	return vector3(Coords[1] + direction[1] * Distance, Coords[2] + direction[2] * Distance, Coords[3] + direction[3] * Distance)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera()
	local Ped = PlayerPedId()
	local Cam = GetGameplayCamCoord()
	local Cam2 = GetCoordsFromCam(10.0,Cam)
	local Handle = StartExpensiveSynchronousShapeTestLosProbe(Cam,Cam2,-1,Ped,4)
	local a,Hit,Coords,b,Entity = GetShapeTestResult(Handle)

	return Hit,Coords,Entity
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(Name,Center,Radius,Options,Target)
	Zones[Name] = CircleZone:Create(Center,Radius,Options)
	Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(Name)
	if Zones[Name] then
		Zones[Name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(Model,Options)
	for _,v in pairs(Model) do
		Models[v] = Options
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Text)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Text
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDBOXZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddBoxZone(Name,Center,Length,Width,Options,Target)
    Zones[Name] = BoxZone:Create(Center,Length,Width,Options)
    Zones[Name]["targetoptions"] = Target
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddBoxZone",AddBoxZone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)