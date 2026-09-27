-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnVRP = {}
Tunnel.bindInterface("desmanche",cnVRP)
vDISM = Tunnel.getInterface("desmanche")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local timeDismantle = 0

local dismantleCds = {
	{ 759.43,667.34,107.18 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(dismantleCds) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 3.0 then
					timeDistance = 4
					dwText("~g~E~w~  DESMANCHAR UM VEÍCULO",0.93)
					if IsControlJustPressed(1,38) and timeDismantle <= 0 and vDISM.checkItem() and vDISM.checkPermission() then
						timeDismantle = 3
						local status,vehicle = vDISM.checkVehlist()
						if status then
							TriggerEvent("Notify", "verde", "Iniciando desmanche...", 5000)
							TaskTurnPedToFaceEntity(ped,vehicle,1000)
							Citizen.Wait(100)
							FreezeEntityPosition(ped,false)
							TriggerEvent("player:blockCommands",true)
							FreezeEntityPosition(vehicle,true)

							vRP.playAnim(false, {{"amb@medic@standing@tendtodead@idle_a" , "idle_a"}}, true)
							vRP._playAnim(false,{task='WORLD_HUMAN_WELDING'},true)

							for i = 0,4 do
								Citizen.Wait(math.random(2000,8000))
								SetVehicleDoorBroken(vehicle,i,false)
								TriggerEvent("Notify","amarelo","Peça removida.",5000)
							end

							for i = 0,5 do
								Citizen.Wait(math.random(2000,8000))
								SetVehicleTyreBurst(vehicle,i,1,1000.01)
								TriggerEvent("Notify","amarelo","Peça removido.",5000)
							end
							vRP.removeObjects()
							SetVehicleEngineHealth(vehicle, 150.0)
							SetVehicleFuelLevel(vehicle, 0.0)
							SetEntityInvincible(ped,false)
							FreezeEntityPosition(ped,false)
							TriggerEvent("player:blockCommands",false)
							vDISM.paymentMethod()
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if timeDismantle > 0 then
			timeDismantle = timeDismantle - 1
		end
		Citizen.Wait(1000)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function dwText(text,height)
	SetTextFont(4)
	SetTextScale(0.50,0.50)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.5,height)
end