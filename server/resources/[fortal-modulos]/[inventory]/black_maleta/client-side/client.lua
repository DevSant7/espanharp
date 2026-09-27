-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("black_maleta",cRP)
serverAPI = Tunnel.getInterface("black_maleta")

local briefcaseId = nil 
local isProcessingMove = false -- Flag para evitar múltiplas chamadas
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTFOCUS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("invClose",function(data, cb)
	SendNUIMessage({ action = "setVisibility", data = false })
	SetNuiFocus(false,false)
	vRP.removeObjects()
	briefcaseId = nil
	isProcessingMove = false
	cb("ok")
end)

RegisterNUICallback("removeFocus",function(data, cb)
	SendNUIMessage({ action = "setVisibility", data = false })
	SetNuiFocus(false,false)
	vRP.removeObjects()
	briefcaseId = nil
	isProcessingMove = false
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BRIEFCASE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("briefcase:open")
AddEventHandler("briefcase:open",function(id)
	

	if not id then
		id = "temp_" .. GetGameTimer()
	end
	
	briefcaseId = tostring(id)
	isProcessingMove = false

	SetNuiFocus(true,true)
	SendNUIMessage({ action = "setColor", data = "60, 142, 220"})
	SendNUIMessage({ action = "setVisibility", data = true })

	CreateThread(function()
		Wait(200) 

		
		local success, myInventory, myChest, invPeso, invMaxpeso, chestPeso, chestMaxpeso, maxSlots, isVip = pcall(serverAPI.openBriefCase, briefcaseId)
		
		if success and myInventory then

			local inventoryData = {}
			for k, v in pairs(myInventory) do
				inventoryData[tostring(v.slot)] = {
					id = tostring(v.slot),
					key = v.key or "",
					item = v.item or "",
					peso = v.peso or 0,
					name = v.name or "Item",
					amount = v.amount or 1,
					image = v.url or "",
					description = v.desc or "",
					type = v.type or "item",
					days = v.days or 1,
					durability = v.durability or 0
				}
			end
			SendNUIMessage({ action = "updateBackpack", data = inventoryData })

			local chestData = {}
			for k, v in pairs(myChest) do
				if v.slot >= 1 and v.slot <= 6 then
					local slotKey = tostring(v.slot) -- Usar slot direto (1-6)
					chestData[slotKey] = {
						id = slotKey,
						key = v.key or "",
						item = v.item or "",
						peso = v.peso or 0,
						name = v.name or "Item",
						amount = v.amount or 1,
						image = v.url or "",
						description = v.desc or "",
						type = v.type or "item",
						days = v.days or 1,
						durability = v.durability or 0
					}
				end
			end
			SendNUIMessage({ action = "updateDrop", data = chestData })

			SendNUIMessage({ 
				action = "setProfile", 
				data = {
					name = "",
					id = 0,
					dollar = 0,
					bank = 0,
					image = "",
					weight = invPeso or 0,
					maxWeight = invMaxpeso or 100,
					suitCaseWeight = chestPeso or 0,
					suitCaseMaxWeight = chestMaxpeso or 100
				}
			})

			SendNUIMessage({ 
				action = "setInfo", 
				data = {
					slot = maxSlots or 35,
					show = isVip or false
				}
			})
		else
			SendNUIMessage({ action = "updateBackpack", data = {} })
			SendNUIMessage({ action = "updateDrop", data = {} })
			SendNUIMessage({ 
				action = "setProfile", 
				data = {
					name = "",
					id = 0,
					dollar = 0,
					bank = 0,
					image = "",
					weight = 0,
					maxWeight = 100,
					suitCaseWeight = 0,
					suitCaseMaxWeight = 100
				}
			})
			SendNUIMessage({ 
				action = "setInfo", 
				data = {
					slot = 35,
					show = false
				}
			})
		end
	end)
end) 

-- Comando para testar a abertura da maleta
RegisterCommand("testbriefcase", function()
	TriggerEvent("briefcase:open", "test123")
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("takeItem",function(data, cb)
	if MumbleIsConnected() and briefcaseId then
		serverAPI.takeItem(data["item"], data["slot"], data["amount"], data["target"], briefcaseId)
	end
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("storeItem",function(data, cb)
	if MumbleIsConnected() and briefcaseId then
		serverAPI.storeItem(data["item"], data["slot"], data["amount"], data["target"], briefcaseId)
	end
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVE ITEMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("moveInventoryItem",function(data, cb)
    if isProcessingMove then
        cb("ok")
        return
    end

    if MumbleIsConnected() and briefcaseId then
        isProcessingMove = true

        CreateThread(function()
            local success = serverAPI.moveInventoryItem(data["fromSlot"], data["toSlot"], data["amount"], data["item"], briefcaseId)
            Wait(200)
            isProcessingMove = false
        end)
    end
    cb("ok")
end)

RegisterNUICallback("moveBriefcaseItem",function(data, cb)
    if isProcessingMove then
        cb("ok")
        return
    end

    if MumbleIsConnected() and briefcaseId then
        isProcessingMove = true

        CreateThread(function()
            local success = serverAPI.moveBriefcaseItem(data["fromSlot"], data["toSlot"], data["amount"], data["item"], briefcaseId)
            Wait(200)
            isProcessingMove = false
        end)
    end
    cb("ok")
end)

RegisterNUICallback("useItem",function(data, cb)
	cb("ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Profile",function(data,cb)
	local userProfile = serverAPI.getUserProfile()
	cb(userProfile)
end) 

RegisterNUICallback("requestInventoryAndBriefCase",function(data,cb)
	if briefcaseId then
		local success, myInventory,myChest,invPeso,invMaxpeso,chestPeso,chestMaxpeso,maxSlots,isVip = pcall(serverAPI.openBriefCase, briefcaseId)
		if success and myInventory then
			cb({ 
				chest = myChest, 
				chestPeso = chestPeso, 
				chestMaxpeso = chestMaxpeso,
				inventario = myInventory,
				invPeso = invPeso,
				invMaxpeso = invMaxpeso,
				maxSlots = maxSlots,
				isVip = isVip
			})
		else
			cb({})
		end
	else
		cb({})
	end
end)

RegisterNetEvent("briefcase:Update")
AddEventHandler("briefcase:Update",function(action)
	SendNUIMessage({ action = action })
end)

RegisterNetEvent("briefcase:UpdateWeight")
AddEventHandler("briefcase:UpdateWeight",function(invPeso,invMaxpeso,chestPeso,chestMaxpeso)
	SendNUIMessage({ 
		action = "setProfile", 
		data = {
			name = "",
			id = 0,
			dollar = 0,
			bank = 0,
			image = "",
			weight = invPeso or 0,
			maxWeight = invMaxpeso or 100,
			suitCaseWeight = chestPeso or 0,
			suitCaseMaxWeight = chestMaxpeso or 100
		}
	})
end)

RegisterNetEvent("briefcase:UpdateInventory")
AddEventHandler("briefcase:UpdateInventory",function(inventory, maxSlots, isVip)
	local inventoryData = {}
	for k, v in pairs(inventory or {}) do
		inventoryData[tostring(v.slot)] = {
			id = tostring(v.slot),
			key = v.key or "",
			item = v.item or "",
			peso = v.peso or 0,
			name = v.name or "Item",
			amount = v.amount or 1,
			image = v.url or "",
			description = v.desc or "",
			type = v.type or "item",
			days = v.days or 1,
			durability = v.durability or 0
		}
	end
	SendNUIMessage({ action = "updateBackpack", data = inventoryData })
	
	SendNUIMessage({ 
		action = "setInfo", 
		data = {
			slot = maxSlots or 35,
			show = isVip or false
		}
	})
end)

RegisterNetEvent("briefcase:UpdateChest")
AddEventHandler("briefcase:UpdateChest",function(chest)
	local chestData = {}
	for k, v in pairs(chest or {}) do
		if v.slot >= 1 and v.slot <= 6 then
			local slotKey = tostring(v.slot) -- Usar slot direto (1-6)
			chestData[slotKey] = {
				id = slotKey,
				key = v.key or "",
				item = v.item or "",
				peso = v.peso or 0,
				name = v.name or "Item",
				amount = v.amount or 1,
				image = v.url or "",
				description = v.desc or "",
				type = v.type or "item",
				days = v.days or 1,
				durability = v.durability or 0
			}
		end
	end
	SendNUIMessage({ action = "updateDrop", data = chestData })
end)
