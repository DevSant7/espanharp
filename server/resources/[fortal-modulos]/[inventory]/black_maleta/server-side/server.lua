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
Tunnel.bindInterface("black_maleta", cRP)
clientAPI = Tunnel.getInterface("black_maleta")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VIP Groups Configuration
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
        -- VIP: todos os slots 1-53 são válidos
        return slotNumber >= 1 and slotNumber <= 53
    else
        -- Não-VIP: apenas slots 1-35 são válidos
        return slotNumber >= 1 and slotNumber <= 35
    end
end

-- Função para verificar VIP
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
vRP.prepare("createPhoto", [[ALTER TABLE characters ADD IF NOT EXISTS (photo LONGTEXT)]])
vRP.prepare("getPhoto", "SELECT photo FROM characters WHERE id = @id")
vRP.prepare("updatePhoto", "UPDATE characters SET photo = @photo WHERE id = @id")

CreateThread(function()
	vRP.execute("createPhoto")
end)

function cRP.getUserProfile()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.userIdentity(user_id)
		if identity then
			return {
				name = identity["name"] or "",
				name2 = identity["name2"] or "",
				passport = user_id,
				register = identity["serial"] or "",
				phone = identity["phone"] or "",
				photo = identity["photo"] or ""
			}
		end
	end
	return {}
end

