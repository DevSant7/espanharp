local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

exports('license', function () 
	return "SUA LICENÇA AQUI" 
end)

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
    getUserId = function(source)
        return vRP.getUserId(source)
    end,    
    hasPermission = function(user_id,perm)
        return vRP.hasPermission(user_id,perm)
    end,
    getUserIdentity = function(user_id)
        local identity = vRP.userIdentity(user_id)
        if identity then
            return {
                name = identity["name"].." "..identity["name2"],
                sex = identity.sex,
                number = identity.phone,
                nationality = "Brasileiro",
                bank = identity.bank 
            }
        end
    end,
    getUserName = function(user_id)
        local identity = vRP.userIdentity(user_id)
        if identity then
            return  identity["name"].." "..identity["name2"]
        end
    end,
    getUserSource = function(user_id)
        return vRP.userSource(user_id)
    end,    
    addGroup = function(user_id,group,level)
        return vRP.setPermission(user_id,group,level)
    end,
    remGroup = function(user_id,group)
        return vRP.remPermission(user_id,group)
    end,
    updatePermission = function(user_id,oldPerm,newPerm)
        return vRP.updatePermission(user_id,oldPerm,newPerm)
    end,
    notify = function(source,message)
        return TriggerClientEvent("Notify",source,"aviso",message,5000)
    end,
    request = function(source,message)
        return vRP.request(source,message,5000)
    end,
    depositMethod = function(user_id,value)
        return vRP.paymentFull(user_id,value) 
    end,
    withdrawMethod = function(user_id,value)
        return vRP.generateItem(user_id,"dollars",value,true)
    end,
    checkItem = function(user_id,itemName,itemAmount)
        return vRP.itemAmount(user_id,itemName) >= itemAmount 
    end,
    getOrgChestData = function(chestName)
        local consultChest = vRP.query("chests/getChests",{ name = chestName })
        local result = vRP.getSrvdata("stackChest:"..chestName)
		if consultChest[1] and result then
			return vRP.chestWeight(result),consultChest[1]["weight"]
		end
    end,
    openChest = function(source,chestName)
        return TriggerClientEvent("groupmanager:actions",source,chestName)
    end,
    getItemName = function(item)
        return itemName(item)
    end,
    getInventoryItemSlot = function(user_id,nameItem)
        local r = async()
        local inventory = vRP.userInventory(user_id)
        local splitName = splitString(nameItem,"-")
	    local inventory = vRP.userInventory(user_id)

	    for k,v in pairs(inventory) do
	    	local splitItem = splitString(v["item"],"-")
	    	if splitItem[1] == splitName[1] then
                r(k)
                return r:wait()
            end
        end
        r(nil) 
        return r:wait()
    end,
    setTaskItemsOnChest = function(user_id,chestName,itemName,amount)
        local itemSlot = Utils.functions.getInventoryItemSlot(user_id,itemName)
        -- local consultChest = vRP.query("chests/getChests",{ name = chestName })
        -- if consultChest[1] then
        --     local consultEntity = Utils.functions.query("black/selectData",{ dkey = "stackChest:"..chestName })
        --     if consultEntity and consultEntity[1] then
        --         local entityData = json.decode(consultEntity[1].dvalue)
    
        --         local itemExists = false
        --         for slot,item in pairs(entityData) do
        --             if item.item == itemName then
        --                 item.amount = item.amount + amount
        --                 itemExists = true
        --                 break
        --             end
        --         end
    
        --         if not itemExists then
        --             entityData[itemSlot] = { item = itemName,amount = amount }
        --         end
    
        --         local updatedEntityData = json.encode(entityData)
    
        --         Utils.functions.query("black/setData",{ dkey = "stackChest:"..chestName,dvalue = updatedEntityData })
        --     end
        -- end
        -- vRP.setSrvdata("stackChest:"..chestName,{}) -- DEBUG FUNCTION


        function isTableEmpty(tbl)
            return next(tbl) == nil
        end

        local function findItemOrNextSlot(jsonData, itemName)
            if isTableEmpty(jsonData) then
                return false, "1"
            end
        
            local slotsChecked = {} 
        
            for key, value in pairs(jsonData) do
                table.insert(slotsChecked, key) 
                if value.item == itemName then
                    return true, key 
                end
            end
        
            local newSlot = tostring(#slotsChecked + 1)
            return false, newSlot
        end

        local consultChest = vRP.query("chests/getChests",{ name = chestName })
        if consultChest[1] then
            local result = vRP.getSrvdata("stackChest:"..chestName)
            local found, target = findItemOrNextSlot(result, itemName)
            vRP.storeChest(user_id,"stackChest:"..chestName,amount,consultChest[1]["weight"],itemSlot,target)
        end
    end
}

Utils.functions.prepare("black/selectData","SELECT dvalue FROM entitydata WHERE dkey = @dkey")
Utils.functions.prepare("black/setData","UPDATE entitydata SET dvalue = @dvalue WHERE dkey = @dkey")

AddEventHandler("playerConnect",function(user_id,source)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        TriggerEvent("black-groupmanager:updateLastLogin", user_id)
    end
end) 

AddEventHandler("playerDropped", function(reason)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    if user_id then
        TriggerEvent("black-groupmanager:updateLastLogin", user_id)
    end
end)

function getFormatedDate()
    return os.date("%d/%m/%Y", os.time())
end

exports("saveChestLogs",function(user_id, chestName, action, item, value)
    for k,v in pairs(Config.orgs) do 
        if v.chestName == chestName then 
            Utils.functions.execute("black/insertLog", {
                orgName = k,
                type = "chest",
                user_id = user_id,
                name = Utils.functions.getUserName(user_id),
                action = action,
                item = item,
                value = value,
                date = getFormatedDate()
            })
        end
    end
end)    

--[[ -- abrir o baú (colar no client do chest)
RegisterNetEvent("groupmanager:actions")
AddEventHandler("groupmanager:actions",function(chestName)
	if LocalPlayer["state"]["Route"] < 900000 then
		if vSERVER.Permissions(chestName) and MumbleIsConnected() then
			SetNuiFocus(true,true)
			chestOpen = chestName
			SendNUIMessage({ action = "showMenu" })
		end
	end
end)
]]