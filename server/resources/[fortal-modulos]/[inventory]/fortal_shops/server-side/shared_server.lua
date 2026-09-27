local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Utils = {}

Utils.functions = {
    prepare = function(...)
        vRP.prepare(...)
    end,
    query = function(...)
        return vRP.query(...)
    end,
    execute = function(...)
        return vRP.execute(...)
    end,
    userId = function(src)
        return vRP.getUserId(src)
    end,
    userIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    invUpdate = function(user_id,slot,target, amount)
        return vRP.invUpdate(user_id, slot, target, amount)
    end,
    tryGetInventoryItem = function(user_id,item,amount)
        return vRP.tryGetInventoryItem(user_id,item,amount,true)
    end,
    giveItem = function(user_id,item,amount,slot)
        return vRP.giveInventoryItem(user_id,item,amount,true,slot)
    end,
    generateItem = function(user_id,item,amount,notify,slot)
        return vRP.generateItem(user_id,item,amount,notify,slot)
    end,
    getWeight = function(user_id)
        return vRP.getWeight(user_id)
    end,
    inventoryWeight = function(user_id)
        return vRP.inventoryWeight(user_id)
    end,
    hasGroup = function(user_id,group)
        return vRP.hasGroup(user_id,group)
    end,
    getFines = function(user_id)
        return vRP.getFines(user_id) or 0 
    end,
    paymentFull = function(user_id,amount)
        return vRP.paymentFull(user_id,amount)
    end,
    paymentGems = function(user_id,amount)
        return vRP.paymentGems(user_id,amount)
    end,
    checkBroken = function(item)
        return vRP.checkBroken(item)
    end,
    swapSlot = function(user_id,slot,target)
        return vRP.swapSlot(user_id,slot,target)
    end,
    userInventory = function(user_id)
        return vRP.userInventory(user_id)
    end,
    checkMaxItens = function(user_id,item,amount)
        return vRP.checkMaxItens(user_id,item,amount)
    end,
    notify = function(source,message)
        TriggerClientEvent("Notify",source,"verde",message,5000)
    end,
    sounds = function(source)
        return TriggerClientEvent("sounds:source", source, "cash", 0.1)
    end,
    logSystem = function(user_id,item,amount)
        -- sistema de logs aqui
    end
}

RegisterNetEvent("shops:divingSuit")
AddEventHandler("shops:divingSuit", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>Roupa de Mergulho</b> por <b>$975</b>?") then
			if vRP.paymentFull(user_id, 975) then
				vRP.generateItem(user_id, "divingsuit", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:coffeeMachine")
AddEventHandler("shops:coffeeMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>Café</b> por <b>$200</b>?") then
			if vRP.paymentFull(user_id, 200) then
				vRP.generateItem(user_id, "coffee", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:donutMachine")
AddEventHandler("shops:donutMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>Donut</b> por <b>$150</b>?") then
			if vRP.paymentFull(user_id, 150) then
				vRP.generateItem(user_id, "donut", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:sodaMachine")
AddEventHandler("shops:sodaMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>Soda</b> por <b>$150</b>?") then
			if vRP.paymentFull(user_id, 150) then
				vRP.generateItem(user_id, "soda", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:burgerMachine")
AddEventHandler("shops:burgerMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>hamburger</b> por <b>$150</b>?") then
			if vRP.paymentFull(user_id, 150) then
				vRP.generateItem(user_id, "hamburger", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:hotdogMachine")
AddEventHandler("shops:hotdogMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>hotdog</b> por <b>$150</b>?") then
			if vRP.paymentFull(user_id, 150) then
				vRP.generateItem(user_id, "hotdog", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

RegisterNetEvent("shops:shops:waterMachine")
AddEventHandler("shops:shops:waterMachine", function()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.request(source, "Comprar <b>Agua</b> por <b>$150</b>?") then
			if vRP.paymentFull(user_id, 150) then
				vRP.generateItem(user_id, "water", 1, true)
			else
				TriggerClientEvent("Notify", source, "cancel", "Negado", "Dólares insuficientes.", "vermelho", 3000)
			end
		end
	end
end)

Utils.functions.prepare("createPhoto", [[ALTER TABLE characters ADD IF NOT EXISTS (photo LONGTEXT)]])
Utils.functions.prepare("getPhoto", "SELECT photo FROM characters WHERE id = @id")
Utils.functions.prepare("updatePhoto", "UPDATE characters SET photo = @photo WHERE id = @id")
