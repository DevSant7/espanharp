-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("fortal-inventory", cRP)
vCLIENT = Tunnel.getInterface("fortal-inventory")
vTASKBAR = Tunnel.getInterface("taskbar")


-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Drops = {}
Carry = {}
Ammos = {}
Loots = {}
Boxes = {}
Active = {}
Trashs = {}
Armors = {}
Plates = {}
Trunks = {}
Objects = {}
Healths = {}
Animals = {}
Attachs = {}
Scanners = {}
Stockade = {}
userAmount = {}

openIdentity = {}
verifyObjects = {}
verifyAnimals = {}

stealpedsList = Config["stealpedsList"]
favelasCds = Config["favelasCds"]
tableList = Config["tableList"]
stealItens = Config["stealItens"]
lootItens = Config["lootItens"]

dismantleList = {}
dismantleProgress = {}
dismantleTimer = os.time()
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLEVEHS
-----------------------------------------------------------------------------------------------------------------------------------------
dismantleVehs = Config["dismantleVehs"]
----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:TABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local tableSelect = {}

-----------------------------------------------------------------------------------------------------------------------------------------
-- PROFILE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getUserProfile()
	local source = source 
	local user_id = vRP.getUserId(source)
	local identity = vRP.userIdentity(user_id)
	local photo = vRP.execute("getPhoto", { id = user_id })[1]
	local obj = {}
	if user_id then
		obj = { 
			name = identity["name"] or "",
			name2 = identity["name2"] or "",
			passport = user_id,
			register = identity["serial"],
			phone = identity["phone"], 
			photo = photo.photo,
			bank = identity["bank"],
			wallet = vRP.userGemstone(user_id),
		} 
	end
	return obj
end

local vipGroups = {
	{ group = "Rm", slots = 48 },
	{ group = "Bronze", slots = 48 },  
	{ group = "Prata", slots = 48 },
	{ group = "Ouro", slots = 48 },
	{ group = "Diamante", slots = 48 }
}

function cRP.getVip()
	local source = source 
	local user_id = vRP.getUserId(source)

	if user_id then
		for _, data in ipairs(vipGroups) do
			if vRP.hasGroup(user_id, data.group) then
				return data.slots, true
			end
		end
	end

	return 35, false 
end


