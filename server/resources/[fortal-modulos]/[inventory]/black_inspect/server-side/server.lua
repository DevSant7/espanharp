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
Tunnel.bindInterface("inspect",cRP)
vCLIENT = Tunnel.getInterface("inspect")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local openPlayer = {}
local openSource = {}

-- VIP Groups Configuration
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
        -- Não-VIP: slots 1-40 são válidos (mudança de 35 para 40)
        return slotNumber >= 1 and slotNumber <= 40
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
    return 40, false  -- Mudança de 35 para 40
end

-- Função para verificar VIP de outro jogador
local function getPlayerVip(user_id)
    if user_id then
        for _, data in ipairs(vipGroups) do
            if vRP.hasGroup(user_id, data.group) then
                return data.slots, true
            end
        end
    end
    return 40, false  -- Mudança de 35 para 40
end

-- Função para formatar peso
local function formatWeight(weight)
    return math.floor((weight or 0) * 100) / 100
end

-- Função para limpar dados do jogador
local function clearPlayerData(user_id)
    if openSource[user_id] then
        local targetSource = openSource[user_id]
        if DoesEntityExist(GetPlayerPed(targetSource)) then
            TriggerClientEvent("player:Commands", targetSource, false)
            TriggerClientEvent("player:playerCarry", targetSource, GetPlayerPed(vRP.getUserSource(user_id)))
        end
        openSource[user_id] = nil
    end
    
    if openPlayer[user_id] then
        openPlayer[user_id] = nil
    end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICE:RUNINSPECT
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
	if not user_id then return nil end
	
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
	return nil
end

