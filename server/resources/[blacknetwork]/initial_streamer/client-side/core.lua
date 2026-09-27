-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("initial_streamer")
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("int", function()
	TriggerEvent("initial_streamer:Open")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITIAL:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("initial_streamer:Open")
AddEventHandler("initial_streamer:Open", function()
	if vSERVER.CheckInit() then
		if (#Vehicles >= MaxVehicles) then
			print("Voce excedeu o limite de carro: " .. MaxVehicles)
			return
		end
		SetNuiFocus(true, true)
		SetCursorLocation(0.5, 0.5)
		SendNUIMessage({ cars = Vehicles })
		SendNUIMessage({ open = true })
	end
end)

RegisterNetEvent("initial_streamer:close")
AddEventHandler("initial_streamer:close", function()
	SetNuiFocus(false, false)
	SendNUIMessage({ open = false })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save", function(Data, Callback)
	SetNuiFocus(false, false)
	vSERVER.Save(Data["Name"])
	TriggerEvent("hud:Active", true)
	Callback("Save")
end)
