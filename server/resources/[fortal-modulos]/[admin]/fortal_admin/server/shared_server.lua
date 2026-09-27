local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")
vKEYBOARD = Tunnel.getInterface("keyboard")

Utils = {}

Utils.functions = {
    prepare = function(...)
        vRP.prepare(...)
    end,
    query = function(...)
        return vRP.query(...)
    end,
    execute = function(...)
        vRP.execute(...)
    end,
    getUserId = function(source)
        return vRP.getUserId(source)
    end,
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    getUserName = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        return identity["name"].." "..identity["name2"]
    end,
    getPlayers = function()
        return vRP.getPlayersOn()
    end,  
    getUserData = function(user_id, key)
        return vRP.userData(user_id, key)
    end,
    getUserSource = function(user_id)
        return vRP.userSource(user_id)
    end,
    getItems = function()
        return itemList()
    end,
    getVehicles = function()
        return vehicleGlobal()
    end,
    addUserGroup = function(user_id, group)
        return vRP.setPermission(user_id, group)
    end,    
    remUserGroup = function(user_id, group)
        return vRP.remPermission(user_id, group)
    end,
    getUserGroups = function(user_id)
        local arr = {}
        local groups = vRP.Groups()
        for permission, _ in pairs(groups) do
            if vRP.hasPermission(user_id, permission) then
                arr[#arr + 1] = permission
            end
        end
        return arr
    end,
    createVehicle = function(user_id, source, model, x, y, z, heading)
        local mHash = GetHashKey(model)
        local myVeh = CreateVehicle(mHash, x, y, z, heading, true, true)
        local playerPed = GetPlayerPed(source)
        local vehPlate = "ADM" .. math.random(10000, 99999)
        
        while not DoesEntityExist(myVeh) do
            Wait(1000)
        end

        if DoesEntityExist(myVeh) then
            SetVehicleNumberPlateText(myVeh, vehPlate)
            SetPedIntoVehicle(playerPed, myVeh, -1)
            -- Sincronizar com garagens se necessário
            TriggerEvent("engine:tryFuel", vehPlate, 100)
            TriggerEvent("plateEveryone", vehPlate)
        end
        
        return myVeh
    end,
}
