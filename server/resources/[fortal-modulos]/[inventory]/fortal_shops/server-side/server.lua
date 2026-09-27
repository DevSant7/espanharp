-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("shops", cRP)

vCLIENT = Tunnel.getInterface("shops")

CreateThread(function()
	Utils.functions.execute("createPhoto")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NAMES
-----------------------------------------------------------------------------------------------------------------------------------------
local nameMale = {
	"James",
	"John",
	"Robert",
	"Michael",
	"William",
	"David",
	"Richard",
	"Charles",
	"Joseph",
	"Thomas",
	"Christopher",
	"Daniel",
	"Paul",
	"Mark",
	"Donald",
	"George",
	"Kenneth",
	"Steven",
	"Edward",
	"Brian",
	"Ronald",
	"Anthony",
	"Kevin",
	"Jason",
	"Matthew",
	"Gary",
	"Timothy",
	"Jose",
	"Larry",
	"Jeffrey",
	"Frank",
	"Scott",
	"Eric",
	"Stephen",
	"Andrew",
	"Raymond",
	"Gregory",
	"Joshua",
	"Jerry",
	"Dennis",
	"Walter",
	"Patrick",
	"Peter",
	"Harold",
	"Douglas",
	"Henry",
	"Carl",
	"Arthur",
	"Ryan",
	"Roger",
	"Joe",
	"Juan",
	"Jack",
	"Albert",
	"Jonathan",
	"Justin",
	"Terry",
	"Gerald",
	"Keith",
	"Samuel",
	"Willie",
	"Ralph",
	"Lawrence",
	"Nicholas",
	"Roy",
	"Benjamin",
	"Bruce",
	"Brandon",
	"Adam",
	"Harry",
	"Fred",
	"Wayne",
	"Billy",
	"Steve",
	"Louis",
	"Jeremy",
	"Aaron",
	"Randy",
	"Howard",
	"Eugene",
	"Carlos",
	"Russell",
	"Bobby",
	"Victor",
	"Martin",
	"Ernest",
	"Phillip",
	"Todd",
	"Jesse",
	"Craig",
	"Alan",
	"Shawn",
	"Clarence",
	"Sean",
	"Philip",
	"Chris",
	"Johnny",
	"Earl",
	"Jimmy",
	"Antonio"
}

local nameFemale = {
	"Mary",
	"Patricia",
	"Linda",
	"Barbara",
	"Elizabeth",
	"Jennifer",
	"Maria",
	"Susan",
	"Margaret",
	"Dorothy",
	"Lisa",
	"Nancy",
	"Karen",
	"Betty",
	"Helen",
	"Sandra",
	"Donna",
	"Carol",
	"Ruth",
	"Sharon",
	"Michelle",
	"Laura",
	"Sarah",
	"Kimberly",
	"Deborah",
	"Jessica",
	"Shirley",
	"Cynthia",
	"Angela",
	"Melissa",
	"Brenda",
	"Amy",
	"Anna",
	"Rebecca",
	"Virginia",
	"Kathleen",
	"Pamela",
	"Martha",
	"Debra",
	"Amanda",
	"Stephanie",
	"Carolyn",
	"Christine",
	"Marie",
	"Janet",
	"Catherine",
	"Frances",
	"Ann",
	"Joyce",
	"Diane",
	"Alice",
	"Julie",
	"Heather",
	"Teresa",
	"Doris",
	"Gloria",
	"Evelyn",
	"Jean",
	"Cheryl",
	"Mildred",
	"Katherine",
	"Joan",
	"Ashley",
	"Judith",
	"Rose",
	"Janice",
	"Kelly",
	"Nicole",
	"Judy",
	"Christina",
	"Kathy",
	"Theresa",
	"Beverly",
	"Denise",
	"Tammy",
	"Irene",
	"Jane",
	"Lori",
	"Rachel",
	"Marilyn",
	"Andrea",
	"Kathryn",
	"Louise",
	"Sara",
	"Anne",
	"Jacqueline",
	"Wanda",
	"Bonnie",
	"Julia",
	"Ruby",
	"Lois",
	"Tina",
	"Phyllis",
	"Norma",
	"Paula",
	"Diana",
	"Annie",
	"Lillian",
	"Emily",
	"Robin"
}

local userName2 = {
	"Smith",
	"Johnson",
	"Williams",
	"Jones",
	"Brown",
	"Davis",
	"Miller",
	"Wilson",
	"Moore",
	"Taylor",
	"Anderson",
	"Thomas",
	"Jackson",
	"White",
	"Harris",
	"Martin",
	"Thompson",
	"Garcia",
	"Martinez",
	"Robinson",
	"Clark",
	"Rodriguez",
	"Lewis",
	"Lee",
	"Walker",
	"Hall",
	"Allen",
	"Young",
	"Hernandez",
	"King",
	"Wright",
	"Lopez",
	"Hill",
	"Scott",
	"Green",
	"Adams",
	"Baker",
	"Gonzalez",
	"Nelson",
	"Carter",
	"Mitchell",
	"Perez",
	"Roberts",
	"Turner",
	"Phillips",
	"Campbell",
	"Parker",
	"Evans",
	"Edwards",
	"Collins",
	"Stewart",
	"Sanchez",
	"Morris",
	"Rogers",
	"Reed",
	"Cook",
	"Morgan",
	"Bell",
	"Murphy",
	"Bailey",
	"Rivera",
	"Cooper",
	"Richardson",
	"Cox",
	"Howard",
	"Ward",
	"Torres",
	"Peterson",
	"Gray",
	"Ramirez",
	"James",
	"Watson",
	"Brooks",
	"Kelly",
	"Sanders",
	"Price",
	"Bennett",
	"Wood",
	"Barnes",
	"Ross",
	"Henderson",
	"Coleman",
	"Jenkins",
	"Perry",
	"Powell",
	"Long",
	"Patterson",
	"Hughes",
	"Flores",
	"Washington",
	"Butler",
	"Simmons",
	"Foster",
	"Gonzales",
	"Bryant",
	"Alexander",
	"Russell",
	"Griffin",
	"Diaz",
	"Hayes"
}

local userLocate = {
	"Sul",
	"Norte"
}

-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP GROUPS CONFIGURATION
-----------------------------------------------------------------------------------------------------------------------------------------
local vipGroups = {
    { group = "Rm", slots = 53 },
    { group = "Bronze", slots = 53 },  
    { group = "Prata", slots = 53 },
    { group = "Ouro", slots = 53 },
    { group = "Diamante", slots = 53 }
}

-- Função para verificar se um slot é válido para o usuário
local function isValidSlot(slotNumber, isVip)
    if isVip then
        return slotNumber >= 1 and slotNumber <= 53
    else
        return slotNumber >= 1 and slotNumber <= 35
    end
end

function cRP.getVip()
    local source = source 
    local user_id = Utils.functions.userId(source)
    if user_id then
        for _, data in ipairs(vipGroups) do
            if Utils.functions.hasGroup(user_id, data.group) then
                return data.slots, true
            end
        end
    end
    return 35, false 
end

function cRP.getUserProfile()
	local source = source 
	local user_id = Utils.functions.userId(source)
	if not user_id then
		return {
			name = "Unknown",
			name2 = "User",
			id = 0,
			register = "000000",
			phone = "000-0000", 
			photo = "",
			bank = 0,
			dollar = 0,
			weight = 0,
			maxWeight = 100,
			chestWeight = 0,
			chestMaxWeight = 100,
			vipSlots = 35,
			isVip = false
		}
	end
	
	local identity = Utils.functions.userIdentity(user_id)
	if not identity then
		return {
			name = "Unknown",
			name2 = "User",
			id = user_id,
			register = "000000",
			phone = "000-0000", 
			photo = "",
			bank = 0,
			dollar = 0,
			weight = 0,
			maxWeight = 100,
			chestWeight = 0,
			chestMaxWeight = 100,
			vipSlots = 35,
			isVip = false
		}
	end
	
	local photo = Utils.functions.query("getPhoto", { id = user_id })
	local photoUrl = ""
	if photo and photo[1] and photo[1].photo then
		photoUrl = photo[1].photo
	end
	
	local vipSlots, isVip = cRP.getVip()
	
	return { 
		name = identity["name"] or "Unknown",
		name2 = identity["name2"] or "User",
		id = user_id,
		register = identity["serial"] or "000000",
		phone = identity["phone"] or "000-0000", 
		photo = photoUrl,
		bank = identity["bank"] or 0,
		dollar = 0,
		weight = Utils.functions.inventoryWeight(user_id) or 0,
		maxWeight = Utils.functions.getWeight(user_id) or 100,
		chestWeight = 0,
		chestMaxWeight = 100,
		vipSlots = vipSlots,
		isVip = isVip
	}
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTPERM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestPerm(shopType)
	local source = source
	local user_id = Utils.functions.userId(source)

	if user_id then
		if Config["shops"][shopType] and Config["shops"][shopType]["perm"] ~= nil then
			if not Utils.functions.hasGroup(user_id, Config["shops"][shopType]["perm"]) then
				return false
			end
		end
		return true
	end
	
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- REQUESTSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.requestShop(name)
    local source = source
    local user_id = Utils.functions.userId(source)
    if not user_id then
        return {}, {}, 0, 100, 20, 35, false
    end
    
    local vipSlots, isVip = cRP.getVip()
    local shopSlots = 20
    local slot = 0 
    local inventoryShop = {}

    local function safeImagePath(item)
        local base = Config.imagesProvider or ""
        local idx = itemIndex(item)
        if not idx or idx == "" then
            idx = "default" 
        end
        return base .. idx .. ".png"
    end

    if Config["shops"][name] and Config["shops"][name]["list"] then
        for k, v in pairs(Config["shops"][name]["list"]) do
            slot = slot + 1
            local slotKey = tostring(slot + 199)
            inventoryShop[slotKey] = {
                id = slotKey,
                item = k,
                name = itemName(k) or k,
                peso = itemWeight(k) or 0,
                amount = 1000,
                type = "item",
                description = "Item da loja",
                image = safeImagePath(k),
                price = parseInt(v) or 0
            }
        end
    end

    local inventoryUser = {}
    local inventory = Utils.functions.userInventory(user_id)

    if inventory then
        for k, v in pairs(inventory) do
            if v and v.item then
                local slotNumber = tonumber(k)
                
                if isValidSlot(slotNumber, isVip) then
                    v["amount"] = parseInt(v["amount"]) or 0
                    v["name"] = itemName(v["item"]) or v["item"]
                    v["peso"] = itemWeight(v["item"]) or 0
                    v["type"] = "item"
                    v["description"] = "Item do inventário"
                    v["image"] = safeImagePath(v["item"])
                    v["id"] = tostring(k)

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

                    inventoryUser[tostring(k)] = v 
                end
            end
        end
    end

    local currentWeight = Utils.functions.inventoryWeight(user_id) or 0
    local maxWeight = Utils.functions.getWeight(user_id) or 100

    return inventoryShop, inventoryUser, parseInt(currentWeight), parseInt(maxWeight), shopSlots, vipSlots, isVip
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- GETSHOPTYPE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.getShopType(name)
	if Config["shops"][name] then
		return Config["shops"][name]["mode"]
	end
	return "Buy"
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.functionShops(shopType, shopItem, shopAmount, slot, mode)
	local source = source
	local user_id = Utils.functions.userId(source)

	if not user_id then
		return false
	end
	
	if not Config["shops"][shopType] then
		return false
	end

	local vipSlots, isVip = cRP.getVip()
	local slotNumber = tonumber(slot)

	if (mode == "buy" or mode == "use") and not isValidSlot(slotNumber, isVip) then
		Utils.functions.notify(source, "Slot não disponível para seu nível de acesso.")
		return false
	end

	
	if shopAmount == nil then
		shopAmount = 1
	end

	if shopAmount <= 0 then
		shopAmount = 1
	end
	
	local inventory = Utils.functions.userInventory(user_id)
	if not inventory then
		return false
	end

	if inventory[tostring(slot)] and inventory[tostring(slot)]["item"] == shopItem or inventory[tostring(slot)] == nil then
		TriggerClientEvent("shop:Update", source)
		
		if (Config["shops"][shopType]["mode"] == "Buy" and mode == "buy") or mode == "use" then
			if Utils.functions.checkMaxItens and Utils.functions.checkMaxItens(user_id, shopItem, shopAmount) then
				Utils.functions.notify(source,"Limite atingido.")
				vCLIENT.updateShops(source, "requestShop")
				return false
			end

			local currentWeight = Utils.functions.inventoryWeight(user_id)
			local itemWeightTotal = itemWeight(shopItem) * parseInt(shopAmount)
			local maxWeight = Utils.functions.getWeight(user_id)

			if currentWeight + itemWeightTotal <= maxWeight then
				if Config["shops"][shopType]["type"] == "Cash" then
					if Config["shops"][shopType]["list"][shopItem] then
						local itemPrice = Config["shops"][shopType]["list"][shopItem] * shopAmount
						
						if mode == "use" then
							if Utils.functions.tryGetInventoryItem(user_id, shopItem, parseInt(shopAmount), true, slot) then
								TriggerClientEvent("sounds:source", source, "cash", 0.1)
								return true
							end
						else
							if Utils.functions.paymentFull(user_id, itemPrice) then
								if shopItem == "identity" or string.sub(shopItem, 1, 5) == "badge" then
									Utils.functions.generateItem(user_id, shopItem .. "-" .. user_id, parseInt(shopAmount), false, slot)
								elseif shopItem == "briefcase" then
									if not exports["black_maleta"] then
										Utils.functions.generateItem(user_id, "dollars", itemPrice, false)
										return false
									end

									local success, briefCaseId = pcall(function()
										return exports["black_maleta"]:generateBriefId()
									end)

									if not success or not briefCaseId then
										Utils.functions.generateItem(user_id, "dollars", itemPrice, false)
										return false
									end

									Utils.functions.generateItem(user_id, shopItem.."-"..briefCaseId, parseInt(shopAmount), false, slot)

								elseif shopItem == "boxwine" then
									if not exports["black_maleta"] then
										Utils.functions.generateItem(user_id, "dollars", itemPrice, false)
										return false
									end

									local success, briefCaseId = pcall(function()
										return exports["black_maleta"]:generateBriefId()
									end)

									if not success or not briefCaseId then
										Utils.functions.generateItem(user_id, "dollars", itemPrice, false)
										return false
									end

									Utils.functions.generateItem(user_id, shopItem.."-"..briefCaseId, parseInt(shopAmount), false, slot)

								elseif shopItem == "fidentity" then
									local identity = Utils.functions.userIdentity(user_id)

									if identity then
										if identity["sex"] == "M" then
											Utils.functions.execute("fidentity/newIdentity", {
												name = nameMale[math.random(#nameMale)],
												name2 = userName2[math.random(#userName2)],
												locate = userLocate[math.random(#userLocate)],
												blood = math.random(4)
											})
										else
											Utils.functions.execute("fidentity/newIdentity", {
												name = nameFemale[math.random(#nameFemale)],
												name2 = userName2[math.random(#userName2)],
												locate = userLocate[math.random(#userLocate)],
												blood = math.random(4)
											})
										end

										local identity = Utils.functions.userIdentity(user_id)
										local consult = Utils.functions.query("fidentity/lastIdentity")

										if consult[1] then
											Utils.functions.generateItem(user_id, shopItem .. "-" .. consult[1]["id"], parseInt(shopAmount), false, slot)
											if exports["logsystem"] then
												local args = {["1"] = shopItem .. "-" .. consult[1]["id"],["2"] = shopAmount}
												exports["logsystem"]:SendLog("ShopBuyItem",user_id,nil,args)
											end
										end
									end
								else
									Utils.functions.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
								end
								
								if exports["logsystem"] then
									local args = {["1"] = shopItem,["2"] = shopAmount}
									CreateThread(function()
										exports["logsystem"]:SendLog("ShopBuyItem",user_id,nil,args)
									end)
								end
								
								TriggerClientEvent("sounds:source", source, "cash", 0.1)
								return true
							else
								Utils.functions.notify(source,"Dólares insuficientes.")
								return false
							end
						end
					end
				elseif Config["shops"][shopType]["type"] == "Consume" then
					if Utils.functions.tryGetInventoryItem(user_id, Config["shops"][shopType]["item"], parseInt(Config["shops"][shopType]["list"][shopItem] * shopAmount)) then
						Utils.functions.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
						TriggerClientEvent("sounds:source", source, "cash", 0.1)
						Utils.functions.logSystem(user_id,shopItem,shopAmount)
						return true
					else
						Utils.functions.notify(source, 
							"" .. Utils.functions.itemName(Config["shops"][shopType]["item"]) .. " insuficiente.")
						return false
					end
				elseif Config["shops"][shopType]["type"] == "Premium" then
					if Utils.functions.paymentGems(user_id, Config["shops"][shopType]["list"][shopItem] * shopAmount) then
						Utils.functions.generateItem(user_id, shopItem, parseInt(shopAmount), false, slot)
						TriggerClientEvent("sounds:source", source, "cash", 0.1)
						Utils.functions.notify(source,
							"Comprou " ..
							parseFormat(shopAmount) ..
							"x " ..
							Utils.functions.itemName(shopItem) ..
							"por " .. parseFormat(Config["shops"][shopType]["list"][shopItem] * shopAmount) .. " Gemas.")
						Utils.functions.logSystem(user_id,shopItem,shopAmount)
						return true
					else
						Utils.functions.notify(source,"<b>Gemas</b> insuficientes.")
						return false
					end
				end
			else
				Utils.functions.notify(source,"Mochila cheia.")
				return false
			end
		elseif Config["shops"][shopType]["mode"] == "Sell" and mode == "sell" then
			local splitName = splitString(shopItem, "-")

			if Config["shops"][shopType]["list"][splitName[1]] then
				local itemPrice = Config["shops"][shopType]["list"][splitName[1]]

				if itemPrice > 0 then
					if Utils.functions.checkBroken and Utils.functions.checkBroken(shopItem) then
						if exports["logsystem"] then
							local args = {["1"] = shopItem,["2"] = shopAmount}
							exports["logsystem"]:SendLog("ShopSellItem",user_id,nil,args)
						end
						Utils.functions.notify(source,"Itens quebrados não podem ser vendidos.")
						vCLIENT.updateShops(source, "requestShop")
						TriggerClientEvent("shop:Update", source)
						return false
					end
				end

				if Config["shops"][shopType]["type"] == "Cash" then
					if Utils.functions.tryGetInventoryItem(user_id, shopItem, parseInt(shopAmount), true, slot) then
						if itemPrice > 0 then
							Utils.functions.generateItem(user_id, "dollars", parseInt(itemPrice * shopAmount), false)
							TriggerClientEvent("sounds:source", source, "cash", 0.1)
							Utils.functions.logSystem(user_id,shopItem,shopAmount)
						end
						return true
					end
				elseif Config["shops"][shopType]["type"] == "Consume" then
					if Utils.functions.tryGetInventoryItem(user_id, shopItem, parseInt(shopAmount), true, slot) then
						if itemPrice > 0 then
							Utils.functions.generateItem(user_id, Config["shops"][shopType]["item"], parseInt(itemPrice * shopAmount), false)
							TriggerClientEvent("sounds:source", source, "cash", 0.1)
							Utils.functions.logSystem(user_id,shopItem,shopAmount)
						end
						return true
					end
				end
			end
		end
	end

	vCLIENT.updateShops(source, "requestShop")
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterNetEvent("shops:populateSlot")
AddEventHandler("shops:populateSlot", function(nameItem, slot, target, amount)
	local source = source
	local user_id = Utils.functions.userId(source)

	if user_id then
		if amount == nil then
			amount = 1
		end

		if amount <= 0 then
			amount = 1
		end

		if Utils.functions.tryGetInventoryItem(user_id, nameItem, amount, false, slot) then
			Utils.functions.giveItem(user_id, nameItem, amount, false, target)
			vCLIENT.updateShops(source, "requestShop")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POPULATESLOT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("shops:updateSlot")
AddEventHandler("shops:updateSlot", function(nameItem, slot, target, amount)
	local source = source
	local user_id = Utils.functions.userId(source)

	if user_id then
		if amount == nil then
			amount = 1
		end

		if amount <= 0 then
			amount = 1
		end

		local inventory = Utils.functions.userInventory(user_id)

		if inventory and inventory[tostring(slot)] and inventory[tostring(target)] and inventory[tostring(slot)]["item"] == inventory[tostring(target)]["item"] then
			Utils.functions.invUpdate(user_id, slot, target, amount)
		else
			Utils.functions.swapSlot(user_id, slot, target)
		end

		vCLIENT.updateShops(source, "showNUI")
	end
end)
