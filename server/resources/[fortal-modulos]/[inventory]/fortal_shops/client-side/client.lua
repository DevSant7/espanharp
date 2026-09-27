-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops", cRP)
vSERVER = Tunnel.getInterface("shops")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("close", function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({ action = "hideNUI" })
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVE FOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("removeFocus", function(data, cb)
	SetNuiFocus(false, false)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Profile
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Profile", function(_, cb)
	local profile = vSERVER.getUserProfile()
	if profile then
		cb(profile)
	else
		cb({
			name = "Unknown",
			id = 0,
			image = "",
			bank = 0,
			dollar = 0,
			weight = 0,
			maxWeight = 100,
			chestWeight = 0,
			chestMaxWeight = 100
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("requestShop", function(data, cb)
	local shop = data["shop"] or "Departament"
	local inventoryShop, inventoryUser, invPeso, invMaxpeso, shopSlots, vipSlots, isVip = vSERVER.requestShop(shop)
	
	if inventoryShop and inventoryUser then
		cb({
			inventoryShop = inventoryShop,
			inventoryUser = inventoryUser,
			invPeso = invPeso or 0,
			invMaxpeso = invMaxpeso or 100, 
			shopSlots = shopSlots or 20,
			vipSlots = vipSlots or 35,
			isVip = isVip or false
		})
	else
		cb({
			inventoryShop = {},
			inventoryUser = {},
			invPeso = 0,
			invMaxpeso = 100,
			shopSlots = 20,
			vipSlots = 35,
			isVip = false
		})
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("useItem", function(data, cb)
	if MumbleIsConnected() then
		-- Usar o tipo de loja correto baseado no contexto atual
		local currentShop = GetResourceKvpString("currentShopType") or "Departament"
		local result = vSERVER.functionShops(currentShop, data["item"] or "", data["amount"] or 1, data["slot"] or "1", "use")
		cb(result or "ok")
	else
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BUY ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("buyItem", function(data, cb)
	print("=== BUY ITEM CALLBACK ===")
	print("Data recebida:", json.encode(data))
	print("MumbleIsConnected:", MumbleIsConnected())
	
	if MumbleIsConnected() then
		-- Usar o tipo de loja correto baseado no contexto atual
		local currentShop = GetResourceKvpString("currentShopType") or "Departament"
		print("Loja atual:", currentShop)
		
		local result = vSERVER.functionShops(currentShop, data["item"] or "", data["amount"] or 1, data["slot"] or "1", "buy")
		print("Resultado do servidor:", result)
		print("Tipo do resultado:", type(result))
		cb(result or "ok")
	else
		print("Mumble não conectado!")
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELL ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sellItem", function(data, cb)
	if MumbleIsConnected() then
		-- Usar o tipo de loja correto baseado no contexto atual
		local currentShop = GetResourceKvpString("currentShopType") or "Departament"
		local result = vSERVER.functionShops(currentShop, data["item"] or "", data["amount"] or 1, data["slot"] or "1", "sell")
		cb(result or "ok")
	else
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEND ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("sendItem", function(data, cb)
	if MumbleIsConnected() then
		cb("ok")
	else
		cb("error")
	end
end)

RegisterNetEvent("shop:Update")
AddEventHandler("shop:Update", function()
	SendNUIMessage({ action = "update", data = "update" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("populateSlot", function(data, cb)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:populateSlot", data["item"], data["slot"], data["target"], data["amount"])
		cb("ok")
	else
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSlot", function(data, cb)
	if MumbleIsConnected() then
		TriggerServerEvent("shops:updateSlot", data["item"], data["slot"], data["target"], data["amount"])
		cb("ok")
	else
		cb("error")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:UPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateShops(action)
	SendNUIMessage({ action = action })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INFORMATIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function Informations(shopName)
	if shopName == "Ammunation" then
		return Config["shopInfos"]["1"]
	end

	if shopName == 'Fuel' then
		return Config["shopInfos"]['3']
	end

	return Config["shopInfos"]["2"]
end
------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:OPENSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:openSystem", function(shopId)
	print("=== OPENING SHOP SYSTEM ===")
	print("shopId:", shopId)
	print("shopType:", Config["shopList"][shopId][4])
	
	local shopType = Config["shopList"][shopId][4]
	
	-- Salvar o tipo de loja atual
	SetResourceKvp("currentShopType", shopType)
	
	if vSERVER.requestPerm(shopType) and MumbleIsConnected() then
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		SendNUIMessage({ action = "setColor", data = "60, 142, 220"})
		
		-- Solicitar dados da loja
		local inventoryShop, inventoryUser, invPeso, invMaxpeso, shopSlots, vipSlots, isVip = vSERVER.requestShop(shopType)
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
			SendNUIMessage({ action = "setInventory", data = { slot = vipSlots, vip = isVip, shop = shopType } })
		end
		
		SendNUIMessage({ action = "shop", data = shopType })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		if Config["shopList"][shopId][5] then
			TriggerEvent("sounds:source", "shop", 0.5)
		end
	else
		print("ERROR: Sem permissão ou Mumble desconectado")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:COFFEEMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:coffeeMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "coffeeMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("coffeeMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "coffeeMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:SODAMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:sodaMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "sodaMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("sodaMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "sodaMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:DONUTMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:donutMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "donutMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("donutMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "donutMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:BURGERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:burgerMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "burgerMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("burgerMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "burgerMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:HOTDOGMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:hotdogMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "hotdogMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("hotdogMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "hotdogMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:CHIHUAHUA
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:Chihuahua", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "Chihuahua")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("Chihuahua")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "Chihuahua" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:WATERMACHINE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:waterMachine", function()
	if MumbleIsConnected() then
		SetResourceKvp("currentShopType", "waterMachine")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("waterMachine")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "waterMachine" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOPS:MEDICBAG
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("shops:medicBag", function()
	if vSERVER.requestPerm("Paramedic") and MumbleIsConnected() then
		SetResourceKvp("currentShopType", "Paramedic")
		
		local profile = vSERVER.getUserProfile()
		if profile then
			SendNUIMessage({ action = "setProfile", data = profile })
		end
		
		local inventoryShop, inventoryUser = vSERVER.requestShop("Paramedic")
		if inventoryShop and inventoryUser then
			SendNUIMessage({ action = "updateBackpack", data = inventoryUser })
			SendNUIMessage({ action = "updateShop", data = inventoryShop })
		end
		
		SendNUIMessage({ action = "shop", data = "Paramedic" })
		SendNUIMessage({ action = "setVisibility", data = true })
		SetNuiFocus(true, true)
		TriggerEvent("sounds:source", "shop", 0.5)
	end
end)
