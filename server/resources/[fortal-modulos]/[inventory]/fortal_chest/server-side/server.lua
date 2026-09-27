-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("chest",cRP)

local webPolice = "https://discord.com/api/webhooks/1053746428217938052/sVCTTJckhwSfKb4Ken10hwo4w7yT4PMYHZZ95JJoUkfzn4msu3cWSTW31uQmzcGnfOa_"
local webBennys = "https://discord.com/api/webhooks/1001197749422805093/TCYWUEtzUH4F1dBKPlP--MGJ8NfqZ609SAtGXKFfR-27gPQmqXkYPiEEhUe9LK6fajrO"
local Verdes = "https://discord.com/api/webhooks/1005301334934818897/_b2tVJ31ZO9lNj7TGgz_mE-haXEOZdKZ4-rM0DMTEvoBSCOJDdmyW5yTxK9jTjg6VOjK"

vRP.prepare("createPhoto", [[ALTER TABLE characters ADD IF NOT EXISTS (photo LONGTEXT)]])
vRP.prepare("getPhoto", "SELECT photo FROM characters WHERE id = @id")
vRP.prepare("updatePhoto", "UPDATE characters SET photo = @photo WHERE id = @id")
CreateThread(function()
	vRP.execute("createPhoto")
end)

function updateChests()
	local data = {}
	local query = vRP.query("black/getChests")

	for _,v in pairs(Config.chestCoords) do 
		table.insert(data,{v[1],v[2],v[3],v[4],v[5]})
	end 

	if #query > 0 then 
		for _,v in pairs(query) do 
			if v.coords then 
				local coordsData = json.decode(v.coords)

				table.insert(data,{v.name,coordsData.x,coordsData.y,coordsData.z,"1"})
			end 
		end 	
	end
	return data 
end

RegisterNetEvent("chest:trySyncChests")
AddEventHandler("chest:trySyncChests",function()
	local data = updateChests()

	TriggerClientEvent("chest:syncChests",-1,data)
end) 

cRP.getChests = updateChests

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVIPSLOTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkVipSlots()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for _, group in pairs(Config.vipGroups) do
			if vRP.hasGroup(user_id, group) then
				return true
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- GETCHESTSLOTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getChestSlots(chestName)
	-- Retorna a quantidade de slots configurada para o baú ou o padrão
	return Config.chestSlots[chestName] or Config.defaultChestSlots
end

--[[
	name: string;
	name2: string;
	passport: number;
	register: string;
	phone: string;
	photo: string
]]

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
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if chestName == "trayBurgerShot" or chestName == "trayUwuCaffe" or chestName == "trayUwuCaffe2" or chestName == "trayPops" or chestName == "trayPizza" then
			return true
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
		 	local perm = consultChest[1]["perm"]
			local level = consultChest[1]["level"]

			level = level and tonumber(level)

			if vRP.hasGroup(user_id, perm, level) then
				return true
			end
		end
	end

	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.upgradeSystem(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] then
			local upgradePrice = 10000

			if vRP.hasGroup(user_id,consultChest[1]["perm"]) then
				if vRP.request(source,"Aumentar <b>25Kg</b> por <b>$"..parseFormat(upgradePrice).."</b> dólares?","Comprar") then
					if vRP.paymentFull(user_id,upgradePrice) then
						vRP.execute("chests/upgradeChests",{ name = chestName })
						TriggerClientEvent("Notify",source,"verde","Compra concluída.",3000)
					else
						TriggerClientEvent("Notify",source,"vermelho","<b>Dólares</b> insuficientes.",5000)
					end
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
--[[
	amount: number;
	slot: number;
	type: "item" | "weapon";
	key?: string;
	index: string;
	name: string;
  	item: string;
  	peso: number
  	durability?: number;
  	id?: string | undefined;
  	url?: string | undefined;
  	days?: number;
]]

