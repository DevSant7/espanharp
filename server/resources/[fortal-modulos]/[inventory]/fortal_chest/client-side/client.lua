-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local chestOpen = ""
local chests = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTINFOS
-----------------------------------------------------------------------------------------------------------------------------------------
local chestInfos = {
	["1"] = {
		{
			event = "chest:openSystem2",
			label = "Abrir",
			tunnel = "shop"
		},{
			event = "chest:upgradeSystem2",
			label = "Aumentar",
			tunnel = "shop"
		}
	},
	["2"] = {
		{
			event = "chest:openSystem2",
			label = "Bandeja",
			tunnel = "shop"
		}
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	chests = vSERVER.getChests()
	for k,v in pairs(chests) do
		exports["target"]:AddCircleZone("Chest:"..k,vector3(v[2],v[3],v[4]),0.5,{
			name = "Chest:"..k,
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			distance = 1.5,
			options = chestInfos[v[5]]
		})
	end
end)

RegisterNetEvent("chest:syncChests")
AddEventHandler("chest:syncChests",function(data)
	chests = data

	for k,v in pairs(chests) do
		exports["target"]:AddCircleZone("Chest:"..k,vector3(v[2],v[3],v[4]),0.5,{
			name = "Chest:"..k,
			heading = 3374176,
			useZ = true
		},{
			shop = k,
			distance = 1.5,
			options = chestInfos[v[5]]
		})
	end
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:openSystem2")
AddEventHandler("chest:openSystem2",function(shopId)
	
	if string.find(shopId, "Helicrash") or string.find(shopId, "AirDrop") then
		SetNuiFocus(true,true)
		chestOpen = shopId
		SendNUIMessage({ action = "openChest",data = true })
		vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
		return
	end

	if vSERVER.checkIntPermissions(chests[shopId][1]) and MumbleIsConnected() then
		SetNuiFocus(true,true)
		chestOpen = chests[shopId][1]
		SendNUIMessage({ action = "openChest",data = true })
		vRP.playAnim(false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest:upgradeSystem2")
AddEventHandler("chest:upgradeSystem2",function(shopId)
	if MumbleIsConnected() then
		vSERVER.upgradeSystem(chests[shopId][1])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function()
	SendNUIMessage({ action = "openChest",data = false })
	SetNuiFocus(false,false)
	chestOpen = ""
	vRP.stopAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.takeItem(data["item"],data["slot"],data["amount"],data["target"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data)
	if MumbleIsConnected() then
		vSERVER.storeItem(data["item"],data["slot"],data["amount"],data["target"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot",function(data)
	if MumbleIsConnected() then
		vSERVER.updateChest(data["slot"],data["target"],data["amount"],chestOpen)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Profile",function(data,cb)
	local userProfile = vSERVER.getUserProfile()
	cb(userProfile)
end) 

RegisterNUICallback("requestInventoryAndChest",function(data,cb)
	if chestOpen == "" then
		cb({
			chest = {},
			chestPeso = 0,
			chestMaxpeso = 100,
			inventario = {},
			invPeso = 0,
			invMaxpeso = 100,
			hasVipSlots = false,
			chestSlots = 84
		})
		return
	end
	
	local myChest,chestPeso,chestMaxpeso,myInventory,invPeso,invMaxPeso,hasVipSlots,chestSlots = vSERVER.openChest(chestOpen)
	
	if myInventory and myChest then
		local response = { 
			chest = myChest, 
			chestPeso = chestPeso, 
			chestMaxpeso = chestMaxpeso,
			inventario = myInventory,
			invPeso = invPeso,
			invMaxpeso = invMaxPeso,
			hasVipSlots = hasVipSlots or false,
			chestSlots = chestSlots or 84
		}
		cb(response)
	else
		cb({
			chest = {},
			chestPeso = 0,
			chestMaxpeso = 100,
			inventario = {},
			invPeso = 0,
			invMaxpeso = 100,
			hasVipSlots = false,
			chestSlots = 84
		})
	end
end)

RegisterNUICallback("removeFocus",function()
	SendNUIMessage({ action = "openChest",data = false })
	SetNuiFocus(false,false)
	chestOpen = ""
	vRP.stopAnim()
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest2:Update")
AddEventHandler("chest2:Update",function(action)
	SendNUIMessage({ action = action })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST:UPDATEWEIGHT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("chest2:UpdateWeight")
AddEventHandler("chest2:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ action = "updateWeight", invPeso = invPeso, invMaxpeso = invMaxpeso, chestPeso = chestPeso, chestMaxpeso = chestMaxpeso })
end)