RegisterServerEvent("police:runInspect")
AddEventHandler("police:runInspect",function(entity)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id and vRP.getHealth(source) > 101 then
		-- Limpar dados anteriores se existirem
		clearPlayerData(user_id)
		
		if vRP.hasPermission(user_id,Config.inspectPermission) or vRP.getHealth(entity[1]) <= 101 or vRP.request(entity[1],"Você aceita ser revistado?") then
			local coordsEntity = GetEntityCoords(GetPlayerPed(entity[1]))
			local coords = GetEntityCoords(GetPlayerPed(source))
			
			local distance = #(coords - coordsEntity)

			if distance <= 1.2 then
				TriggerClientEvent("player:playerCarry",entity[1],source,"handcuff")
				TriggerClientEvent("player:Commands",entity[1],true)
				TriggerClientEvent("inventory:Close",entity[1])
				openPlayer[user_id] = vRP.getUserId(entity[1])
				openSource[user_id] = entity[1]
				vCLIENT.openInspect(source)
			else
				TriggerClientEvent("Notify",source,"important","Atenção","O sujeito esta muito longe.","amarelo",5000)
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand(Config.commandName,function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then return end
	
	local otherPlayer = vRPC.nearestPlayer(source)
	if not otherPlayer then 
		TriggerClientEvent("Notify",source,"vermelho","Nenhum jogador próximo!",5000)
		return 
	end

	-- Limpar dados anteriores se existirem
	clearPlayerData(user_id)

	if vRP.request(otherPlayer,"Você aceita ser revistado?") then
		if user_id and vRP.getHealth(source) > 100 then
			TriggerClientEvent("player:playerCarry",otherPlayer,source,"handcuff")
			TriggerClientEvent("player:Commands",otherPlayer,true)
			TriggerClientEvent("inventory:Close",otherPlayer)
			openPlayer[user_id] = vRP.getUserId(otherPlayer)
			openSource[user_id] = otherPlayer
			vCLIENT.openInspect(source)
		end
	else
		TriggerClientEvent("Notify",source,"vermelho","O indivíduo recusou ser revistado!!",5000)
	end
end)

function cRP.openChest()
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id or not openPlayer[user_id] or not openSource[user_id] then 
		return {}, {}, 0, 0, 0, 0
	end

	-- Verificar se o jogador alvo ainda existe
	if not DoesEntityExist(GetPlayerPed(openSource[user_id])) then
		clearPlayerData(user_id)
		return {}, {}, 0, 0, 0, 0
	end

	-- Get inspector's VIP status
	local inspectorSlots, inspectorIsVip = cRP.getVip()
	
	-- Get target's VIP status
	local targetSlots, targetIsVip = getPlayerVip(openPlayer[user_id])
	
	local myInventory = {}
	local result = vRP.userInventory(user_id)
	if result then
		for k,v in pairs(result) do
			local slotNumber = tonumber(k)
			if isValidSlot(slotNumber, inspectorIsVip) then
				v["amount"] = parseInt(v["amount"])
				v["name"] = itemName(v["item"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["max"] = itemMaxAmount(v["item"])
				v["image"] = Config.imagesProvider..itemIndex(v["item"])..".png"
				v["type"] = "item"
				v["description"] = itemDescription(v["item"])
				v["key"] = v["item"]
				v["slot"] = slotNumber
				v["id"] = k

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

				myInventory[k] = v
			end
		end
	end

	local myChest = {}
	local inventory = vRP.userInventory(openPlayer[user_id])
	if inventory then
		for k,v in pairs(inventory) do
			local slotNumber = tonumber(k)
			if isValidSlot(slotNumber, targetIsVip) then
				v["amount"] = parseInt(v["amount"])
				v["name"] = itemName(v["item"])
				v["peso"] = itemWeight(v["item"])
				v["index"] = itemIndex(v["item"])
				v["max"] = itemMaxAmount(v["item"])
				v["image"] = Config.imagesProvider..itemIndex(v["item"])..".png"
				v["type"] = "item"
				v["description"] = itemDescription(v["item"])
				v["key"] = v["item"]
				v["slot"] = slotNumber
				v["id"] = k

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

				myChest[k] = v
			end
		end
	end

	-- Format weights properly
	local inspectorWeight = formatWeight(vRP.inventoryWeight(user_id))
	local inspectorMaxWeight = formatWeight(vRP.getWeight(user_id))
	local targetWeight = formatWeight(vRP.inventoryWeight(openPlayer[user_id]))
	local targetMaxWeight = formatWeight(vRP.getWeight(openPlayer[user_id]))

	-- Send data to client
	TriggerClientEvent("inspect:updateInventory", source, myInventory, myChest, inspectorWeight, inspectorMaxWeight, targetWeight, targetMaxWeight)

	-- Send info about slots
	TriggerClientEvent("inspect:updateInfo", source, {
		inspectorSlots = inspectorSlots,
		inspectorIsVip = inspectorIsVip,
		targetSlots = targetSlots,
		targetIsVip = targetIsVip
	})

	-- Send profile data
	local identity = vRP.userIdentity(openPlayer[user_id])
	if identity then
		TriggerClientEvent("inspect:updateProfile", source, {
			name = (identity["name"] or "").." "..(identity["name2"] or ""),
			id = openPlayer[user_id],
			image = "",
			dollar = 0,
			bank = 0,
			weight = targetWeight,
			maxWeight = targetMaxWeight,
			loseWeight = targetWeight,
			loseMaxWeight = targetMaxWeight
		})
	end

	return myInventory,myChest,inspectorWeight,inspectorMaxWeight,targetWeight,targetMaxWeight
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.storeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id or not openSource[user_id] or not openPlayer[user_id] then return end

	if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
		if vRP.checkMaxItens(openPlayer[user_id],nameItem,amount) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return
		end

		if (vRP.inventoryWeight(openPlayer[user_id]) + (itemWeight(nameItem) * parseInt(amount))) <= vRP.getWeight(openPlayer[user_id]) then
			if vRP.tryGetInventoryItem(user_id,nameItem,amount,false,slot) then
				vRP.giveInventoryItem(openPlayer[user_id],nameItem,amount,true,target)
				-- Update inventories
				cRP.openChest()
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	else
		clearPlayerData(user_id)
		vCLIENT.closeInspect(source)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.takeItem(nameItem,slot,amount,target)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id or not openSource[user_id] or not openPlayer[user_id] then return end

	if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
		if vRP.checkMaxItens(user_id,nameItem,amount) then
			TriggerClientEvent("Notify",source,"amarelo","Limite atingido.",3000)
			return
		end

		if (vRP.inventoryWeight(user_id) + (itemWeight(nameItem) * parseInt(amount))) <= vRP.getWeight(user_id) then
			if vRP.tryGetInventoryItem(openPlayer[user_id],nameItem,amount,false,slot) then
				vRP.giveInventoryItem(user_id,nameItem,amount,false,target)
				if nameItem == "dollars" then
					vRP.storePolice(amount)
				end
				-- Update inventories
				cRP.openChest()
			end
		else
			TriggerClientEvent("Notify",source,"vermelho","Mochila cheia.",5000)
		end
	else
		clearPlayerData(user_id)
		vCLIENT.closeInspect(source)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESLOT (INSPECTOR'S INVENTORY)
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateSlot(slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id then return end

	-- Esta função atualiza o inventário do próprio inspetor
	if vRP.invUpdate(user_id,slot,target,amount) then
		-- Update inventories
		cRP.openChest()
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECHEST (TARGET'S INVENTORY)
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateChest(slot,target,amount)
	local source = source
	local user_id = vRP.getUserId(source)
	if not user_id or not openSource[user_id] or not openPlayer[user_id] then return end

	if DoesEntityExist(GetPlayerPed(openSource[user_id])) then
		-- Esta função atualiza o inventário da pessoa sendo revistada
		if vRP.invUpdate(openPlayer[user_id],slot,target,amount) then
			-- Update inventories
			cRP.openChest()
		end
	else
		clearPlayerData(user_id)
		vCLIENT.closeInspect(source)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETINSPECT
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.resetInspect()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		clearPlayerData(user_id)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYER DISCONNECT HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('playerDropped', function(reason)
	local source = source
	local user_id = vRP.getUserId(source)
	
	-- Limpar se o jogador que saiu estava sendo revistado
	for inspector_id, target_source in pairs(openSource) do
		if target_source == source then
			clearPlayerData(inspector_id)
			local inspectorSource = vRP.getUserSource(inspector_id)
			if inspectorSource then
				vCLIENT.closeInspect(inspectorSource)
			end
			break
		end
	end
	
	-- Limpar se o jogador que saiu estava revistando alguém
	if user_id and openPlayer[user_id] then
		clearPlayerData(user_id)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- RESOURCE STOP HANDLER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then
		-- Limpar todos os dados quando o resource parar
		for user_id, _ in pairs(openPlayer) do
			clearPlayerData(user_id)
		end
		openPlayer = {}
		openSource = {}
	end
end)
