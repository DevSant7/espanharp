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
    getNearestPlayer = function(source,dist)
        return vRPC.nearestPlayer(source,dist)
    end,
    getUserId = function(source)
        return vRP.getUserId(source)
    end,    
    hasPermission = function(user_id,perm)
        return vRP.hasGroup(user_id,perm)
    end,
    numPermission = function(perm)
        local result = vRP.numPermission(perm)
        return #result 
    end,
    getUsers = function()
        return vRP.getPlayesOn()
    end,
    getUserInventory = function(user_id)
        return vRP.userInventory(user_id)
    end, 
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    getUserSource = function(user_id)
        return vRP.userSource(user_id)
    end,
    getUserName = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        if identity then 
            return identity["name"].." "..identity["name2"]
        end
    end,
    getUserPhone = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        if identity then 
            return identity["phone"]
        end
    end,
    getUserState = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        if identity then 
            return identity["state"]
        end
    end,
    playTime = function(user_id)
        local result = Utils.functions.query('black/getLevelDay', {user_id = user_id})
        
        if result and result[1] and result[1]['playTime'] then
            return result[1]['playTime']
        end
    
        return 0 
    end,
    getTopCompliments = function()
        return exports["coreP"]:getTopCompliments() 
    end,
    getUserJob = function(user_id)
        for job, jobName in pairs(Config.jobs) do
            if vRP.hasGroup(user_id, job) then
                return jobName
            end
        end
        return nil 
    end,
    getUserVip = function(user_id)
        for vip, vipName in pairs(Config.vips) do
            if vRP.hasGroup(user_id, vip) then
                return {
                    stats = vipName,
                    time = "30"
                }
            end
        end
        return {
            stats = "Não possui",
            time = "0"
        }
    end,
    getVip = function(user_id)
        for vip, _ in pairs(Config.premium) do
            if vRP.hasGroup(user_id, vip) then
                return {
                    stats = true,
                    time = "30"
                }
            end
        end
        return {
            stats = false,
            time = "0"
        }
    end,
    getUserImage = function(user_id)
        return "http://104.234.63.114/inventory/logo.png"
    end,
    getUserBank = function(user_id)
        return parseFormat(vRP.getBank(user_id))
    end,
    getUserCoins = function(user_id)
        return parseFormat(vRP.userGemstone(user_id))
    end,
    giveItem = function(user_id,item,amount,slot)
        return vRP.giveInventoryItem(user_id,item,amount,slot,false)
    end,
    remItem  = function(user_id,item,amount) 
        return vRP.tryGetInventoryItem(user_id,item,amount,false) 
    end,
    setData = function (user_id, key, value)
        vRP.setDatatable(user_id, key, value)
    end,
    saveUser = function(user_id,lastCoords,lastHealth,lastArmour,inventory)
        local dataTable = vRP.query("playerdata/getUserdata", { user_id = user_id, key = "Datatable" })

        if dataTable[1] then
            dataTable = json.decode(dataTable[1].dvalue)

            dataTable["armour"]    = lastArmour
            dataTable["health"]    = lastHealth
            dataTable["inventory"] = inventory 


            vRP.execute("playerdata/setUserdata",{ user_id = user_id, key = "Datatable", value = json.encode(dataTable) })
        end

        vRP.execute("playerdata/setUserdata", { user_id = user_id, key = "Position", value = json.encode({ x = lastCoords["x"], y = lastCoords["y"], z = lastCoords["z"] }) })
    end,
    bypassAC = function(source)

    end,
    syncGarages = function(plate)
        TriggerEvent("engine:tryFuel",plate,100)
		TriggerEvent("plateEveryone",plate)
    end,
    createVehicle = function(user_id,source,model,x,y,z,heading,bucket)
        local userPed = GetPlayerPed(source)
        local mHash = GetHashKey(model)
        local myVeh = CreateVehicle(mHash,x,y,z,heading,true,true)
        local vehPlate = vRP.generatePlate()
        while not DoesEntityExist(myVeh) do
            Wait(1000)
        end
    
        if DoesEntityExist(myVeh) then
            local vehNet = NetworkGetNetworkIdFromEntity(myVeh)
            SetPedIntoVehicle(userPed, myVeh, -1)
            SetVehicleNumberPlateText(myVeh,vehPlate)
            SetEntityRoutingBucket(myVeh,bucket)
            Utils.functions.syncGarages(vehPlate)

            return myVeh,vehNet
        end
    end,
    prompt  = function(source,message)
        return vRP.prompt(source,message, "ID")
    end,
    request = function(source,message,timer)
        return vRP.request(source,message)
    end,
    notify  = function(source,message)
        return TriggerClientEvent("Notify",source,"aviso",message,5000)
    end ,
    chatMessage = function(source, author, message)
        TriggerClientEvent("black:addChatMessage", -1, author, message, "Amor") 
    end,
    generatePlate = function()
        return vRP.generatePlate()
    end
}

