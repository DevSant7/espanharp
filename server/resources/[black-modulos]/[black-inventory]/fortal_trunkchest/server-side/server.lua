-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("trunkchest",cRP)
vCLIENT = Tunnel.getInterface("trunkchest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehChest = {}
local vehNames = {}
local vehWeight = {}

vRP.prepare("createPhoto", [[ALTER TABLE characters ADD IF NOT EXISTS (photo LONGTEXT)]])
vRP.prepare("getPhoto", "SELECT photo FROM characters WHERE id = @id")
vRP.prepare("updatePhoto", "UPDATE characters SET photo = @photo WHERE id = @id")
CreateThread(function()
	vRP.execute("createPhoto")
end)

function cRP.getUserProfile()
	local source = source 
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	local photo = vRP.execute("getPhoto", { id = user_id })[1]
	if user_id then 
		return { 
			name = identity["name"],
			name2 = identity["name2"],
			passport = user_id,
			register = identity["serial"],
			phone = identity["phone"], 
			photo = photo.photo,
			bank = identity["bank"],
			wallet = vRP.userGemstone(user_id),
		}
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName = vRPC.vehList(source,3)
		if vehicle then
			local userPlate = vRP.userPlate(vehPlate)
			if not userPlate then
				userPlate = {["user_id"] = vehPlate}
			end
			if userPlate then
				if vRPC.inVehicle(source) then
					vehWeight[user_id] = 7
					vehChest[user_id] = "vehGloves:"..userPlate["user_id"]..":"..vehName
				else
					vehWeight[user_id] = parseInt(vehicleChest(vehName))
					vehChest[user_id] = "vehChest:"..userPlate["user_id"]..":"..vehName
				end

				vehNames[user_id] = vehName

				local myInventory = {}
				local inventory = vRP.userInventory(user_id)
				for k,v in pairs(inventory) do
					v["id"] = ""
					v["key"] = v["item"]
					v["peso"] = itemWeight(v["item"])
					v["name"] = itemName(v["item"])
					v["amount"] = parseInt(v["amount"])
					v["description"] = itemDescription(v["item"])
					v["image"] = Config.imagesProvider..itemIndex(v["item"])..".png"
				
					local splitName = splitString(v["item"],"-")
					if splitName[2] ~= nil then
						if itemDurability(v["item"]) then
							v["durability"] = parseInt(os.time() - splitName[2])
							v["days"] = itemDurability(v["item"])
						else
							v["durability"] = 0
							v["days"] = 1
						end
					else
						v["durability"] = 0
						v["days"] = 1
					end
				
					myInventory[tostring(k)] = v 
				end

				local myChest = {}
				local result = vRP.getSrvdata(vehChest[user_id])
				for k,v in pairs(result) do
					v["id"] = ""
					v["key"] = v["item"]
					v["peso"] = itemWeight(v["item"])
					v["name"] = itemName(v["item"])
					v["amount"] = parseInt(v["amount"])
					v["description"] = itemDescription(v["item"])
					v["image"] = Config.imagesProvider..itemIndex(v["item"])..".png"
						
					local splitName = splitString(v["item"],"-")
					if splitName[2] ~= nil then
						if itemDurability(v["item"]) then
							v["durability"] = parseInt(os.time() - splitName[2])
							v["days"] = itemDurability(v["item"])
						else
							v["durability"] = 0
							v["days"] = 1
						end
					else
						v["durability"] = 0
						v["days"] = 1
					end

					myChest[tostring(parseInt(k + 40))] = v 
				end

				local identity = vRP.userIdentity(user_id)
				return myInventory,myChest,parseInt(vRP.inventoryWeight(user_id)),vRP.getWeight(user_id),parseInt(vRP.chestWeight(result)),parseInt(vehWeight[user_id])
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if tonumber(slot) < 41 and tonumber(target) < 41 then 
			vRP.invUpdate(user_id, slot, target, amount)
			TriggerClientEvent("trunkchest:Update",source)
		else
			vRP.updateChest(user_id,vehChest[user_id],slot,target,amount)
			TriggerClientEvent("trunkchest:Update",source)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehName = vehNames[user_id]

		target = target - 40 
		if Config.vehStore[vehName] then
			if not Config.vehStore[vehName][nameItem] then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"important","Atenção","Armazenamento proibido.","amarelo",5000)
				return
			end
		end

		if (vehName == "mule" or vehName == "benson" or vehName == "pounder" or vehName == "youga2") then
			if nameItem == "dollars" then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"important","Atenção","Armazenamento proibido.","amarelo",5000)
				return
			end
		else
			if Config.blockedItens[nameItem] and not Config.blockedItens[vehName] then
				TriggerClientEvent("trunkchest:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"important","Atenção","Armazenamento proibido.","amarelo",5000)
				return
			end
		end

		if vRP.storeChest(user_id, vehChest[user_id], amount, parseInt(vehWeight[user_id]), slot, target) then
		else
			local result = vRP.getSrvdata(vehChest[user_id])
			TriggerClientEvent("trunkchest:UpdateWeight", source, vRP.inventoryWeight(user_id), vRP.getWeight(user_id), vRP.chestWeight(result), parseInt(vehWeight[user_id]))
			local identity = vRP.userIdentity(user_id)
			local embed = {
				{
					["color"] = 65280,
					["title"] = "📦 Item Armazenado",
					["description"] = "**Usuário:** " .. identity.name .. " " .. identity.name2 .. " (ID: " .. user_id .. ")\n" ..
									  "**Item:** " .. nameItem .. " \n" ..
									  "**Quantidade:** " .. amount .. "\n" ..
									  "**Veículo:** " .. (vehName or "Desconhecido") .. "\n" ..
									  "**Baú:** " .. (vehChest[user_id] or "N/A"),
					["footer"] = {
						["text"] = os.date("Log gerado em %d/%m/%Y às %H:%M:%S")
					}
				}
			}
		
			PerformHttpRequest("https://discord.com/api/webhooks/1367478840451928074/Cg4eSLmCze68pH3wk_R58SIvPvxACGaYZdISwAtPuZ6xShnC_0Ef66v7VxB7IiJkL78l", function(err, text, headers) end, "POST", json.encode({ embeds = embed }), { ["Content-Type"] = "application/json" })
		end
		
		TriggerClientEvent("trunkchest:Update",source,"requestChest")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(slot, amount, target)
	local source = source
	local user_id = vRP.getUserId(source)

	slot = slot - 40 
	if user_id then
		if vRP.tryChest(user_id, vehChest[user_id], amount, slot, target) then
		else
			local result = vRP.getSrvdata(vehChest[user_id])
			TriggerClientEvent("trunkchest:UpdateWeight", source, vRP.inventoryWeight(user_id), vRP.getWeight(user_id), vRP.chestWeight(result), parseInt(vehWeight[user_id]))
		end
		TriggerClientEvent("trunkchest:Update", source, "requestChest")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTCLOSE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.chestClose()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet = vRPC.vehList(source,3)
		if vehicle then
			if not vRPC.inVehicle(source) then
				local activePlayers = vRPC.activePlayers(source)
				for _,v in ipairs(activePlayers) do
					async(function()
						TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"close")
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRUNKCHEST:OPENTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("trunkchest:openTrunk")
AddEventHandler("trunkchest:openTrunk",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName,vehBlock,vehHealth = vRPC.vehList(source,5)
		if vehicle then
			local idNetwork = NetworkGetEntityFromNetworkId(vehNet)
			local doorStatus = GetVehicleDoorLockStatus(idNetwork)
		
			if parseInt(doorStatus) <= 1 then
				if not vehBlock and parseInt(vehHealth) > 0 then
					if not vRPC.inVehicle(source) then
						local activePlayers = vRPC.activePlayers(source)
						for _,v in ipairs(activePlayers) do
							async(function()
								TriggerClientEvent("player:syncDoorsOptions",v,vehNet,"open")
							end)
						end
					end
					vCLIENT.trunkOpen(source)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect",function(user_id)
	if vehNames[user_id] then
		vehNames[user_id] = nil
	end

	if vehChest[user_id] then
		vehChest[user_id] = nil
	end

	if vehWeight[user_id] then
		vehWeight[user_id] = nil
	end
end)