function cRP.openBriefCase(briefcaseId)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if not source or source == 0 then
		return {}, {}, 0, 100, 0, 100, 35, false
	end
	
	if not user_id then
		return {}, {}, 0, 100, 0, 100, 35, false
	end
	
	if not briefcaseId then
		return {}, {}, 0, 100, 0, 100, 35, false
	end
	
	local myInventory = {}
	local inventory = vRP.userInventory(user_id) or {}

	-- Get VIP info
	local maxSlots, isVip = cRP.getVip()

	for k, v in pairs(inventory) do
		local slotNum = tonumber(k)
		if slotNum and isValidSlot(slotNum, isVip) then
			v["amount"] = parseInt(v["amount"]) or 1
			v["name"] = itemName(v["item"]) or "Unknown Item"
			v["peso"] = itemWeight(v["item"]) or 1
			v["index"] = itemIndex(v["item"]) or v["item"]
			v["max"] = itemMaxAmount(v["item"]) or 999
			v["url"] = Config.imagesProvider .. (itemIndex(v["item"]) or v["item"]) .. ".png"
			v["type"] = "item"
			v["desc"] = itemDescription(v["item"]) or "No description"
			v["key"] = v["item"]
			v["slot"] = slotNum
			v["id"] = tostring(slotNum)

			local splitName = splitString(v["item"], "-")
			if splitName and splitName[2] then
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

			myInventory[#myInventory + 1] = v
		end
	end

	local myChest = {}
	local chestKey = "briefcase:" .. tostring(briefcaseId)
	local result = vRP.getSrvdata(chestKey) or {}

	-- Modificação: trabalhar com slots 1-6 da maleta
	for k, v in pairs(result) do
		local slotNum = tonumber(k)
		if slotNum and slotNum >= 1 and slotNum <= 6 then
			v["amount"] = parseInt(v["amount"]) or 1
			v["name"] = itemName(v["item"]) or "Unknown Item"
			v["peso"] = itemWeight(v["item"]) or 1
			v["index"] = itemIndex(v["item"]) or v["item"]
			v["max"] = itemMaxAmount(v["item"]) or 999
			v["url"] = Config.imagesProvider .. (itemIndex(v["item"]) or v["item"]) .. ".png"
			v["type"] = "item"
			v["desc"] = itemDescription(v["item"]) or "No description"
			v["key"] = v["item"]
			v["slot"] = slotNum
			v["id"] = tostring(k)

			local splitName = splitString(v["item"], "-")
			if splitName and splitName[2] then
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
			myChest[#myChest + 1] = v
		end
	end
	
	local invWeight = vRP.inventoryWeight(user_id) or 0
	local maxWeight = vRP.getWeight(user_id) or 100
	local chestWeight = vRP.chestWeight(result) or 0
	local chestMaxWeight = parseInt(Config.briefcaseWeight) or 100
	
	return myInventory, myChest, invWeight, maxWeight, chestWeight, chestMaxWeight, maxSlots, isVip
end

-- Função simplificada para movimento dentro do inventário
function cRP.moveInventoryItem(fromSlot, toSlot, amount, item, briefcaseId)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id or not briefcaseId then
        return false
    end

    local fromSlotNum = tonumber(fromSlot)
    local toSlotNum = tonumber(toSlot)
    local moveAmount = tonumber(amount) or 1

    if not fromSlotNum or not toSlotNum then
        return false
    end

    local inventory = vRP.userInventory(user_id) or {}
    local fromItem = inventory[tostring(fromSlotNum)]
    local toItem = inventory[tostring(toSlotNum)]

    if not fromItem or fromItem.item ~= item then
        return false
    end

    -- Lógica de movimento
    if not toItem then
        -- Slot de destino vazio
        if moveAmount >= fromItem.amount then
            if vRP.tryGetInventoryItem(user_id, fromItem.item, fromItem.amount, false, fromSlotNum) then
                vRP.giveInventoryItem(user_id, fromItem.item, fromItem.amount, false, toSlotNum)
            end
        else
            if vRP.tryGetInventoryItem(user_id, fromItem.item, moveAmount, false, fromSlotNum) then
                vRP.giveInventoryItem(user_id, fromItem.item, moveAmount, false, toSlotNum)
            end
        end
    elseif toItem.item ~= fromItem.item then
        -- Itens diferentes - trocar posições
        if vRP.tryGetInventoryItem(user_id, fromItem.item, fromItem.amount, false, fromSlotNum) and
           vRP.tryGetInventoryItem(user_id, toItem.item, toItem.amount, false, toSlotNum) then
            vRP.giveInventoryItem(user_id, fromItem.item, fromItem.amount, false, toSlotNum)
            vRP.giveInventoryItem(user_id, toItem.item, toItem.amount, false, fromSlotNum)
        end
    else
        -- Mesmo item - combinar
        if moveAmount >= fromItem.amount then
            if vRP.tryGetInventoryItem(user_id, fromItem.item, fromItem.amount, false, fromSlotNum) then
                vRP.giveInventoryItem(user_id, fromItem.item, fromItem.amount, false, toSlotNum)
            end
        else
            if vRP.tryGetInventoryItem(user_id, fromItem.item, moveAmount, false, fromSlotNum) then
                vRP.giveInventoryItem(user_id, fromItem.item, moveAmount, false, toSlotNum)
            end
        end
    end

    -- Atualizar interface
    local myInventory, myChest, invPeso, invMaxpeso, chestPeso, chestMaxpeso, maxSlots, isVip = cRP.openBriefCase(briefcaseId)
    TriggerClientEvent("briefcase:UpdateInventory", source, myInventory, maxSlots, isVip)
    TriggerClientEvent("briefcase:UpdateChest", source, myChest)
    TriggerClientEvent("briefcase:UpdateWeight", source, invPeso, invMaxpeso, chestPeso, chestMaxpeso)

    return true
end

-- Função simplificada para movimento dentro da maleta
function cRP.moveBriefcaseItem(fromSlot, toSlot, amount, item, briefcaseId)
    local source = source
    local user_id = vRP.getUserId(source)

    if not user_id or not briefcaseId then
        return false
    end

    local fromSlotNum = tonumber(fromSlot)
    local toSlotNum = tonumber(toSlot)
    local moveAmount = tonumber(amount) or 1

    if not fromSlotNum or not toSlotNum then
        return false
    end

    if fromSlotNum < 1 or fromSlotNum > 6 or toSlotNum < 1 or toSlotNum > 6 then
        return false
    end

    local chestKey = "briefcase:" .. tostring(briefcaseId)
    local chestData = vRP.getSrvdata(chestKey) or {}

    local fromChestItem = chestData[tostring(fromSlotNum)]
    local toChestItem = chestData[tostring(toSlotNum)]

    if not fromChestItem or fromChestItem.item ~= item then
        return false
    end

    -- Lógica de movimento
    if not toChestItem then
        -- Slot de destino vazio
        if moveAmount >= fromChestItem.amount then
            chestData[tostring(toSlotNum)] = fromChestItem
            chestData[tostring(fromSlotNum)] = nil
        else
            chestData[tostring(toSlotNum)] = { item = fromChestItem.item, amount = moveAmount }
            fromChestItem.amount = fromChestItem.amount - moveAmount
        end
    elseif toChestItem.item ~= fromChestItem.item then
        -- Itens diferentes - trocar posições
        chestData[tostring(fromSlotNum)], chestData[tostring(toSlotNum)] = toChestItem, fromChestItem
    else
        -- Mesmo item - combinar
        if moveAmount >= fromChestItem.amount then
            toChestItem.amount = toChestItem.amount + fromChestItem.amount
            chestData[tostring(fromSlotNum)] = nil
        else
            toChestItem.amount = toChestItem.amount + moveAmount
            fromChestItem.amount = fromChestItem.amount - moveAmount
        end
    end

    vRP.setSrvdata(chestKey, chestData)

    -- Atualizar interface
    local myInventory, myChest, invPeso, invMaxpeso, chestPeso, chestMaxpeso, maxSlots, isVip = cRP.openBriefCase(briefcaseId)
    TriggerClientEvent("briefcase:UpdateInventory", source, myInventory, maxSlots, isVip)
    TriggerClientEvent("briefcase:UpdateChest", source, myChest)
    TriggerClientEvent("briefcase:UpdateWeight", source, invPeso, invMaxpeso, chestPeso, chestMaxpeso)

    return true
end

function cRP.storeItem(nameItem, slot, amount, target, briefCaseId)
	local source = source
	local user_id = vRP.getUserId(source)
	
	if not source or not user_id then
		return
	end
	
	if briefCaseId then
		local splitName = splitString(nameItem, "-")
		if splitName and (splitName[1] == "briefcase" or splitName[1] == "boxwine") then 
			return 
		end 

		local chestSlot = tonumber(target)

		if chestSlot < 1 or chestSlot > 6 then
			return
		end

		local chestKey = "briefcase:" .. tostring(briefCaseId)

		if vRP.storeChest(user_id, chestKey, amount, parseInt(Config.briefcaseWeight) or 100, slot, chestSlot) then

		else
			local result = vRP.getSrvdata(chestKey) or {}
			TriggerClientEvent("briefcase:UpdateWeight", source, vRP.inventoryWeight(user_id), vRP.getWeight(user_id), vRP.chestWeight(result), parseInt(Config.briefcaseWeight) or 100)
		end

		local myInventory, myChest, invPeso, invMaxpeso, chestPeso, chestMaxpeso, maxSlots, isVip = cRP.openBriefCase(briefCaseId)
		TriggerClientEvent("briefcase:UpdateInventory", source, myInventory, maxSlots, isVip)
		TriggerClientEvent("briefcase:UpdateChest", source, myChest)
		TriggerClientEvent("briefcase:UpdateWeight", source, invPeso, invMaxpeso, chestPeso, chestMaxpeso)
	end
end

function cRP.takeItem(nameItem, slot, amount, target, briefCaseId)
	local source = source
	local user_id = vRP.getUserId(source)

	if not source or not user_id then
		return
	end

	if briefCaseId then
		local chestSlot = tonumber(slot)

		if chestSlot < 1 or chestSlot > 6 then
			return
		end
		
		local chestKey = "briefcase:" .. tostring(briefCaseId)
		
		if vRP.tryChest(user_id, chestKey, amount, chestSlot, target) then

		else
			local result = vRP.getSrvdata(chestKey) or {}
			TriggerClientEvent("briefcase:UpdateWeight", source, vRP.inventoryWeight(user_id), vRP.getWeight(user_id), vRP.chestWeight(result), parseInt(Config.briefcaseWeight) or 100)
		end

		local myInventory, myChest, invPeso, invMaxpeso, chestPeso, chestMaxpeso, maxSlots, isVip = cRP.openBriefCase(briefCaseId)
		TriggerClientEvent("briefcase:UpdateInventory", source, myInventory, maxSlots, isVip)
		TriggerClientEvent("briefcase:UpdateChest", source, myChest)
		TriggerClientEvent("briefcase:UpdateWeight", source, invPeso, invMaxpeso, chestPeso, chestMaxpeso)
	end
end

math.randomseed(os.time()) 

local function generateBriefId()
    local numbers = {}
    local result = ""

    for i = 1, 50 do
        table.insert(numbers, i)
    end

    for i = 1, 7 do
        local index = math.random(#numbers) 
        result = result .. numbers[index]
        table.remove(numbers, index) 
    end

    return result
end

exports("generateBriefId", generateBriefId)