function cRP.changePhoto(url)
	local source = source
	local user_id = vRP.getUserId(source)
	vRP.execute("updatePhoto", { id = user_id, photo = url })
	TriggerClientEvent("inventory:Update", source, "updateMochila")
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local myInventory = {}
		local inventory = vRP.userInventory(user_id)
		for k, v in pairs(inventory) do
			if (parseInt(v["amount"]) <= 0 or itemBody(v["item"]) == nil) then
				vRP.removeInventoryItem(user_id, v["item"], parseInt(v["amount"]), false)
			else
				local Split = splitString(v["item"], "-")
				if Split[2] ~= nil then
					if Split[1] == "identity" then
						local Number = parseInt(Split[2])
						local Identity = vRP.userIdentity(Number)

						if Identity then 
							v["Passport"] = Number
							v["idRolepass"] = "Inativo"
							v["idBlood"] = bloodTypes(Identity["blood"])
							v["idPhone"] = Identity["phone"]
							v["idName"] = Identity["name"] .. " " .. Identity["name2"]
						end
					end
				end


				v["amount"] = parseInt(v["amount"])
				v["name"] = itemName(v["item"])
				v["image"] = Config["imagesProvider"] .. itemIndex(v["item"]) .. ".png"
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["max"] = itemMaxAmount(v["item"])
				v["type"] = itemType(v["item"])
				v["description"] = itemDescription(v["item"])
				v["key"] = v["item"]
				v["slot"] = k

				local splitName = splitString(v["item"], "-")
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
		end

		return myInventory, vRP.inventoryWeight(user_id), vRP.getWeight(user_id)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.invUpdate(Slot, Target, Amount)
	local source = source
	local Slot = tostring(Slot)
	local Target = tostring(Target)
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.invUpdate(user_id, Slot, Target, Amount)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:BADGES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Badges")
AddEventHandler("inventory:Badges", function(x, y, z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local Inventory = vRP.userInventory(user_id)
		if Inventory then
			for k, v in pairs(Inventory) do
				if string.sub(v["item"], 1, 5) == "badge" then
					local Amount = 1
					local Item = v["item"]

					if vRP.tryGetInventoryItem(user_id, Item, Amount, false, k) then
						local Days = 1
						local Number = 0
						local Durability = 0
						local splitName = splitString(Item, "-")

						repeat
							Number = Number + 1
						until Drops[tostring(Number)] == nil

						if splitName[2] ~= nil then
							if itemDurability(Item) then
								Durability = parseInt(os.time() - splitName[2])
								Days = itemDurability(Item)
							else
								Durability = 0
								Days = 1
							end
						else
							Durability = 0
							Days = 1
						end

						Drops[tostring(Number)] = {
							["key"] = Item,
							["amount"] = Amount,
							["coords"] = { x, y, z },
							["name"] = itemName(Item),
							["peso"] = itemWeight(Item),
							["index"] = itemIndex(Item),
							["days"] = Days,
							["durability"] = Durability
						}
						Config["Logs"]:Badges(source, user_id, Item, Amount)
						TriggerEvent("discordLogs", "Badges", "O passaporte **" .. user_id .. "** deixou sua badge cair.",
							3092790)
						TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
						TriggerClientEvent("inventory:Update", source, "updateMochila")

						break
					end
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drops")
AddEventHandler("inventory:Drops", function(Item, Slot, Amount, x, y, z)
	local source = source
	local Slot = tostring(Slot)
	local user_id = vRP.getUserId(source)

	local blockedWeapons = {
		"WEAPON_SMG",
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_COMBATPISTOL",
		"WEAPON_SMG_MK2"
	}

	local function isBlockedWeapon(item)
		for _, weapon in pairs(blockedWeapons) do
			if string.find(item, "^" .. weapon) then
				return true
			end
		end
		return false
	end

	if user_id then
		if Active[user_id] == nil and not vRPC.inVehicle(source) then
			if isBlockedWeapon(Item) then
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Este item não pode ser dropado.", "vermelho", 5000)
				return
			end

			if vRP.tryGetInventoryItem(user_id, Item, Amount, false, Slot) then
				vRPC._playAnim(source, true, { "pickup_object", "pickup_low" }, false)

				local Days, Number, Durability = 1, 0, 0
				local splitName = splitString(Item, "-")

				repeat
					Number = Number + 1
				until Drops[tostring(Number)] == nil

				if splitName[2] ~= nil then
					if itemDurability(Item) then
						Durability = parseInt(os.time() - splitName[2])
						Days = itemDurability(Item)
					end
				end

				Drops[tostring(Number)] = {
					["key"] = Item,
					["amount"] = Amount,
					["coords"] = { x, y, z },
					["name"] = itemName(Item),
					["peso"] = itemWeight(Item),
					["index"] = itemIndex(Item),
					["days"] = Days,
					["durability"] = Durability
				}
				
				local identity = vRP.getUserIdentity(user_id)
				local args = {
					["1"] = itemName(Item).." x"..Amount,
					["Coords"] = {
						x = string.format("%.2f", x),
						y = string.format("%.2f", y),
						z = string.format("%.2f", z)
					}
				}
				exports["config"]:SendLog("InvDrop", user_id, nil, args)
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			end
		else
			TriggerClientEvent("inventory:Update", source, "updateMochila")
		end
	end
end)

RegisterServerEvent("inventory:Destroy")
AddEventHandler("inventory:Destroy", function(Item, Slot, Amount, x, y, z)
	local source = source
	local Slot = tostring(Slot)
	local user_id = vRP.getUserId(source)

	if user_id then
		if Active[user_id] == nil then
			if vRP.tryGetInventoryItem(user_id, Item, Amount, true, Slot) then
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Update", source, "updateMochila")
			else
				TriggerClientEvent("Notify", source, "negado", "Não foi possível destruir o item.", "vermelho", 5000)
			end
		else
			TriggerClientEvent("inventory:Update", source, "updateMochila")
		end
	end
end)



local municaoperdida = {}
function cRP.returnAmmout(Ammo)
	local source = source
	local user_id = vRP.getUserId(source)

	if user_id then
		if not municaoperdida[user_id] then
			municaoperdida[user_id] = {}
			municaoperdida[user_id].ammo = Ammo
		end

		municaoperdida[user_id].ammo = Ammo
	end
end

RegisterServerEvent("inventory:returnAmount")
AddEventHandler("inventory:returnAmount", function(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Ammos[user_id] then
			for k, v in pairs(Ammos[user_id]) do
				TriggerClientEvent("clearAmmoInWeapon", source, k, 0)
				--[[ TriggerClientEvent("hud:ActiveArmed", source, true) ]]

				if municaoperdida[user_id].ammo == v then
					if vRP.tryGetInventoryItem(user_id, k, v, false) then
						v = v - municaoperdida[user_id].ammo
					end
					vRP.generateItem(user_id, k, v)
				end
			end
		end
	end
end)


local shoting = {}

RegisterServerEvent("get:client_evidence")
AddEventHandler("get:client_evidence", function(source)
	shoting[source] = true
end)

RegisterServerEvent("get:clear_evidence")
AddEventHandler("get:clear_evidence", function(source)
	shoting[source] = false
end)

function cRP.gsrCheck(sourcePlayer)
	if (shoting[sourcePlayer]) then
		shoting[sourcePlayer] = nil
		return true
	end
	return false
end

function cRP.haveEvidences(source)
	if shoting[source] then
		return true
	else
		return false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:PICKUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Pickup")
AddEventHandler("inventory:Pickup", function(Number, Amount, Slot)
	local source = source
	local Slot = tostring(Slot)
	local Number = tostring(Number)
	local user_id = vRP.getUserId(source)

	if not user_id then return end

	if Active[user_id] ~= nil then
		TriggerClientEvent("inventory:Update", source, "updateMochila")
		return
	end

	local drop = Drops[Number]
	if not drop then
		TriggerClientEvent("inventory:Update", source, "updateMochila")
		return
	end

	local item = drop["key"]

	if (vRP.inventoryWeight(user_id) + (itemWeight(item) * Amount)) > vRP.getWeight(user_id) then
		TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		TriggerClientEvent("inventory:Update", source, "updateMochila")
		return
	end

	if drop["amount"] < Amount then
		TriggerClientEvent("inventory:Update", source, "updateMochila")
		return
	end

	if vRP.checkMaxItens(user_id, item, Amount) then
		TriggerClientEvent("Notify", source, "important", "Atenção", "Limite atingido.", 3000)
		TriggerClientEvent("inventory:Update", source, "updateMochila")
		return
	end

	local inventory = vRP.userInventory(user_id)

	if inventory[Slot] and inventory[Slot]["item"] == item then
		vRP.giveInventoryItem(user_id, item, Amount, true, Slot)
	else
		vRP.giveInventoryItem(user_id, item, Amount, true, Slot)
	end

	local dropInfo = {
		item = itemName(item),
		amount = Amount
	}

	Drops[Number]["amount"] = drop["amount"] - Amount
	if Drops[Number]["amount"] <= 0 then
		TriggerClientEvent("drops:Remover", -1, Number)
		Drops[Number] = nil
	else
		TriggerClientEvent("drops:Atualizar", -1, Number, Drops[Number]["amount"])
	end

	TriggerClientEvent("inventory:Update", source, "updateMochila")

	local args = {
		["2"] = dropInfo.item,
		["3"] = dropInfo.amount
	}
	exports["config"]:SendLog("InvPickUp", user_id, nil, args)
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:SENDITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:sendItem")
AddEventHandler("inventory:sendItem", function(Slot, Amount)
	local source = source
	local Slot = tostring(Slot)
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)

	local blockedWeapons = {
		"WEAPON_SMG",
		"WEAPON_PUMPSHOTGUN",
		"WEAPON_CARBINERIFLE",
		"WEAPON_CARBINERIFLE_MK2",
		"WEAPON_STUNGUN",
		"WEAPON_COMBATPISTOL",
		"WEAPON_SMG_MK2",
		"WEAPON_RIFLE_AMMO",
		"WEAPON_SMG_AMMO",
		"WEAPON_PISTOL_AMMO"
	}

	local function isBlockedWeapon(item)
		for _, weapon in pairs(blockedWeapons) do
			if string.sub(item, 1, #weapon) == weapon then
				return true
			end
		end
		return false
	end

	if user_id and Active[user_id] == nil then
		local Player = vRPC.nearestPlayer(source, 3)
		if Player then
			local nuser_id = vRP.getUserId(Player)

			if not nuser_id then
				TriggerClientEvent("Notify", source, "cancel", "Erro", "Não foi possível identificar o jogador alvo.", "vermelho", 5000)
				return
			end

			Active[user_id] = os.time() + 100

			local inventory = vRP.userInventory(user_id)
			if not inventory[Slot] or inventory[Slot]["item"] == nil then
				Active[user_id] = nil
				return
			end

			if Amount == 0 then Amount = 1 end
			local Item = inventory[Slot]["item"]

			if vRP.hasGroup(user_id, "Police") and isBlockedWeapon(Item) then
				if not vRP.hasGroup(nuser_id, "Police") then
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("Notify", source, "cancel", "Negado", "Este item só pode ser transferido entre policiais.", "vermelho", 5000)
					Active[user_id] = nil
					return
				end
			end

			if Item == "gemstone" then
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Este item é intransferível.", "vermelho", 5000)
				Active[user_id] = nil
				return
			end

			if not vRP.checkMaxItens(nuser_id, Item, Amount) then
				if (vRP.inventoryWeight(nuser_id) + itemWeight(Item) * Amount) <= vRP.getWeight(nuser_id) then
					if vRP.tryGetInventoryItem(user_id, Item, Amount, true, Slot) then
						TriggerClientEvent("inventory:Close", source)
						vRPC.createObjects(source, "mp_safehouselost@", "package_dropoff", "prop_paper_bag_small", 16,
							28422, 0.0, -0.05, 0.05, 180.0, 0.0, 0.0)

						Citizen.Wait(3000)

						vRP.giveInventoryItem(nuser_id, Item, Amount, true)
						exports["config"]:SendLog("SendItem", user_id, nuser_id, {
							["1"] = Item,
							["2"] = Amount 
						})
					
						TriggerClientEvent("inventory:Update", source, "updateMochila")
						TriggerClientEvent("inventory:Update", Player, "updateMochila")
						vRPC.removeObjects(source)
					end
				else
					TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
				end
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Limite atingido.", "amarelo", 3000)
			end

			Active[user_id] = nil
		end
	end
end)


RegisterServerEvent("inventory:inComa")
AddEventHandler("inventory:inComa", function(status)
	inComa = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:USEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:useItem")
AddEventHandler("inventory:useItem", function(Slot, Amount, Method)
	local source = source
	local Slot = tostring(parseInt(Slot))
	if Method ~= "nui" then
		Slot = tostring(parseInt(Slot) + 35)
	end
	local Amount = parseInt(Amount)
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Amount == 0 then Amount = 1 end
		local inventory = vRP.userInventory(user_id)
		if not inventory[Slot] or inventory[Slot]["item"] == nil then
			return
		end
		local splitName = splitString(inventory[Slot]["item"], "-")
		local totalName = inventory[Slot]["item"]
		local nameItem = splitName[1]
		if itemDurability(totalName) then
			if vRP.checkBroken(totalName) then
				TriggerClientEvent("Notify", source, "cancel", "Negado", "" .. itemName(nameItem) .. " quebrado.",
					"vermelho",
					5000)
				return
			end
		end

		if vCLIENT.checkWater(source) and nameItem ~= "soap" then
			return
		end

		if itemType(totalName) == "Throwing" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local checkWeapon = vCLIENT.returnWeapon(source)
			if checkWeapon then
				local weaponStatus, weaponAmmo, hashItem = vCLIENT.storeWeaponHands(source)
				if weaponStatus then
					TriggerClientEvent("itensNotify", source, { "guardou", itemIndex(hashItem), 1, itemName(hashItem) })
				end
			else
				local Amount = 0
				local consultItem = vRP.getInventoryItemAmount(user_id, nameItem)
				if consultItem[1] <= 0 then
					return
				end

				local itemAmount = vRP.getInventoryItemAmount(user_id, nameItem)
				for i=1,16 do
					if i <= consultItem[1] then
						Amount = Amount + 1
					end
				end

				if vCLIENT.putWeaponHands(source, nameItem, Amount) then
					--[[ DeleteObject(attached_object.handle) ]]
					TriggerClientEvent("itensNotify", source, { "equipou", itemIndex(totalName), 1, itemName(totalName) })
					TriggerClientEvent("inventory:throwableWeapons", source, nameItem)
				end
			end
			return
		end

		if itemType(totalName) == "Armamento" then
			if vRPC.inVehicle(source) then
				if not itemVehicle(totalName) then
					return
				end
			end

			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				local weaponStatus, weaponAmmo, hashItem = vCLIENT.storeWeaponHands(source)

				if weaponStatus then
					local wHash = itemAmmo(hashItem)
					if wHash ~= nil then
						Ammos[user_id][wHash] = parseInt(weaponAmmo)
					end
					--[[ TriggerClientEvent("hud:Ammount", source, 0, 0) ]]
					TriggerClientEvent("itensNotify", source, { "guardou", itemIndex(hashItem), 1, itemName(hashItem) })
				end
			else
				local wHash = itemAmmo(nameItem)
				if wHash ~= nil then
					if not Ammos[user_id] then
						Ammos[user_id] = vRP.userData(user_id, "weaponAmmos")
						Attachs[user_id] = vRP.userData(user_id, "weaponAttachs")
					end

					if Ammos[user_id][wHash] == nil then
						Ammos[user_id][wHash] = 0
					end
				end

				if vCLIENT.putWeaponHands(source, nameItem, Ammos[user_id] and Ammos[user_id][wHash] or 0, Attachs[user_id] and Attachs[user_id][nameItem] or nil) then
					TriggerClientEvent("itensNotify", source, { "equipou", itemIndex(totalName), 1, itemName(totalName) })
				end
			end
			return
		end

		if itemType(totalName) == "Munição" then
			local returnWeapon, weaponHash, weaponAmmo = vCLIENT.rechargeCheck(source, nameItem)
			if returnWeapon then
				if nameItem ~= itemAmmo(weaponHash) then
					return
				end

				if (totalName == "WEAPON_PETROLCAN_AMMO") then
					if vRP.tryGetInventoryItem(user_id, totalName, Amount, false, Slot) then
						Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount

						TriggerClientEvent("itensNotify", source,
							{ "equipou", itemIndex(totalName), Amount, itemName(totalName) })
						vCLIENT.rechargeWeapon(source, weaponHash, Amount)
						TriggerClientEvent("inventory:Update", source, "updateMochila")
					end
					return
				end

				if (weaponAmmo >= 250) then
					TriggerClientEvent("Notify", source, "vermelho", "Essa arma alcançou seu limite de 250 muniçoes.",5000)
					TriggerClientEvent("inventory:Close", source)
					return 
				end

				if (Amount + weaponAmmo > 250) then
					Amount = Amount - Amount + weaponAmmo - 250
					Amount = -Amount
					if vRP.tryGetInventoryItem(user_id, totalName, Amount, false, Slot) then
						Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount

						TriggerClientEvent("itensNotify", source,
							{ "equipou", itemIndex(totalName), Amount, itemName(totalName) })
						vCLIENT.rechargeWeapon(source, weaponHash, Amount)
						TriggerClientEvent("inventory:Update", source, "updateMochila")
					end
				else
					if vRP.tryGetInventoryItem(user_id, totalName, Amount, false, Slot) then
						Ammos[user_id][nameItem] = parseInt(Ammos[user_id][nameItem]) + Amount

						TriggerClientEvent("itensNotify", source,
							{ "equipou", itemIndex(totalName), Amount, itemName(totalName) })
						vCLIENT.rechargeWeapon(source, weaponHash, Amount)
						TriggerClientEvent("inventory:Update", source, "updateMochila")
					end
				end
			end
			return
		end

		if nameItem == "attachsFlashlight" or nameItem == "attachsCrosshair" or nameItem == "attachsSilencer" or nameItem == "attachsGrip" then
			local returnWeapon = vCLIENT.returnWeapon(source)
			if returnWeapon then
				if Attachs[user_id][returnWeapon] == nil then
					Attachs[user_id][returnWeapon] = {}
				end

				if Attachs[user_id][returnWeapon][nameItem] == nil then
					local checkAttachs = vCLIENT.checkAttachs(source, nameItem, returnWeapon)
					if checkAttachs then
						if vRP.tryGetInventoryItem(user_id, totalName, 1, false, Slot) then
							TriggerClientEvent("itensNotify", source,
								{ "equipou", itemIndex(totalName), 1, itemName(totalName) })
							TriggerClientEvent("inventory:Update", source, "updateMochila")
							vCLIENT.putAttachs(source, nameItem, returnWeapon)
							Attachs[user_id][returnWeapon][nameItem] = true
						end
					else
						TriggerClientEvent("Notify", source, "important", "Atenção",
							"O armamento não possui suporte ao componente.", "amarelo", 5000)
					end
				else
					TriggerClientEvent("Notify", source, "important", "Atenção",
						"O armamento já possui o componente equipado.",
						"amarelo", 5000)
				end
			end
			return
		end

		if itemType(totalName) == "Usável" or itemType(totalName) == "Animal" then
			if Config["UseItens"][nameItem] then 
				Config["UseItens"][nameItem](source, user_id, totalName, Amount, Slot, splitName)
			end
			return
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERDISCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerDisconnect", function(user_id)
	if Ammos[user_id] then
		vRP.execute("playerdata/setUserdata",
			{ user_id = user_id, key = "weaponAttachs", value = json.encode(Attachs[user_id]) })
		vRP.execute("playerdata/setUserdata",
			{ user_id = user_id, key = "weaponAmmos", value = type(Ammos[user_id]) == "table" and
			json.encode(Ammos[user_id]) or '[]' })
		Attachs[user_id] = nil
		Ammos[user_id] = nil
	end

	if Active[user_id] then
		Active[user_id] = nil
	end

	if verifyObjects[user_id] then
		verifyObjects[user_id] = nil
	end

	if verifyAnimals[user_id] then
		verifyAnimals[user_id] = nil
	end

	if Loots[user_id] then
		Loots[user_id] = nil
	end

	if Healths[user_id] then
		Healths[user_id] = nil
	end

	if Armors[user_id] then
		Armors[user_id] = nil
	end

	if Scanners[user_id] then
		Scanners[user_id] = nil
	end

	if openIdentity[user_id] then
		openIdentity[user_id] = nil
	end

	if dismantleProgress[user_id] then
		local vehName = dismantleProgress[user_id]
		dismantleList[vehName] = true
		dismantleProgress[user_id] = nil
	end

	if Carry[user_id] then
		TriggerClientEvent("player:Commands", Carry[user_id], false)
		vRPC.removeObjects(Carry[user_id])
		Carry[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERCONNECT
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("playerConnect", function(user_id, source)
	Ammos[user_id] = vRP.userData(user_id, "weaponAmmos")
	Attachs[user_id] = vRP.userData(user_id, "weaponAttachs")

	TriggerClientEvent("objects:Table", source, Objects)
	TriggerClientEvent("drops:Table", source, Drops)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CANCEL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Cancel")
AddEventHandler("inventory:Cancel", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			Active[user_id] = nil
			vGARAGE.updateHotwired(source, false)
			TriggerClientEvent("StopProgress",source)
			TriggerClientEvent("eletronics:stopRobbery",source)
			TriggerClientEvent("inventory:Buttons", source, false)
			TriggerClientEvent("inventory:Disreset", source)
			if verifyObjects[user_id] then
				local model = verifyObjects[user_id][1]
				local hash = verifyObjects[user_id][2]

				Trashs[model][hash] = nil
				verifyObjects[user_id] = nil
			end

			if verifyAnimals[user_id] then
				local model = verifyAnimals[user_id][1]
				local netObjects = verifyAnimals[user_id][2]

				Animals[model][netObjects] = Animals[model][netObjects] - 1
				verifyAnimals[user_id] = nil
			end

			if Loots[user_id] then
				Boxes[Loots[user_id]][user_id] = nil
			end

			if dismantleProgress[user_id] then
				local vehName = dismantleProgress[user_id]
				dismantleList[vehName] = true
				dismantleProgress[user_id] = nil
			end
		end

		if openIdentity[user_id] then
			TriggerClientEvent("vRP:Identity", source)
			openIdentity[user_id] = nil
		end

		if Carry[user_id] then
			TriggerClientEvent("player:ropeCarry", Carry[user_id], source)
			TriggerClientEvent("player:Commands", Carry[user_id], false)
			vRPC.removeObjects(Carry[user_id])
			Carry[user_id] = nil
		end

		if Scanners[user_id] then
			TriggerClientEvent("inventory:updateScanner", source, false)
			TriggerClientEvent("inventory:Buttons", source, false)
			Scanners[user_id] = nil
		end

		vRPC.removeObjects(source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINVENTORY
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkInventory()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Active[user_id] ~= nil then
			return false
		end
	end

	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFYWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.verifyWeapon(Item, Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id, Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					Ammos[user_id][wHash] = parseInt(Ammo)

					if Attachs[user_id][Item] ~= nil then
						for nameAttachs, _ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id, nameAttachs, 1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id, wHash, Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update", source, "updateMochila")
				end
			end

			return false
		end
	end

	return true
end

RegisterNetEvent("inventory:cleanAmmos")
AddEventHandler("inventory:cleanAmmos",function(user_id,item)
	local wHash = itemAmmo(item)
	if wHash ~= nil then 
		if Ammos[user_id][wHash] > 0 then
			Ammos[user_id][wHash] = nil
		end 
	end 
end) 
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXISTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.existWeapon(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id, Item)
		if consultItem[1] <= 0 then
			local wHash = itemAmmo(Item)

			if wHash ~= nil then
				if Ammos[user_id][wHash] then
					if Attachs[user_id][Item] ~= nil then
						for nameAttachs, _ in pairs(Attachs[user_id][Item]) do
							vRP.generateItem(user_id, nameAttachs, 1)
						end

						Attachs[user_id][Item] = nil
					end

					if Ammos[user_id][wHash] > 0 then
						vRP.generateItem(user_id, wHash, Ammos[user_id][wHash])
						Ammos[user_id][wHash] = nil
					end

					TriggerClientEvent("inventory:Update", source, "updateMochila")
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.dropWeapons(Item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local consultItem = vRP.getInventoryItemAmount(user_id, Item)
		if consultItem[1] <= 0 then
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PREVENTWEAPON
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.preventWeapon(Item, Ammo)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local wHash = itemAmmo(Item)

		if wHash ~= nil then
			if Ammos[user_id][wHash] then
				if Ammo > 0 then
					Ammos[user_id][wHash] = Ammo
				else
					Ammos[user_id][wHash] = nil
				end
			end
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVETHROWABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.removeThrowable(nameItem)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.removeInventoryItem(user_id, nameItem, 1, true)
		vRP.removeInventoryItem(user_id, nameItem, 1, true)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:clearWeapons")
AddEventHandler("inventory:clearWeapons", function(user_id)
	if Ammos[user_id] then
		Ammos[user_id] = {}
		Attachs[user_id] = {}
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:VERIFYOBJECTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:verifyObjects")
AddEventHandler("inventory:verifyObjects", function(Entity, Service)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Service == "Lixeiro" then
			if not vRPC.lastVehicle(source, "trash") then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Precisa utilizar o veículo do Lixeiro.",
					"amarelo", 3000)
				return
			end
		end

		if Entity[1] ~= nil and Entity[2] ~= nil and Entity[4] ~= nil then
			local hash = Entity[1]
			local model = Entity[2]
			local coords = Entity[4]

			if verifyObjects[user_id] == nil then
				if Trashs[model] == nil then
					Trashs[model] = {}
				end

				if Trashs[model][hash] then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
					return
				end

				for k, v in pairs(Trashs[model]) do
					if #(v["coords"] - coords) <= 0.75 and os.time() <= v["timer"] then
						TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
						return
					end
				end

				Active[user_id] = os.time() + 5
				TriggerClientEvent("Progress", source, 5000)
				vRPC.playAnim(source, false, { "amb@prop_human_parking_meter@female@idle_a", "idle_a_female" }, true)

				verifyObjects[user_id] = { model, hash }
				TriggerClientEvent("inventory:Close", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				Trashs[model][hash] = { ["coords"] = coords, ["timer"] = os.time() + 3600 }

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)

						local itemSelect = { "", 1 }

						if Service == "Lixeiro" then
							local randItem = math.random(90)
							if parseInt(randItem) >= 61 and parseInt(randItem) <= 80 then
								itemSelect = { "metalcan", math.random(5) }
							elseif parseInt(randItem) >= 41 and parseInt(randItem) <= 60 then
								itemSelect = { "battery", math.random(5) }
							elseif parseInt(randItem) >= 31 and parseInt(randItem) <= 40 then
								itemSelect = { "elastic", math.random(5) }
							elseif parseInt(randItem) >= 21 and parseInt(randItem) <= 30 then
								itemSelect = { "plasticbottle", math.random(5) }
							elseif parseInt(randItem) <= 20 then
								itemSelect = { "glassbottle", math.random(5) }
							end
						elseif Service == "Jornaleiro" then
							itemSelect = { "paper", math.random(2) }
						end

						if itemSelect[1] == "" then
							TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo",
								5000)
						else
							if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1]) * itemSelect[2])) <= vRP.getWeight(user_id) then
								vRP.generateItem(user_id, itemSelect[1], itemSelect[2], true)
								vRP.upgradeStress(user_id, 1)
							else
								TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho",
									5000)
								Trashs[model][hash] = nil
							end
						end

						verifyObjects[user_id] = nil
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			end
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:LOOTSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:lootSystem")
AddEventHandler("inventory:lootSystem", function(Entity, Service)
	local source = source
	local Entity = tostring(Entity)
	local user_id = vRP.getUserId(source)
	if user_id then
		if Loots[user_id] == nil and Active[user_id] == nil then
			if Boxes[Entity] == nil then
				Boxes[Entity] = {}
			end

			if Boxes[Entity][user_id] then
				if os.time() <= Boxes[Entity][user_id] then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
					return
				end
			end

			Loots[user_id] = Entity
			Active[user_id] = os.time() + 5
			TriggerClientEvent("Progress", source, 5000)
			TriggerClientEvent("inventory:Close", source)
			TriggerClientEvent("inventory:Buttons", source, true)
			Boxes[Entity][user_id] = os.time() + lootItens[Service]["cooldown"]
			vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },
				true)

			repeat
				if os.time() >= parseInt(Active[user_id]) then
					Active[user_id] = nil
					vRPC.stopAnim(source, false)
					TriggerClientEvent("inventory:Buttons", source, false)

					local itemSelect = { { "", 1 }, { "", 1 }, { "", 1 } }

					if math.random(100) <= lootItens[Service]["null"] then
						local randItem = math.random(#lootItens[Service]["list"])
						local randAmount = math.random(lootItens[Service]["list"][randItem]["min"],
							lootItens[Service]["list"][randItem]["max"])

						local randItem2 = math.random(#lootItens[Service]["list"])
						local randAmount2 = math.random(lootItens[Service]["list"][randItem2]["min"],
							lootItens[Service]["list"][randItem2]["max"])

						local randItem3 = math.random(#lootItens[Service]["list"])
						local randAmount3 = math.random(lootItens[Service]["list"][randItem3]["min"],
							lootItens[Service]["list"][randItem3]["max"])
						itemSelect = {
							{ lootItens[Service]["list"][randItem]["item"],  randAmount },
							{ lootItens[Service]["list"][randItem2]["item"], randAmount2 },
							{ lootItens[Service]["list"][randItem3]["item"], randAmount3 }
						}
					end

					if itemSelect[1][1] == "" or itemSelect[2][1] == "" or itemSelect[3][1] == "" then
						TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
					else
						if (vRP.inventoryWeight(user_id) + (itemWeight(itemSelect[1][1]) * parseInt(itemSelect[1][2])) + (itemWeight(itemSelect[2][1]) * parseInt(itemSelect[2][2])) + (itemWeight(itemSelect[3][1]) * parseInt(itemSelect[3][2]))) <= vRP.getWeight(user_id) then
							vRP.generateItem(user_id, itemSelect[1][1], itemSelect[1][2], true)
							vRP.generateItem(user_id, itemSelect[2][1], itemSelect[2][2], true)
							vRP.generateItem(user_id, itemSelect[3][1], itemSelect[3][2], true)
							vRP.upgradeStress(user_id, 2)
						else
							TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
							Boxes[Entity][user_id] = nil
						end
					end

					Loots[user_id] = nil
				end

				Citizen.Wait(100)
			until Active[user_id] == nil
		end
	end
end)

-- RegisterCommand("stress",function(source)

-- 	vRP.upgradeStress(vRP.getUserId(source),2)
-- end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:APPLYPLATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:applyPlate")
AddEventHandler("inventory:applyPlate", function(Entity)
	local source = source
	local consultItem = {}
	local vehPlate = Entity[1]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		if Plates[vehPlate] == nil then
			consultItem = vRP.getInventoryItemAmount(user_id, "plate")
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Precisa de <b>1x " .. itemName("plate") ..
					"</b>.", 5000)
				return
			end
		end

		local consultPliers = vRP.getInventoryItemAmount(user_id, "pliers")
		if consultPliers[1] <= 0 then
			TriggerClientEvent("Notify", source, "important", "Atenção",
				"Precisa de <b>1x " .. itemName("pliers") .. "</b>.",
				5000)
			return
		end

		if Plates[vehPlate] ~= nil then
			if os.time() < Plates[vehPlate][1] then
				local plateTimers = parseInt(Plates[vehPlate][1] - os.time())
				if plateTimers ~= nil then
					TriggerClientEvent("Notify", source, "azul", "Aguarde " .. completeTimers(plateTimers) .. ".", 5000)
				end

				return
			end
		end

		Active[user_id] = os.time() + 30
		TriggerClientEvent("Progress", source, 30000)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.stopAnim(source, false)
				TriggerClientEvent("inventory:Buttons", source, false)

				if Plates[vehPlate] == nil then
					if vRP.tryGetInventoryItem(user_id, consultItem[2], 1, true) then
						local newPlate = vRP.generatePlate()
						TriggerEvent("plateEveryone", newPlate)
						TriggerClientEvent("player:applyGsr", source)
						Plates[newPlate] = { os.time() + 3600, vehPlate }

						local idNetwork = NetworkGetEntityFromNetworkId(Entity[4])
						if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
							SetVehicleNumberPlateText(idNetwork, newPlate)
						end
					end
				else
					local idNetwork = NetworkGetEntityFromNetworkId(Entity[4])
					if DoesEntityExist(idNetwork) and not IsPedAPlayer(idNetwork) and GetEntityType(idNetwork) == 2 then
						SetVehicleNumberPlateText(idNetwork, Plates[vehPlate][2])
					end

					if math.random(100) >= 50 then
						vRP.generateItem(user_id, "plate", 1, true)
					else
						TriggerClientEvent("Notify", source, "azul", "Após remove-la a mesma quebrou.", 5000)
					end

					TriggerEvent("plateReveryone", vehPlate)
					Plates[vehPlate] = nil
				end
			end

			Citizen.Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:CHECKSTOCKADE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:checkStockade")
AddEventHandler("inventory:checkStockade", function(Entity)
	local policeResult = vRP.numPermission("Police")
	if parseInt(#policeResult) <= 8 then
		TriggerClientEvent("Notify", source, "important", "Atenção", "Sistema indisponível no momento.", "amarelo", 5000)
		return false
	else
		local source = source
		local vehPlate = Entity[1]
		local user_id = vRP.getUserId(source)
		if user_id and Active[user_id] == nil then
			if Plates[vehPlate] then
				TriggerClientEvent("Notify", source, "cancel", "Negado",
					"Não foi encontrado o registro do veículo no sistema.",
					"vermelho", 5000)
				return
			end

			if Stockade[vehPlate] == nil then
				Stockade[vehPlate] = 0
			end

			if Stockade[vehPlate] >= 15 then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Vazio.", "amarelo", 5000)
				return
			end

			if vRP.userPlate(vehPlate) then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Veículo protegido pela seguradora.",
					"amarelo",
					5000)
				return
			end

			local stockadeItens = { "WEAPON_CROWBAR", "lockpick" }
			for k, v in pairs(stockadeItens) do
				local consultItem = vRP.getInventoryItemAmount(user_id, v)
				if consultItem[1] < 1 then
					TriggerClientEvent("Notify", source, "important", "Atenção", "" .. itemName(v) .. " não encontrado.",
						"amarelo", 5000)
					return
				end

				if vRP.checkBroken(consultItem[2]) then
					TriggerClientEvent("Notify", source, "cancel", "Negado", "" .. itemName(v) .. "quebrado.", "negado",
						5000)
					return
				end
			end

			Stockade[vehPlate] = Stockade[vehPlate] + 1

			if vTASKBAR.taskHandcuff(source) then
				vRP.upgradeStress(user_id, 10)
				Active[user_id] = os.time() + 15
				TriggerClientEvent("Progress", source, 15000)
				TriggerClientEvent("player:applyGsr", source)
				TriggerClientEvent("inventory:Buttons", source, true)
				vRPC.playAnim(source, false,
					{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

				repeat
					if os.time() >= parseInt(Active[user_id]) then
						Active[user_id] = nil
						vRPC.stopAnim(source, false)
						TriggerClientEvent("inventory:Buttons", source, false)
						vRP.generateItem(user_id, "dollars", math.random(225, 275), true)
					end

					Citizen.Wait(100)
				until Active[user_id] == nil
			else
				local coords = vRPC.getEntityCoords(source)
				Stockade[vehPlate] = Stockade[vehPlate] - 1

				for k, v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush", v,
							{
								code = 20,
								title = "Roubo ao Carro Forte",
								x = coords["x"],
								y = coords["y"],
								z = coords["z"],
								criminal = "Alarme de segurança",
								time = "Recebido às " .. os.date("%H:%M"),
								blipColor = 16
							})
					end)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALTRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.stealTrunk(Entity)
	local source = source
	local vehNet = Entity[4]
	local vehPlate = Entity[1]
	local vehModels = Entity[2]
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local userPlate = vRP.userPlate(vehPlate)
		if not userPlate then
			if Trunks[vehPlate] == nil then
				Trunks[vehPlate] = os.time()
			end

			if os.time() >= Trunks[vehPlate] then
				vRPC.playAnim(source, false,
					{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)
				Active[user_id] = os.time() + 100

				if vTASKBAR.stealTrunk(source) then
					Active[user_id] = os.time() + 30
					TriggerClientEvent("Progress", source, 30000)
					TriggerClientEvent("inventory:Buttons", source, true)

					local activePlayers = vRPC.activePlayers(source)
					for _, v in ipairs(activePlayers) do
						async(function()
							TriggerClientEvent("player:syncDoorsOptions", v, vehNet, "open")
						end)
					end

					repeat
						if os.time() >= parseInt(Active[user_id]) then
							Active[user_id] = nil
							vRPC.stopAnim(source, false)
							TriggerClientEvent("inventory:Buttons", source, false)

							local activePlayers = vRPC.activePlayers(source)
							for _, v in ipairs(activePlayers) do
								async(function()
									TriggerClientEvent("player:syncDoorsOptions", v, vehNet, "close")
								end)
							end

							if os.time() >= Trunks[vehPlate] then
								local randItens = math.random(#stealItens)
								if math.random(250) <= stealItens[randItens]["rand"] then
									local randAmounts = math.random(stealItens[randItens]["min"],
										stealItens[randItens]["max"])

									if (vRP.inventoryWeight(user_id) + (itemWeight(stealItens[randItens]["item"]) * randAmounts)) <= vRP.getWeight(user_id) then
										vRP.generateItem(user_id, stealItens[randItens]["item"], randAmounts, true)
										Trunks[vehPlate] = os.time() + 3600
										vRP.upgradeStress(user_id, 2)
									else
										TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.",
											"vermelho", 5000)
									end
								else
									TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.",
										"amarelo", 5000)
									Trunks[vehPlate] = os.time() + 3600
									vRP.upgradeStress(user_id, 1)
								end
							end
						end

						Citizen.Wait(100)
					until Active[user_id] == nil
				else
					local activePlayers = vRPC.activePlayers(source)
					for _, v in ipairs(activePlayers) do
						async(function()
							TriggerClientEvent("inventory:vehicleAlarm", v, vehNet, vehPlate)
						end)
					end

					vRPC.stopAnim(source, false)
					Active[user_id] = nil

					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")
					for k, v in pairs(policeResult) do
						async(function()
							TriggerClientEvent("NotifyPush", v,
								{
									code = 31,
									title = "Roubo de Veículo",
									x = coords["x"],
									y = coords["y"],
									z = coords["z"],
									vehicle = vehicleName(vehModels) .. " - " .. vehPlate,
									time = "Recebido às " .. os.date("%H:%M"),
									blipColor = 44
								})
						end)
					end
				end
			else
				TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
			end
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Veículo protegido pela seguradora.", 1000)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:ANIMALS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Animals")
AddEventHandler("inventory:Animals", function(Entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Entity[2] ~= nil and Entity[3] ~= nil then
			local nameItem = "switchblade"
			local consultItem = vRP.getInventoryItemAmount(user_id, nameItem)
			if consultItem[1] <= 0 then
				TriggerClientEvent("Notify", source, "important", "Atenção", "Necessário possuir um " ..
					itemName(nameItem) .. ".", "amarelo", 5000)
				return
			end

			if vRP.checkBroken(consultItem[2]) then
				TriggerClientEvent("Notify", source, "cancel", "Negado", "" .. itemName(nameItem) .. " quebrado.",
					"vermelho",
					5000)
				return
			end

			local model = Entity[2]
			local netObjects = Entity[3]

			if Animals[model] == nil then
				Animals[model] = {}
			end

			if Animals[model][netObjects] == nil then
				Animals[model][netObjects] = 0
			end

			if verifyAnimals[user_id] == nil and Active[user_id] == nil and Animals[model][netObjects] < 5 then
				if (vRP.inventoryWeight(user_id) + itemWeight("meat")) <= vRP.getWeight(user_id) then
					if vTASKBAR.taskOne(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress", source, 10000)
						vRPC.playAnim(source, false, { "amb@medic@standing@kneel@base", "base" }, true)
						vRPC.playAnim(source, true, { "anim@gangops@facility@servers@bodysearch@", "player_search" },
							true)

						TriggerClientEvent("inventory:Close", source)
						verifyAnimals[user_id] = { model, netObjects }
						TriggerClientEvent("inventory:Buttons", source, true)
						Animals[model][netObjects] = Animals[model][netObjects] + 1

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil
								vRPC.stopAnim(source, false)
								verifyAnimals[user_id] = nil
								TriggerClientEvent("inventory:Buttons", source, false)

								if Animals[model] then
									if parseInt(Animals[model][netObjects]) <= 1 then
										vRP.generateItem(user_id, "meat", 1, true)
									elseif parseInt(Animals[model][netObjects]) == 2 then
										vRP.generateItem(user_id, "meat", 1, true)
									elseif parseInt(Animals[model][netObjects]) == 3 then
										local randItens = math.random(8)
										vRP.generateItem(user_id, "animalfat", randItens, true)
									elseif parseInt(Animals[model][netObjects]) == 4 then
										local randItens = math.random(4)
										vRP.generateItem(user_id, "leather", randItens, true)
									elseif parseInt(Animals[model][netObjects]) >= 5 then
										local randItens = math.random(2)
										Animals[model][netObjects] = nil
										TriggerEvent("tryDeletePed", netObjects)
										vRP.generateItem(user_id, "animalpelt", randItens, true)
									end
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					end
				else
					TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
				end
			end
		else
			TriggerClientEvent("Notify", source, "important", "Atenção", "Nada encontrado.", "amarelo", 5000)
		end
	end
end)

-------------------------------
-- cashmachine:invExplode
-------------------------------
-- evento que o chashmachine chama quando explode; dobra o item.
RegisterServerEvent("cashmachine:invExplode")
AddEventHandler("cashmachine:invExplode", function(source, nameItem, amount, t, u, i)
	local x, y, z, gridZone = vCLIENT.dropFunctions(source)
	local days = 1
	local durability = 0
	local splitName = splitString(nameItem, "-")
	local Number = 0
	repeat
		Number = Number + 1
	until Drops[tostring(Number)] == nil


	if splitName[2] ~= nil then
		durability = parseInt(os.time() - splitName[2])
		days = itemDurability(nameItem)
	end

	Drops[tostring(Number)] = {
		["key"] = nameItem,
		["amount"] = amount,
		["coords"] = { t, u, i },
		["name"] = itemName(nameItem),
		["peso"] = itemWeight(nameItem),
		["index"] = itemIndex(nameItem),
		["days"] = days,
		["durability"] = durability
	}

	TriggerClientEvent("drops:Adicionar", -1, tostring(Number), Drops[tostring(Number)])
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STEALPEDSLIST
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.favelaDistance(source)
	local ped = GetPlayerPed(source)
	local coords = GetEntityCoords(ped)

	for k, v in pairs(favelasCds) do
		local distance = #(coords - vector3(v[1], v[2], v[3]))
		if distance <= 300 then
			return true
		end
	end

	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:STEALPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:StealPeds")
AddEventHandler("inventory:StealPeds", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if (vRP.inventoryWeight(user_id) + 1) <= vRP.getWeight(user_id) then
			vRP.upgradeStress(user_id, 3)
			local rand = math.random(#stealpedsList)
			local value = math.random(stealpedsList[rand]["min"], stealpedsList[rand]["max"])
			vRP.generateItem(user_id, stealpedsList[rand]["item"], value, true)
			local ped = GetPlayerPed(source)
			local coords = GetEntityCoords(ped)
			local policeResult = vRP.numPermission("Police")

			for k, v in pairs(policeResult) do
				async(function()
					vRPC.playSound(v, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
					TriggerClientEvent("NotifyPush", v,
						{
							code = 20,
							title = "Roubo a pedestre",
							x = coords["x"],
							y = coords["y"],
							z = coords["z"],
							criminal = "Ligação Anônima",
							time = "Recebido às " .. os.date("%H:%M"),
							blipColor = 16
						})
				end)
			end
		else
			TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.AmountDrugs()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k, v in pairs(Config["Drugs"]) do
			local randAmount = math.random(v["randMin"], v["randMax"])
			local randPrice = math.random(v["priceMin"], v["priceMax"])
			local consultItem = vRP.getInventoryItemAmount(user_id, v["item"])
			if consultItem[1] >= parseInt(randAmount) then
				userAmount[user_id] = { v["item"], randAmount, randPrice * randAmount }

				return true
			end
		end

		return false
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRUGSPEDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:DrugsPeds")
AddEventHandler("inventory:DrugsPeds", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id, userAmount[user_id][1], userAmount[user_id][2], true) then
			vRP.upgradeStress(user_id, 3)
			TriggerClientEvent("player:applyGsr", source)

			local status, boostnumber = exports["black_domination"]:UserHasDominatedArea(source)
			if status then
				userAmount[user_id][3] = userAmount[user_id][3] * boostnumber
			end
			
			vRP.generateItem(user_id, "dollarsroll", userAmount[user_id][3], true)

			if math.random(100) >= 75 then
				local ped = GetPlayerPed(source)
				local coords = GetEntityCoords(ped)
				local policeResult = vRP.numPermission("Police")
				for k, v in pairs(policeResult) do
					async(function()
						vRPC.playSound(v, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
						TriggerClientEvent("NotifyPush", v,
							{
								code = 20,
								title = "Venda de Drogas",
								x = coords["x"],
								y = coords["y"],
								z = coords["z"],
								criminal = "Ligação Anônima",
								time = "Recebido às " .. os.date("%H:%M"),
								blipColor = 16
							})
					end)
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- OBJECTS:GUARDAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("objects:Guardar")
AddEventHandler("objects:Guardar", function(Number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if Objects[Number] then
			vRP.giveInventoryItem(user_id, Objects[Number]["item"], 1, true)
			TriggerClientEvent("objects:Remover", -1, Number)

			if tableSelect[Objects[Number]["item"]] then
				if tableSelect[Objects[Number]["item"]][Number] then
					tableSelect[Objects[Number]["item"]][Number] = nil
				end
			end

			Objects[Number] = nil
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:MAKEPRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:makeProducts")
AddEventHandler("inventory:makeProducts", function(Entity, Table)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local typeTable = splitString(Table, "-")[1]

		if tableList[typeTable] then
			if typeTable == "cemitery" then
				if not vTASKBAR.taskOne(source) then
					local coords = vRPC.getEntityCoords(source)
					local policeResult = vRP.numPermission("Police")

					for k, v in pairs(policeResult) do
						async(function()
							vRPC.playSound(v, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
							TriggerClientEvent("NotifyPush", v, {
								code = 20,
								title = "Roubo de Pertences",
								x = coords["x"],
								y = coords["y"],
								z = coords["z"],
								criminal = "Alarme de segurança",
								time = "Recebido às " .. os.date("%H:%M"),
								blipColor = 16
							})
						end)
					end
				end
			end

			local model = Table
			local id = Entity[1] or Table

			if tableSelect[model] == nil then tableSelect[model] = {} end
			if tableSelect[model][id] == nil then tableSelect[model][id] = 0 end

			local numberProgress = tableSelect[model][id] + 1
			if typeTable == "scanner" or typeTable == "cemitery" then
				numberProgress = math.random(#tableList[typeTable])
			end

			local maxCraft = 1
			if tableList[typeTable][numberProgress]["item"] ~= nil then
				if vRP.checkMaxItens(user_id, tableList[typeTable][numberProgress]["item"], tableList[typeTable][numberProgress]["itemAmount"] * maxCraft) then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Limite atingido.", "amarelo", 3000)
					return
				end

				if (vRP.inventoryWeight(user_id) + (itemWeight(tableList[typeTable][numberProgress]["item"]) * tableList[typeTable][numberProgress]["itemAmount"] * maxCraft)) > vRP.getWeight(user_id) then
					TriggerClientEvent("Notify", source, "cancel", "Negado", "Mochila cheia.", "vermelho", 5000)
					return
				end
			end

			if tableList[typeTable][numberProgress]["need"] ~= nil then
				local needItem = tableList[typeTable][numberProgress]["need"]
				if type(needItem) == "table" then
					maxCraft = math.huge
					for _, v in pairs(needItem) do
						local count = vRP.getInventoryItemAmount(user_id, v["item"])[1]
						local possible = math.floor(count / v["amount"])
						if possible < maxCraft then
							maxCraft = possible
						end
					end
				else
					local needAmount = tableList[typeTable][numberProgress]["needAmount"] or 1
					local count = vRP.getInventoryItemAmount(user_id, needItem)[1]
					maxCraft = math.floor(count / needAmount)
				end
			end

			if maxCraft <= 0 then
				TriggerClientEvent("Notify", source, "cancel", "Negado","Não possui ingredientes suficientes.",  5000)
				return
			end

			local totalTime = tableList[typeTable][numberProgress]["timer"] * maxCraft

			TriggerClientEvent("inventory:Buttons", source, true)
			TriggerClientEvent("Progress", source, totalTime * 1000)
			Active[user_id] = os.time() + totalTime

			if typeTable ~= "scanner" then
				if typeTable == "cemitery" then
					vRPC.playAnim(source, false, { "amb@medic@standing@tendtodead@idle_a", "idle_a" }, true)
				else
					vRPC.playAnim(source, false, { tableList[typeTable]["anim"][1], tableList[typeTable]["anim"][2] }, true)
				end
			end

			CreateThread(function()
				for i = 1, maxCraft do
					if Active[user_id] == "cancelled" or os.time() > (Active[user_id] or 0) then break end

					if tableList[typeTable][numberProgress]["need"] ~= nil then
						local needItem = tableList[typeTable][numberProgress]["need"]
						if type(needItem) == "table" then
							for _, v in pairs(needItem) do
								vRP.removeInventoryItem(user_id, v["item"], v["amount"], false)
							end
						else
							vRP.removeInventoryItem(user_id, needItem, tableList[typeTable][numberProgress]["needAmount"], false)
						end
					end

					if Active[user_id] == "cancelled" then break end

					vRP.generateItem(user_id, tableList[typeTable][numberProgress]["item"], tableList[typeTable][numberProgress]["itemAmount"], true)
					Wait(tableList[typeTable][numberProgress]["timer"] * 1000)
				end

				Active[user_id] = nil
				TriggerClientEvent("inventory:Buttons", source, false)
				if typeTable ~= "scanner" then vRPC.stopAnim(source, false) end
			end)
		end
	end
end)

RegisterNetEvent("cancelcraft")
AddEventHandler("cancelcraft", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] then
		Active[user_id] = "cancelled"
		TriggerClientEvent("inventory:Buttons", source, false)
		vRPC.stopAnim(source, false)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DESMANCHAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Desmanchar")
AddEventHandler("inventory:Desmanchar", function(Entity)
	local source = source
	local vehName = Entity[2]
	local user_id = vRP.getUserId(source)

	dismantleList[vehName] = true;
	if user_id and dismantleList[vehName] and Active[user_id] == nil then
		dismantleList[vehName] = nil
		dismantleProgress[user_id] = vehName
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.playAnim(source, false, { "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" }, true)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRPC.removeObjects(source)
				vRP.upgradeStress(user_id, 10)
				dismantleProgress[user_id] = nil
				TriggerClientEvent("player:applyGsr", source)
				TriggerClientEvent("inventory:Buttons", source, false)
				TriggerEvent("garages:deleteVehicle", Entity[4], Entity[1])
			
				
				vRP.generateItem(user_id, "dollarsroll", math.random(8000, 12000), true)
			
				for _, itens in pairs(Config["dismantleItens"]) do
					vRP.generateItem(user_id, itens[1], math.random(itens[2], itens[3]), true)
				end
			
				if math.random(1000) <= 25 then
					vRP.generateItem(user_id, "plate", 1, true)
				end

				TriggerClientEvent("inventory:Disreset", source)
			end
			

			Citizen.Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DISMANTLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Dismantle")
AddEventHandler("inventory:Dismantle", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if os.time() >= dismantleTimer then
			dismantleUpdate()
		end

		local vehListNames = ""
		for k, v in pairs(dismantleList) do
			vehListNames = vehListNames .. "<b>" .. vehicleName(k) .. "</b>, "
		end

		TriggerClientEvent("Notify", source, "azul",
			vehListNames .. " a lista vai ser atualizada em <b>" .. (dismantleTimer - os.time()) .. "</b> segundos.",
			60000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISMANTLEUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
function dismantleUpdate()
	dismantleList = {}
	local amountVeh = 0
	local selectVehs = 0
	dismantleTimer = os.time() + 3600

	repeat
		selectVehs = math.random(#dismantleVehs)
		if dismantleList[dismantleVehs[selectVehs]] == nil then
			dismantleList[dismantleVehs[selectVehs]] = true
			amountVeh = amountVeh + 1
		end
	until amountVeh >= 10
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:DRINK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:Drink")
AddEventHandler("inventory:Drink", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		vRPC.stopActived(source)
		Active[user_id] = os.time() + 15
		TriggerClientEvent("Progress", source, 15000)
		TriggerClientEvent("inventory:Close", source)
		TriggerClientEvent("inventory:Buttons", source, true)
		vRPC.createObjects(source, "mp_player_intdrink", "loop_bottle", "prop_plastic_cup_02", 49, 60309, 0.0, 0.0, 0.1,
			0.0,
			0.0, 130.0)

		repeat
			if os.time() >= parseInt(Active[user_id]) then
				Active[user_id] = nil
				vRP.upgradeThirst(user_id, 20)
				vRPC.removeObjects(source, "one")
				TriggerClientEvent("inventory:Buttons", source, false)
			end

			Wait(100)
		until Active[user_id] == nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INVENTORY:REMOVETYRES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("inventory:removeTyres")
AddEventHandler("inventory:removeTyres", function(Entity, Tyre)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and Active[user_id] == nil then
		local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
		if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
			if vCLIENT.tyreHealth(source, Entity[4], Tyre) == 1000.0 then
				if vRP.checkMaxItens(user_id, "tyres", 1) then
					TriggerClientEvent("Notify", source, "important", "Atenção", "Limite atingido.", 3000)
					return
				end

				if vRP.userPlate(Entity[1]) then
					TriggerClientEvent("inventory:Close", source)
					TriggerClientEvent("inventory:Buttons", source, true)
					vRPC.playAnim(source, false,
						{ "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer" },
						true)

					if vTASKBAR.taskTyre(source) then
						Active[user_id] = os.time() + 10
						TriggerClientEvent("Progress", source, 10000)

						repeat
							if os.time() >= parseInt(Active[user_id]) then
								Active[user_id] = nil

								local Vehicle = NetworkGetEntityFromNetworkId(Entity[4])
								if DoesEntityExist(Vehicle) and not IsPedAPlayer(Vehicle) and GetEntityType(Vehicle) == 2 then
									if vCLIENT.tyreHealth(source, Entity[4], Tyre) == 1000.0 then
										vRP.generateItem(user_id, "tyres", 1, true)

										local activePlayers = vRPC.activePlayers(source)
										for _, v in ipairs(activePlayers) do
											async(function()
												TriggerClientEvent("inventory:explodeTyres", v, Entity[4], Entity[1],
													Tyre)
											end)
										end
									end
								end
							end

							Citizen.Wait(100)
						until Active[user_id] == nil
					end

					TriggerClientEvent("inventory:Buttons", source, false)
					vRPC.removeObjects(source)
				end
			end
		end
	end
end)


RegisterServerEvent("player:RollVehicle")
AddEventHandler("player:RollVehicle", function(Entity)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		TriggerClientEvent("inventory:Close", source)
		vRPC.playAnim(source, false, { "mini@repair", "fixing_a_player" }, true)
		TriggerClientEvent("Progress", source, 20000)
		Wait(20000)
		vRPC.stopAnim(source, false)
		TriggerClientEvent("target:RollVehicle", source, Entity[4])
	end
end)