function cRP.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then return end

	local result = vRP.getSrvdata("stackChest:"..chestName) or {}
	if type(result) == "string" then
		result = json.decode(result) or {}
	end

	local myChest = {}
	for k,v in pairs(result) do
		v["id"] = ""
		v["key"] = v["item"]
		v["peso"] = itemWeight(v["item"])
		v["name"] = itemName(v["item"])
		v["amount"] = parseInt(v["amount"])
		v["description"] = itemDescription(v["item"])
		local itemImg = itemIndex(v["item"])
		v["image"] = itemImg and Config.imagesProvider..itemImg..".png" or Config.imagesProvider.."default.png"

		local splitName = splitString(v["item"],"-")
		if splitName[2] ~= nil and itemDurability(v["item"]) then
			v["durability"] = parseInt(os.time() - splitName[2])
			v["days"] = itemDurability(v["item"])
		else
			v["durability"] = 0
			v["days"] = 1
		end

		myChest[tostring(k)] = v
	end

	local myInventory = {}
	local inventory = vRP.userInventory(user_id)
	for k,v in pairs(inventory) do
		v["id"] = ""
		v["key"] = v["item"]
		v["peso"] = itemWeight(v["item"])
		v["name"] = itemName(v["item"])
		v["amount"] = parseInt(v["amount"])
		v["description"] = itemDescription(v["item"])
		v["image"] = Config.imagesProvider..(itemIndex(v["item"]) or "default")..".png"

		local splitName = splitString(v["item"],"-")
		if splitName[2] ~= nil and itemDurability(v["item"]) then
			v["durability"] = parseInt(os.time() - splitName[2])
			v["days"] = itemDurability(v["item"])
		else
			v["durability"] = 0
			v["days"] = 1
		end

		myInventory[tostring(k)] = v
	end

	local hasVipSlots = false
	for _, group in pairs(Config.vipGroups) do
		if vRP.hasGroup(user_id, group) then
			hasVipSlots = true
			break
		end
	end

	local chestSlots = Config.chestSlots[chestName] or Config.defaultChestSlots

	if string.find(chestName, "AirDrop") then
		return myChest, parseInt(vRP.chestWeight(result)), 5000, myInventory, parseInt(vRP.inventoryWeight(user_id)), vRP.getWeight(user_id), hasVipSlots, chestSlots
	end

	local consultChest = vRP.query("chests/getChests",{ name = chestName })
	if consultChest[1] then
		return myChest, parseInt(vRP.chestWeight(result)), consultChest[1]["weight"], myInventory, parseInt(vRP.inventoryWeight(user_id)), vRP.getWeight(user_id), hasVipSlots, chestSlots
	end
end




-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerEvent('felipeex:AddChestItem', source, amount, itemName(nameItem), chestName)
	if user_id then
		if chestName ~= "trayBurgerShot" and chestName == "trayUwuCaffe" and chestName == "trayUwuCaffe2" and chestName ~= "trayPops" and chestName ~= "trayPizza" then
			if Config.blockedItens[nameItem] then
				TriggerClientEvent("chest2:Update",source,"requestChest")
				TriggerClientEvent("Notify",source,"amarelo","Armazenamento proibido.",5000)
				return
			end
		end

		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] or string.find(chestName, "AirDrop") then
			if vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],slot,target) then
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				if not consultChest[1] then
					consultChest = {}
					consultChest[1] = {["weight"] = 5000}
				end
				TriggerClientEvent("chest2:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])
				Utils.functions.sendLog(chestName,user_id,nameItem,amount)
				exports["black_groups"]:saveChestLogs(user_id, chestName, 'enter', itemName(nameItem), amount)
			end
			TriggerClientEvent("chest2:Update",source,"requestChest")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	TriggerEvent('felipeex:removeChestItem', source, amount, itemName(nameItem), chestName)

	if user_id then
		local consultChest = vRP.query("chests/getChests",{ name = chestName })
		if consultChest[1] or string.find(chestName, "AirDrop") then
			if vRP.tryChest(user_id,"stackChest:"..chestName,amount,slot,target) then
			else
				local result = vRP.getSrvdata("stackChest:"..chestName)
				if not consultChest[1] then
					consultChest = {}
					consultChest[1] = {["weight"] = 5000}
				end
				TriggerClientEvent("chest2:UpdateWeight",source,vRP.inventoryWeight(user_id),vRP.getWeight(user_id),vRP.chestWeight(result),consultChest[1]["weight"])
				Utils.functions.sendLog(chestName,user_id,nameItem,amount)
				exports["black_groups"]:saveChestLogs(user_id, chestName, 'leave', itemName(nameItem), amount)
			end
			TriggerClientEvent("chest2:Update",source,"requestChest")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount,chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if tonumber(slot) < 41 and tonumber(target) < 41 then 
			vRP.invUpdate(user_id, slot, target, amount)
			TriggerClientEvent("chest2:Update",source,"requestChest")
		else
			if vRP.updateChest(user_id,"stackChest:"..chestName,slot,target,amount) then
			end
			TriggerClientEvent("chest2:Update",source,"requestChest")
		end
	end
end
