local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

Utils = {}

Utils.functions = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,
    hasPermission = function(user_id, perm)
        return vRP.hasPermission(user_id, perm)
    end,
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    getUserSource = function(user_id)
        return vRP.userSource(user_id)
    end,
    setPermission = function(user_id, permission, rank)
        return vRP.setPermission(user_id, permission, rank)
    end,
    removePermission = function(user_id, permission)
        return vRP.removePermission(user_id, permission)
    end,
    remPermission = function(user_id, permission)
        return vRP.remPermission(user_id, permission)
    end,
    addFines = function(user_id, value)
        return vRP.addFines(user_id, value)
    end,
    tryPayment = function(user_id, amount)
        return vRP.tryPayment(user_id, amount)
    end,
    getUsers = function()
        return vRP.getUsers()
    end,
    getFines = function(user_id)
        return vRP.getFines(user_id)
    end,
    request = function(source, message)
        return vRP.request(source, message)
    end
}

return Utils
